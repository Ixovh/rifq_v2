-- Store the contact details submitted by the requester (not just profile data).
ALTER TABLE public.adoption_requests
  ADD COLUMN IF NOT EXISTS requester_name text,
  ADD COLUMN IF NOT EXISTS requester_phone text,
  ADD COLUMN IF NOT EXISTS requester_city text;

COMMENT ON COLUMN public.adoption_requests.requester_name IS
  'Full name entered on the adoption request form';
COMMENT ON COLUMN public.adoption_requests.requester_phone IS
  'Phone number entered on the adoption request form';
COMMENT ON COLUMN public.adoption_requests.requester_city IS
  'City entered on the adoption request form';

-- Hide the owner's own listings from the public adoption feed.
CREATE OR REPLACE VIEW public.adoption_pet_cards AS
SELECT
  ap.id AS adoption_post_id,
  p.id AS pet_id,
  p.name,
  p.birthdate,
  ap.location,
  pp.public_url AS image_url,
  p.species,
  ap.poster_id
FROM public.adoption_posts ap
JOIN public.pets p ON p.id = ap.pet_id
LEFT JOIN public.pet_photos pp
  ON pp.pet_id = p.id AND pp.is_primary = true
WHERE ap.status = 'available'::adoption_status
  AND (auth.uid() IS NULL OR ap.poster_id IS DISTINCT FROM auth.uid());

GRANT SELECT ON public.adoption_pet_cards TO anon, authenticated;

-- Block duplicate pending requests; a new request is allowed only after rejection.
CREATE OR REPLACE FUNCTION public.prevent_self_adoption_request()
RETURNS trigger
LANGUAGE plpgsql
SET search_path TO ''
AS $function$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM public.adoption_posts ap
    WHERE ap.id = NEW.adoption_post_id
      AND ap.poster_id = NEW.requester_id
  ) THEN
    RAISE EXCEPTION 'Cannot request adoption of your own pet listing';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM public.adoption_posts ap
    WHERE ap.id = NEW.adoption_post_id
      AND ap.status = 'available'
  ) THEN
    RAISE EXCEPTION 'Adoption post is not available for requests';
  END IF;

  IF EXISTS (
    SELECT 1
    FROM public.adoption_requests ar
    WHERE ar.adoption_post_id = NEW.adoption_post_id
      AND ar.requester_id = NEW.requester_id
      AND ar.status = 'pending'
  ) THEN
    RAISE EXCEPTION 'You already have a pending request for this pet';
  END IF;

  RETURN NEW;
END;
$function$;

-- On accept: transfer the pet (and health records) to the requester.
CREATE OR REPLACE FUNCTION public.notify_on_adoption_request_response()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO ''
AS $function$
DECLARE
  v_pet_id UUID;
  v_pet_name TEXT;
  v_snapshot JSONB;
BEGIN
  IF OLD.status IS NOT DISTINCT FROM NEW.status THEN
    RETURN NEW;
  END IF;

  SELECT ap.pet_id, p.name
  INTO v_pet_id, v_pet_name
  FROM public.adoption_posts ap
  JOIN public.pets p ON p.id = ap.pet_id
  WHERE ap.id = NEW.adoption_post_id;

  IF NEW.status = 'accepted' THEN
    NEW.responded_at := COALESCE(NEW.responded_at, now());

    UPDATE public.adoption_requests
    SET status = 'rejected',
        rejection_reason = COALESCE(rejection_reason, 'Another request was accepted'),
        responded_at = now()
    WHERE adoption_post_id = NEW.adoption_post_id
      AND id <> NEW.id
      AND status = 'pending';

    UPDATE public.adoption_posts
    SET status = 'adopted'
    WHERE id = NEW.adoption_post_id;

    v_snapshot := public.pet_details_snapshot(v_pet_id);

    IF v_pet_id IS NOT NULL THEN
      UPDATE public.pets
      SET owner_id = NEW.requester_id,
          updated_at = now()
      WHERE id = v_pet_id;

      UPDATE public.pet_health_records
      SET owner_id = NEW.requester_id,
          updated_at = now()
      WHERE pet_id = v_pet_id;
    END IF;

    INSERT INTO public.notifications (user_id, type, title, body, data)
    VALUES (
      NEW.requester_id,
      'adoption_request_accepted',
      'Adoption request accepted',
      'Your request to adopt ' || COALESCE(v_pet_name, 'the pet') || ' was accepted. The pet has been added to your pets.',
      jsonb_build_object(
        'adoption_request_id', NEW.id,
        'adoption_post_id', NEW.adoption_post_id,
        'pet_id', v_pet_id,
        'pet_details', v_snapshot
      )
    );

    INSERT INTO public.notifications (user_id, type, title, body, data)
    SELECT
      ap.poster_id,
      'adoption_request_accepted',
      'You accepted an adoption request',
      'You accepted a request for ' || COALESCE(v_pet_name, 'your pet') || '. Ownership has been transferred to the adopter.',
      jsonb_build_object(
        'adoption_request_id', NEW.id,
        'adoption_post_id', NEW.adoption_post_id,
        'pet_id', v_pet_id,
        'requester_id', NEW.requester_id,
        'pet_details', v_snapshot
      )
    FROM public.adoption_posts ap
    WHERE ap.id = NEW.adoption_post_id;

  ELSIF NEW.status = 'rejected' THEN
    NEW.responded_at := COALESCE(NEW.responded_at, now());

    INSERT INTO public.notifications (user_id, type, title, body, data)
    VALUES (
      NEW.requester_id,
      'adoption_request_rejected',
      'Adoption request declined',
      'Your request to adopt ' || COALESCE(v_pet_name, 'the pet') || ' was declined.',
      jsonb_build_object(
        'adoption_request_id', NEW.id,
        'adoption_post_id', NEW.adoption_post_id,
        'pet_id', v_pet_id,
        'rejection_reason', NEW.rejection_reason
      )
    );
  END IF;

  RETURN NEW;
END;
$function$;
