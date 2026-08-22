-- Send Email Auth Hook: 6-digit OTPs for signup, password recovery, and email change.
-- Uses Resend so Auth emails are not subject to Supabase's built-in mailer rate limit.
--
-- Register in Dashboard: Authentication > Hooks > Send Email
--   Postgres function: public.send_email
--
-- Required Vault secret:
--   select vault.create_secret('re_xxxxxxxx', 'resend_api_key');
-- Optional Vault secret (verified domain sender):
--   select vault.create_secret('Rifq <noreply@yourdomain.com>', 'resend_from_email');

create extension if not exists pg_net;

create schema if not exists auth_hooks;

revoke all on schema auth_hooks from public, anon, authenticated;
grant usage on schema auth_hooks to postgres, supabase_auth_admin;

create table if not exists auth_hooks.email_log (
  id uuid primary key default gen_random_uuid(),
  email_action_type text not null,
  recipient text not null,
  status text not null,
  error text,
  request_id bigint,
  created_at timestamptz not null default now()
);

alter table auth_hooks.email_log enable row level security;

revoke all on table auth_hooks.email_log from public, anon, authenticated;
grant all on table auth_hooks.email_log to postgres, supabase_auth_admin;

create or replace function auth_hooks.otp_email_html(
  p_title text,
  p_intro text,
  p_otp text
)
returns text
language sql
immutable
set search_path = ''
as $$
  select format(
    $html$
    <div style="font-family:Arial,Helvetica,sans-serif;max-width:480px;margin:0 auto;padding:32px 24px;background:#ffffff;color:#333333">
      <h1 style="margin:0 0 8px;font-size:24px;color:#2D8E80">Rifq</h1>
      <h2 style="margin:0 0 16px;font-size:20px;font-weight:500;color:#20655B">%s</h2>
      <p style="margin:0 0 16px;font-size:15px;line-height:1.5;color:#4A4A4A">%s</p>
      <p style="margin:24px 0;padding:16px 0;text-align:center;font-size:32px;letter-spacing:10px;font-weight:700;color:#20655B;background:#BBE9E3;border-radius:12px">%s</p>
      <p style="margin:0;font-size:13px;line-height:1.5;color:#777777">This code expires shortly. If you did not request it, you can ignore this email.</p>
    </div>
    $html$,
    p_title,
    p_intro,
    p_otp
  );
$$;

create or replace function auth_hooks.get_resend_api_key()
returns text
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_key text;
begin
  select ds.decrypted_secret
    into v_key
  from vault.decrypted_secrets as ds
  where ds.name = 'resend_api_key'
  limit 1;

  if v_key is null or btrim(v_key) = '' then
    raise exception 'Missing Vault secret resend_api_key';
  end if;

  return btrim(v_key);
end;
$$;

create or replace function auth_hooks.get_from_email()
returns text
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_from text;
begin
  select ds.decrypted_secret
    into v_from
  from vault.decrypted_secrets as ds
  where ds.name = 'resend_from_email'
  limit 1;

  if v_from is null or btrim(v_from) = '' then
    return 'Rifq <onboarding@resend.dev>';
  end if;

  return btrim(v_from);
end;
$$;

create or replace function auth_hooks.send_resend_email(
  p_to text,
  p_subject text,
  p_html text,
  p_text text,
  p_action_type text
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_request_id bigint;
begin
  if p_to is null or btrim(p_to) = '' then
    raise exception 'Missing recipient email for %', p_action_type;
  end if;

  select net.http_post(
    url := 'https://api.resend.com/emails',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' || auth_hooks.get_resend_api_key()
    ),
    body := jsonb_build_object(
      'from', auth_hooks.get_from_email(),
      'to', array[p_to],
      'subject', p_subject,
      'html', p_html,
      'text', p_text
    )
  )
  into v_request_id;

  insert into auth_hooks.email_log (
    email_action_type,
    recipient,
    status,
    request_id
  )
  values (
    p_action_type,
    p_to,
    'queued',
    v_request_id
  );

  return v_request_id;
end;
$$;

