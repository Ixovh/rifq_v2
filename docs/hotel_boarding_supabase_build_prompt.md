Context:
I am extending the existing "Rifq" Supabase database. Phase 1 already
exists and must NOT be touched: `auth.users`, the `user_role` enum
(`'pet_owner'`, `'clinic'`, `'service_provider'`), `profiles`, `pets`,
`adoption_posts`, and the `rifq_media` storage bucket. You are connected
to our Supabase project via MCP.

Goal:
Add Phase 2 — Hotel booking and Home Boarding — as new tables only.
Architecture:
- A "hotel" is a business account using the EXISTING `service_provider`
  role (same as clinics) — do NOT add a new enum value for this.
- A "home boarding sitter" is a REGULAR `pet_owner` account that
  optionally has a row in `home_boarding_profiles` — never any kind of
  service_provider, no role change involved.

Requirements:

New Enums:
- `payment_status_type`: 'pending', 'paid', 'failed', 'refunded'
- `booking_status_type`: 'confirmed', 'completed', 'cancelled'
- `boarding_request_status`: 'pending', 'accepted', 'declined'

Hotels tables:

1. `pet_hotels` — 1:1 extension of `profiles`.
   - id (UUID, PK, references profiles.id, must belong to a profile with
     role = 'service_provider' — enforce via RLS check, not a DB CHECK
     constraint referencing another table's column directly)
   - description (text), location_text (text)
   - latitude (numeric), longitude (numeric)
   - rating (numeric, default 0), review_count (int, default 0) — cached,
     manually updated for now, no reviews table yet
   - created_at, updated_at

2. `hotel_images`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - storage_path (text), public_url (text)
   - is_primary (bool, default false), display_order (int, default 0)
   - created_at

3. `hotel_facilities`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - label (text), category (text)

4. `hotel_rules`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - rule_text (text)

5. `hotel_rooms`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - room_type (text), price_per_night (numeric)
   - size_label (text), includes (text[])
   - total_rooms (int) — total inventory/capacity, NOT a live count
   - created_at, updated_at

6. `hotel_services`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - name (text), price (numeric), price_unit (text)
   - created_at, updated_at

7. `hotel_bookings`
   - id (UUID, PK), hotel_id (UUID, references pet_hotels)
   - pet_owner_id (UUID, references profiles)
   - number_of_pets (int)
   - check_in_date (date), check_out_date (date)
   - drop_off_time (time), pick_up_time (time)
   - room_price_total (numeric), addon_price_total (numeric)
   - app_service_fee (numeric), total_price (numeric)
   - payment_status (payment_status_type, default 'pending')
   - payment_method (text)
   - moyasar_payment_id (text, nullable), moyasar_invoice_id (text, nullable)
   - booking_reference (text, unique)
   - booking_status (booking_status_type, default 'confirmed')
   - created_at, updated_at

8. `hotel_booking_rooms`
   - id (UUID, PK), booking_id (UUID, references hotel_bookings)
   - room_id (UUID, references hotel_rooms)
   - quantity (int), price_at_booking (numeric)

9. `hotel_booking_services`
   - id (UUID, PK), booking_id (UUID, references hotel_bookings)
   - service_id (UUID, references hotel_services)
   - quantity (int), price_at_booking (numeric)

Home Boarding tables:

10. `home_boarding_profiles` — 1:1 optional extension of `profiles`.
    - id (UUID, PK, references profiles.id)
    - bio (text), specialty (text)
    - years_experience (int), price_per_night (numeric)
    - area_text (text), is_active (bool, default true)
    - rating (numeric, default 0), review_count (int, default 0)
    - created_at, updated_at

11. `home_boarding_skills`
    - id (UUID, PK), sitter_id (UUID, references home_boarding_profiles)
    - skill_label (text)

12. `boarding_requests`
    - id (UUID, PK), sitter_id (UUID, references home_boarding_profiles)
    - requester_id (UUID, references profiles)
    - status (boarding_request_status, default 'pending')
    - message (text, nullable)
    - created_at, updated_at

Storage Bucket:
Create a public bucket named `hotel_media` for hotel carousel photos, same
convention as the existing `rifq_media` bucket.

Technical & Scalability Rules:
- Primary Keys: UUID for all new tables.
- Timestamps: created_at/updated_at on every table that has them above;
  reuse the existing updated_at trigger function from Phase 1 rather than
  creating a duplicate one.
- RLS: Enable on ALL new tables and the new storage bucket.
  - `pet_hotels`, `hotel_images`, `hotel_facilities`, `hotel_rules`,
    `hotel_rooms`, `hotel_services`: public read; write/update/delete only
    by the owning hotel account (auth.uid() = pet_hotels.id, chained
    through hotel_id for the child tables).
  - `hotel_bookings`: a pet owner can read/insert only their own bookings
    (pet_owner_id = auth.uid()); the owning hotel account can read (not
    write) bookings made against their hotel.
  - `hotel_booking_rooms` / `hotel_booking_services`: readable/writable by
    whoever can access the parent booking (same rule chained through
    booking_id).
  - `home_boarding_profiles`, `home_boarding_skills`: public read; write
    only by the owning user (auth.uid() = home_boarding_profiles.id).
  - `boarding_requests`: readable by both the requester and the sitter it
    was sent to; insertable by the requester; status updatable only by the
    sitter it was sent to.
  - Storage `hotel_media`: authenticated hotel accounts can upload to
    their own hotel_id-prefixed path; anyone can view; only the owning
    hotel account can delete.

Please generate and execute the SQL to create these enums, tables,
triggers, the storage bucket, and all RLS policies using the Supabase MCP.
Explain your steps briefly as you go, and flag clearly if anything here
conflicts with the existing Phase 1 schema instead of silently working
around it.
