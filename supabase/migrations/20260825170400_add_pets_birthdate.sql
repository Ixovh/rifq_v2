ALTER TABLE public.pets
  ADD COLUMN IF NOT EXISTS birthdate date;

COMMENT ON COLUMN public.pets.birthdate IS
  'Pet date of birth from Add Pet. Age remains for existing screens.';

NOTIFY pgrst, 'reload schema';