-- 1) Confirm signup
create or replace function auth_hooks.confirm_signup(
  p_email text,
  p_otp text,
  p_name text default null
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_intro text;
begin
  v_intro := case
    when p_name is not null and btrim(p_name) <> '' then
      format('Hi %s, use this 6-digit code to confirm your email and finish signing up.', btrim(p_name))
    else
      'Use this 6-digit code to confirm your email and finish signing up.'
  end;

  return auth_hooks.send_resend_email(
    p_to := p_email,
    p_subject := format('%s is your Rifq verification code', p_otp),
    p_html := auth_hooks.otp_email_html('Confirm your email', v_intro, p_otp),
    p_text := format('Your Rifq confirmation code is %s', p_otp),
    p_action_type := 'signup'
  );
end;
$$;

-- 2) Reset password
create or replace function auth_hooks.reset_password(
  p_email text,
  p_otp text,
  p_name text default null
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_intro text;
begin
  v_intro := case
    when p_name is not null and btrim(p_name) <> '' then
      format('Hi %s, use this 6-digit code to reset your Rifq password.', btrim(p_name))
    else
      'Use this 6-digit code to reset your Rifq password.'
  end;

  return auth_hooks.send_resend_email(
    p_to := p_email,
    p_subject := format('%s is your Rifq password reset code', p_otp),
    p_html := auth_hooks.otp_email_html('Reset your password', v_intro, p_otp),
    p_text := format('Your Rifq password reset code is %s', p_otp),
    p_action_type := 'recovery'
  );
end;
$$;

-- 3) Change email
create or replace function auth_hooks.change_email(
  p_current_email text,
  p_new_email text,
  p_current_otp text,
  p_new_otp text
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if p_new_otp is not null and btrim(p_new_otp) <> '' then
    if p_current_email is not null and btrim(p_current_email) <> ''
       and p_current_otp is not null and btrim(p_current_otp) <> '' then
      perform auth_hooks.send_resend_email(
        p_to := p_current_email,
        p_subject := format('%s is your Rifq email change code', p_current_otp),
        p_html := auth_hooks.otp_email_html(
          'Confirm email change',
          format(
            'We received a request to change your Rifq email to %s. Use this 6-digit code to confirm the request from your current address.',
            coalesce(p_new_email, 'a new address')
          ),
          p_current_otp
        ),
        p_text := format('Your Rifq email change code is %s', p_current_otp),
        p_action_type := 'email_change_current'
      );
    end if;

    if p_new_email is not null and btrim(p_new_email) <> '' then
      perform auth_hooks.send_resend_email(
        p_to := p_new_email,
        p_subject := format('%s is your Rifq email change code', p_new_otp),
        p_html := auth_hooks.otp_email_html(
          'Confirm your new email',
          'Use this 6-digit code in the app to confirm this email address.',
          p_new_otp
        ),
        p_text := format('Your Rifq email change code is %s', p_new_otp),
        p_action_type := 'email_change_new'
      );
    end if;
  else
    perform auth_hooks.send_resend_email(
      p_to := coalesce(nullif(btrim(p_new_email), ''), p_current_email),
      p_subject := format('%s is your Rifq email change code', p_current_otp),
      p_html := auth_hooks.otp_email_html(
        'Confirm your new email',
        'Use this 6-digit code in the app to confirm this email address.',
        p_current_otp
      ),
      p_text := format('Your Rifq email change code is %s', p_current_otp),
      p_action_type := 'email_change'
    );
  end if;
end;
$$;

create or replace function auth_hooks.send_email(event jsonb)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_action text;
  v_email text;
  v_new_email text;
  v_token text;
  v_token_new text;
  v_name text;
begin
  v_action := event #>> '{email_data,email_action_type}';
  v_email := event #>> '{user,email}';
  v_new_email := coalesce(
    event #>> '{user,new_email}',
    event #>> '{email_data,new_email}'
  );
  v_token := event #>> '{email_data,token}';
  v_token_new := event #>> '{email_data,token_new}';
  v_name := coalesce(
    event #>> '{user,user_metadata,full_name}',
    event #>> '{user,user_metadata,name}'
  );

  if v_action in (
    'password_changed_notification',
    'email_changed_notification',
    'phone_changed_notification',
    'identity_linked_notification',
    'identity_unlinked_notification',
    'mfa_factor_enrolled_notification',
    'mfa_factor_unenrolled_notification'
  ) then
    return '{}'::jsonb;
  end if;

  if v_token is null or btrim(v_token) = '' then
    return jsonb_build_object(
      'error', jsonb_build_object(
        'http_code', 500,
        'message', format('Missing OTP for %s', coalesce(v_action, 'unknown'))
      )
    );
  end if;

  begin
    case v_action
      when 'signup', 'invite', 'email' then
        perform auth_hooks.confirm_signup(v_email, v_token, v_name);
      when 'recovery' then
        perform auth_hooks.reset_password(v_email, v_token, v_name);
      when 'email_change' then
        perform auth_hooks.change_email(v_email, v_new_email, v_token, v_token_new);
      else
        perform auth_hooks.send_resend_email(
          p_to := coalesce(v_new_email, v_email),
          p_subject := format('%s is your Rifq verification code', v_token),
          p_html := auth_hooks.otp_email_html(
            'Your verification code',
            'Use this 6-digit code to continue.',
            v_token
          ),
          p_text := format('Your Rifq verification code is %s', v_token),
          p_action_type := coalesce(v_action, 'unknown')
        );
    end case;
  exception
    when others then
      insert into auth_hooks.email_log (
        email_action_type,
        recipient,
        status,
        error
      )
      values (
        coalesce(v_action, 'unknown'),
        coalesce(v_new_email, v_email, 'unknown'),
        'failed',
        sqlerrm
      );

      return jsonb_build_object(
        'error', jsonb_build_object(
          'http_code', 500,
          'message', sqlerrm
        )
      );
  end;

  return '{}'::jsonb;
end;
$$;

revoke all on function auth_hooks.otp_email_html(text, text, text) from public, anon, authenticated;
revoke all on function auth_hooks.get_resend_api_key() from public, anon, authenticated;
revoke all on function auth_hooks.get_from_email() from public, anon, authenticated;
revoke all on function auth_hooks.send_resend_email(text, text, text, text, text) from public, anon, authenticated;
revoke all on function auth_hooks.confirm_signup(text, text, text) from public, anon, authenticated;
revoke all on function auth_hooks.reset_password(text, text, text) from public, anon, authenticated;
revoke all on function auth_hooks.change_email(text, text, text, text) from public, anon, authenticated;
revoke all on function auth_hooks.send_email(jsonb) from public, anon, authenticated;

grant execute on function auth_hooks.send_email(jsonb) to supabase_auth_admin;
grant execute on function auth_hooks.confirm_signup(text, text, text) to supabase_auth_admin;
grant execute on function auth_hooks.reset_password(text, text, text) to supabase_auth_admin;
grant execute on function auth_hooks.change_email(text, text, text, text) to supabase_auth_admin;

-- Dashboard-discoverable Auth hook entrypoint. Invoker is supabase_auth_admin.
create or replace function public.send_email(event jsonb)
returns jsonb
language sql
set search_path = ''
as $$
  select auth_hooks.send_email(event);
$$;

grant execute on function public.send_email(jsonb) to supabase_auth_admin;
revoke execute on function public.send_email(jsonb) from public, anon, authenticated, service_role;
grant usage on schema public to supabase_auth_admin;
