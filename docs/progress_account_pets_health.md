# Rifq v2 — Recent Progress Summary

This document summarizes the work completed on the Account / Pets / Health Record flows, local caching, and shared UI improvements.

---

## Goals

1. Improve the account and pets experience to match the Figma **Account** frame.
2. Prevent profile vs pet image conflicts and caching bugs.
3. Reduce unnecessary Supabase requests with local-first storage.
4. Let owners view and edit pet info, and add health records.
5. Keep clean architecture: features do not depend on each other for shared UI.

---

## 1. Home & navigation

| Change | Detail |
|--------|--------|
| **See all → Your Pets** | Home “Your Pets → See all” opens `AccountPetsScreen`, not the user profile. |
| Avatar / pet circles | Still open the account / pet flows as appropriate. |
| Pull-to-refresh | Home and Account can force a server refresh and rewrite the local snapshot. |

---

## 2. Local storage (`UserDataStore`)

**File:** `lib/shared/storage_service/user_data_store.dart`

- Caches signed-in **profile + email + pets** in GetStorage.
- **Home** and **Account** read from the same snapshot first.
- First load after login fetches once from Supabase; later opens are local.
- **Profile update:** merge into local store, then call the server; roll back on failure.
- **Add pet:** append to local store when the server returns id + photo URL.
- **Logout:** clears the user snapshot (and profile image cache).

Helpers: `mergeProfileFields`, `addPet`, `removePet`, `updatePet`, `fetchAndCache`.

---

## 3. Profile & pet images

**Problem:** User avatar and pet photos collided in a single cache path per user.

**Fix (`ProfileImageCache`):**

- Cache key per **user + image URL** (hashed filename).
- Avatar upload clears cache and uses a **timestamped** storage path so URLs change.

Pet photos use the pet photos bucket; profile uses the profile bucket — no overwrite between them.

---

## 4. Loading buttons

- Shared buttons (`ContainerButton` / custom elevated buttons) show a **Lottie** animation while loading.
- Buttons are **disabled** during submit (Add Pet Save, profile Save, etc.).

---

## 5. Account UI — pets list

- Profile shows a **horizontal** scroll of pet cards.
- **Your Pets** screen lists all pets (full-width cards).
- Title **“Your Pets”** is centered with a `Stack` so it stays centered relative to the screen (not shifted by the back button).
- Pet age under 1 year shows as **months** (e.g. `6 months`).

### Pet card actions

| Control | Action |
|---------|--------|
| Pencil icon | Opens **Edit Pet** |
| Teal row / chevron | Opens **Pet Profile** |

---

## 6. Edit Pet feature

**Feature folder:** `lib/features/edit_pet/`

Screens aligned with Figma Account frames:

- **Edit Pet** — name, birthdate, breed, weight, photo; Save with loading state.
- Local-first update via `UserDataStore.updatePet`, then Supabase update.

**DB:** `pets.weight` (`numeric`, kg)  
Migration: `supabase/migrations/20260826020000_add_pets_weight.sql`

---

## 7. Pet Profile screen

**Screen:** Pet Profile (from Account Figma)

- Hero: photo, name, gender icon, breed, age + weight chips.
- Tabs: **Health Record** | **Appointment**.
- Edit icon in the app bar → Edit Pet; refresh on return.

---

## 8. Health Record feature

**Feature folder:** `lib/features/health_record/`

| UI | Behavior |
|----|----------|
| Empty state | Uses `assets/images/Frame 1984077926.png` |
| FAB / bottom CTA | **Add new health record** |
| Bottom sheet | Title, Type, Description, Clinic Name, Date of Visit → Save |

**DB:** `pet_health_records` (or equivalent applied name) with RLS for the owner.  
Migration: `supabase/migrations/20260826021900_create_pet_health_records.sql`

Clean architecture: data source → repository → use case → cubit → widgets.

---

## 9. Shared date / species pickers (clean architecture)

**Problem:** Health Record imported pickers from `add_pet`, which breaks feature isolation.

**Fix:**

- Moved pickers to  
  `lib/shared/presentation/widgets/app_pickers.dart`
- Removed  
  `lib/features/add_pet/presentation/widgets/add_pet_pickers.dart`
- Call sites (add pet, edit pet, health record) use:
  - `showAppDatePicker(...)`
  - `showAppSpeciesSheet(...)`

### Faster month jump

- Tapping the calendar **month/year** title opens a month + year wheel.
- Small chevron under the title indicates it’s tappable.
- Confirm jumps the calendar to that month.

Date picker accepts a custom **title** (e.g. “Choose date of birth” vs “Choose date of visit”).

---

## 10. Supabase schema touchpoints

| Change | Purpose |
|--------|---------|
| `pets.birthdate` | Age from DOB / edit pet |
| `pets.weight` | Shown on profile & editable |
| Health records table | Persist Add Health Record form |
| RLS on health records | Owner-only read/write |

---

## Architecture notes

- Features follow **clean architecture** (data / domain / presentation), similar to `auth`.
- Navigation: **AutoRoute**.
- State: **Cubit / Bloc**.
- DI: **injectable / get_it**.
- Shared widgets live under `lib/shared/`; features must not import each other’s presentation layer for reusable UI.

---

## Key files (quick map)

```
lib/shared/storage_service/user_data_store.dart
lib/shared/storage_service/profile_image_cache.dart
lib/shared/presentation/widgets/app_pickers.dart

lib/features/account/...          # Account, Your Pets, Pet Profile UI
lib/features/edit_pet/...         # Edit owned pet
lib/features/health_record/...    # Health records + bottom sheet
lib/features/home/...             # Cache-first home + See all → Your Pets
lib/features/add_pet/...          # Add pet (writes local store after create)

supabase/migrations/
  20260825170400_add_pets_birthdate.sql
  20260826020000_add_pets_weight.sql
  20260826021900_create_pet_health_records.sql
```

---

## Still open / next ideas

- Appointment tab content (currently empty / placeholder).
- Pet delete flow using `UserDataStore.removePet` after server delete.
- Optional: force-refresh health records after returning from other screens.
- Keep Figma Account frame and app screens in sync as designs change.

---

*Last updated: August 2026*
