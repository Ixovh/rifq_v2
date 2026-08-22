-- Email change: only send OTP to the new email address.
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
declare
  v_to text;
  v_otp text;
begin
  -- Prefer the new-email OTP when present (secure email change payload).
  -- Otherwise fall back to the single token used when secure change is off.
  if p_new_otp is not null and btrim(p_new_otp) <> '' then
    v_to := nullif(btrim(p_new_email), '');
    v_otp := btrim(p_new_otp);
  else
    v_to := coalesce(nullif(btrim(p_new_email), ''), nullif(btrim(p_current_email), ''));
    v_otp := nullif(btrim(p_current_otp), '');
  end if;

  if v_to is null or v_otp is null then
    raise exception 'Missing new email or OTP for email change';
  end if;

  perform auth_hooks.send_resend_email(
    p_to := v_to,
    p_subject := format('%s is your Rifq email change code', v_otp),
    p_html := auth_hooks.otp_email_html(
      'Confirm your new email',
      'Use this 6-digit code in the app to confirm this email address.',
      v_otp
    ),
    p_text := format('Your Rifq email change code is %s', v_otp),
    p_action_type := 'email_change'
  );
end;
$$;
