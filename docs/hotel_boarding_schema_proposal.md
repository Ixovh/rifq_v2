# Hotel + Home Boarding — Schema Proposal (review before building)

This is a review document, not SQL. Once approved, it becomes the source
for both a Supabase MCP build prompt and Claude Code's model/feature build
— so any correction here should happen now, before either.

## Architecture decisions — CONFIRMED

No new `user_role` enum value needed. A hotel account is a real login tied
to `profiles` via the **existing** `role = 'service_provider'` — same
umbrella as clinics. `pet_hotels.id` references `profiles.id` where that
profile's role is `service_provider`.

Home Boarding sitters do **NOT** get any role at all, new or existing:
they're regular `pet_owner` accounts that additionally have a row in
`home_boarding_profiles` (below). Presence of that row is what makes them
listable as a sitter and able to receive boarding requests; they are never
classified as a service provider.

---

## Hotels flow

### `pet_hotels`
1:1 extension of `profiles` (same pattern as `profiles` extending
`auth.users`) — one hotel per account for now. Owning profile must have
`role = 'service_provider'` (same role clinics use; enforced via RLS/check,
not a new enum value).

| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | references `profiles.id` |
| description | text | "About the Hotel" |
| location_text | text | e.g. "Riyadh" |
| latitude / longitude | numeric | for map deep link + client-computed distance ("2.5 km" is NOT stored — computed against the user's location at read time) |
| created_at / updated_at | timestamptz | |

### `hotel_images`
Mirrors the existing `pet_photos` convention exactly (same shape, same
storage pattern) for consistency with the rest of the codebase.

| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK → pet_hotels | |
| storage_path / public_url | text | bucket: `hotel_media`, path convention `<hotelId>/<timestamp>_<filename>` |
| is_primary / display_order | bool / int | carousel ordering |
| created_at | timestamptz | |

### `hotel_facilities`
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK | |
| label | text | "Private Room", "24/7 Cameras" |
| category | text | "Facility" / "Security" / "Support" — the small gray subtitle under each tag |

### `hotel_rules`
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK | |
| rule_text | text | one row per rule |

### `hotel_rooms`
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK | |
| room_type | text | "Standard" / "VIP" / "Suite" |
| price_per_night | numeric | |
| size_label | text | "2m x 2m" |
| includes | text[] | "Soft bed, Daily cleaning, ..." |
| total_rooms | int | total inventory (capacity), NOT a live availability count |

**Availability approach:** "3 rooms available" is computed live at
booking time — `total_rooms` minus bookings that overlap the requested
date range — rather than a manually-maintained counter. A counter drifts
out of sync and risks double-booking; a date-range overlap query against
`hotel_booking_rooms` is the correct way to get an accurate number and is
what should gate whether "Book Now" is even allowed to succeed.

### `hotel_services` (add-ons: Daycare, Grooming, Vet check)
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK | |
| name | text | |
| price | numeric | |
| price_unit | text | "per day" / "flat" |

### `hotel_bookings`
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| hotel_id | uuid, FK | |
| pet_owner_id | uuid, FK → profiles | |
| number_of_pets | int | |
| check_in_date / check_out_date | date | from the range date-picker |
| drop_off_time / pick_up_time | time | |
| room_price_total / addon_price_total / app_service_fee / total_price | numeric | snapshot at booking time |
| payment_status | enum: pending / paid / failed / refunded | |
| payment_method | text | 'apple_pay' / 'visa' / 'mastercard' |
| moyasar_payment_id / moyasar_invoice_id | text, nullable | unused until Moyasar is wired in |
| booking_reference | text, unique | the receipt barcode value, e.g. "PC123456789" |
| booking_status | enum: confirmed / completed / cancelled | |
| created_at / updated_at | timestamptz | |

### `hotel_booking_rooms` (quantity per room type per booking)
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| booking_id | uuid, FK | |
| room_id | uuid, FK → hotel_rooms | |
| quantity | int | |
| price_at_booking | numeric | snapshot, protects past bookings from later price changes |

### `hotel_booking_services` (add-ons per booking)
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| booking_id | uuid, FK | |
| service_id | uuid, FK → hotel_services | |
| quantity | int | |
| price_at_booking | numeric | |

### Reviews — deferred
No "write a review" screen exists in the Figma set, only a displayed
rating + count. Recommendation: keep `rating` and `review_count` as plain
cached columns on `pet_hotels` (seeded/updated manually or by admin) for
now, rather than building a full reviews table with no submission UI to
feed it. Easy to add a real `hotel_reviews` table later without touching
anything else.

---

## Home Boarding flow

### `home_boarding_profiles`
1:1 optional extension of `profiles` — its existence is what makes a
regular `pet_owner` account listable as a sitter. No role change.

| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | references `profiles.id` |
| bio | text | |
| specialty | text | "Cat & small dog sitter" |
| years_experience | int | |
| price_per_night | numeric | |
| area_text | text | "Al Malqa" |
| is_active | bool | currently listed or not |
| created_at / updated_at | timestamptz | |

### `home_boarding_skills`
| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| sitter_id | uuid, FK → home_boarding_profiles | |
| skill_label | text | "Medication handling", "Calm & patient", etc. |

### `boarding_requests` ("Send Request" flow)
Deliberately minimal — Figma shows no date/pet-count selection here, just
a direct request to the sitter.

| Column | Type | Notes |
|---|---|---|
| id | uuid, PK | |
| sitter_id | uuid, FK → home_boarding_profiles | |
| requester_id | uuid, FK → profiles | the pet owner sending the request |
| status | enum: pending / accepted / declined | |
| message | text, nullable | |
| created_at / updated_at | timestamptz | |

Reviews for sitters: same deferred approach as hotels — cached
`rating`/`review_count` on `home_boarding_profiles` for now.

---

## Storage

New bucket: **`hotel_media`** — hotel carousel photos. Same path
convention as `pet_photos`: `<hotelId>/<timestamp>_<filename>`.

## RLS direction (for the eventual build prompt, not decided here)

- `pet_hotels`/`hotel_rooms`/`hotel_services`/`hotel_images`/etc.: public
  read (anyone browses hotels), write restricted to the owning hotel
  account (`auth.uid() = hotel_id` chain).
- `hotel_bookings`: a pet owner can read/write only their own bookings; a
  hotel account can read (not write) bookings made against their hotel.
- `home_boarding_profiles`: public read, write restricted to the owning
  user.
- `boarding_requests`: readable by both the requester and the sitter it
  was sent to; writable (create) by the requester, (update status) by the
  sitter.
