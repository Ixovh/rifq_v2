-- Health records attached to a pet (Add Health Record bottom sheet).
CREATE TABLE IF NOT EXISTS public.pet_health_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  pet_id uuid NOT NULL REFERENCES public.pets(id) ON DELETE CASCADE,
  owner_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title text NOT NULL,
  record_type text NOT NULL,
  description text,
  clinic_name text,
  visit_date date NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.pet_health_records ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Owners can view their pet health records"
  ON public.pet_health_records FOR SELECT
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert pet health records"
  ON public.pet_health_records FOR INSERT
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update their pet health records"
  ON public.pet_health_records FOR UPDATE
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete their pet health records"
  ON public.pet_health_records FOR DELETE
  USING (auth.uid() = owner_id);

CREATE INDEX IF NOT EXISTS pet_health_records_pet_id_idx
  ON public.pet_health_records (pet_id, visit_date DESC);
