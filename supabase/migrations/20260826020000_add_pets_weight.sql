-- Pet weight (kg) shown on profile and editable in Edit pet info.
ALTER TABLE public.pets
  ADD COLUMN IF NOT EXISTS weight numeric(6, 2);

COMMENT ON COLUMN public.pets.weight IS 'Pet weight in kilograms';
