# Migration Summary — `refactor/new-architecture`

Written for whoever reviews this branch before it merges. Covers what
changed, why, every bug found along the way, and what's deliberately left
for later.

## What changed, and why

This branch restructures `lib/` from a flat, ad hoc layout into the
Clean-Architecture layout documented in `docs/agras_structure_map.md`
(derived from a reference project, `_structure_reference/`, that was never
committed to this repo — see "Cleanliness" below). The reference uses
`flutter_bloc`/Cubit, `go_router`, and `get_it`+`injectable`; this project
already used Cubit and `get_it`+`injectable` too, but **routes on
`auto_route`, not `go_router`** — only the reference's folder shape and
naming convention were adopted, never its package choices. Nothing about
state management, routing, or DI was swapped.

Structural changes, roughly in the order they landed:

1. **`lib/core/` → `lib/shared/`**, reorganized into the reference's
   `constants/ errors/ extensions/ networking/ storage_service/ utils/
   service_locator/ presentation/{theme,router,widgets,extensions}` shape.
2. **Splash, Auth, Onboarding, Navigation Bar** re-homed into
   `features/<name>/presentation/{screens,widgets,cubit}`, with Auth also
   gaining proper `domain/entities` and `data/models` folders (previously
   its entity/model lived under a misplaced `core/widgets/shared/...` path).
3. **Per-feature `di/` folders removed** — this project's actual DI
   convention (already used by Auth) is annotation-only
   (`@injectable`/`@LazySingleton(as: ...)` directly on the class), picked
   up automatically by the one real `service_locator.dart` entrypoint. The
   `auth_di.dart`/`adoption_di.dart` per-feature init files were dead code:
   nothing ever called them.
4. **`freezed` replaced with `dart_mappable`** project-wide. Not what the
   reference doc says (it lists no freezed dependency at all, only
   `equatable`) — but `AuthModel` in this project already used
   `dart_mappable` before this branch existed, which is this project's own
   established convention and takes precedence over the reference's generic
   mention per the standing "keep this project's own packages" rule.
   `adoption`'s models were the only holdout (freezed), now converted to
   match.
5. **Structural conventions extended to `add_pet`/`adoption`/`home`**
   during the final audit pass (`pages/` → `screens/`,
   `usecases/` → `use_cases/`) — these three were out of the original
   migration's scope but back in scope for the audit.

## Commits on this branch

| Commit | Summary |
|---|---|
| `fa8d33f` | Migrate `lib/core/` → `lib/shared/`, matching the reference's folder shape |
| `22057fe` | Migrate Auth: `pages/` → `screens/`+`widgets/` split, entity/model re-homed into `domain/`/`data/` |
| `1561102` | Migrate Onboarding: `pages/` → `screens/` |
| `1474362` | Migrate Navigation Bar + Splash: fix `prsentaion`/`prsentation` typos, `pages/` → `screens/` |
| `c52eff3` | Remove per-feature `di/` folders; move to annotation-only DI (fixes a missing `AdoptionRepositoryDomain` registration along the way) |
| `7a4387a` | Replace `freezed` with plain Equatable classes in `adoption` (interim step) |
| `42e8c19` | Replace those Equatable classes with `dart_mappable`, matching `AuthModel`'s established convention |
| `dcdc2bd` | **Bug fix**: guard `NavCubit.changeIndex` against tabs with no screen implemented yet |
| `ebe8166` | Add fromJson/toJson round-trip tests for the `dart_mappable` adoption models |
| `923917b` | **Bug fix**: "Continue as Guest" now explicitly persists guest state |
| `c09cf56` | Extend `screens/`/`use_cases/` naming conventions to `add_pet`, `adoption`, `home` |
| `05f4c32` | Remove dead `go_router` and `json_annotation`/`json_serializable` dependencies |

## Bugs found and fixed

### 1. NavCubit crash — tapping Health/Hotel/Adoption hangs the app
**Symptom:** tapping the Health/Hotel/Adoption bottom-nav tabs (or Home's
"Clinic Visit"/"Pet Hotel"/"Adopt" quick-service cards, which call the same
method) threw an uncaught `RangeError` and left the screen unresponsive.
**Root cause:** `NavCubit.screens` is hard-coded to one entry
(`[HomeScreen()]` — the other three are commented out, not implemented
yet), but the bottom bar and Home's quick-service cards both let you set
`currentIndex` to 1/2/3 anyway. `NavScreen`'s `body:
cubit.screens[cubit.currentIndex]` then indexes past the end of a
one-element list.
**Important caveat:** I initially assumed this was introduced by the
migration (that's what triggered looking for it), but diffing every
changed file back to the pre-migration commit showed `nav_cubit.dart` is
byte-for-byte identical all the way back — **this bug predates the whole
migration**. Fixed anyway since it's clearly a real, user-facing crash.
**Fix:** `changeIndex` now no-ops for any index outside `screens`' bounds.
**Test:** `test/features/nav/presentation/screens/nav_screen_test.dart`.

### 2. Guest-login regression — "Continue as Guest" doesn't actually save guest state
**Symptom:** none visible in the common case — this is a latent bug, not
a crash. **Root cause:** the button navigated straight to home without
ever calling `AuthHelper.saveGuestLogin()`. It only *looked* correct
because `AuthHelper.isGuestUser()` defaults to `true` when local storage
has no login entry at all. If a device had a stale real login left over
(e.g. from `SplashScreen`'s unconfirmed-email path, which signs out of
Supabase but never calls `AuthHelper.logout()`), tapping "Continue as
Guest" would silently show *that* stale account's data instead of an
actual guest session. Also predates the migration — same byte-for-byte
check as above.
**Fix:** the button now explicitly awaits `AuthHelper.saveGuestLogin()`
before navigating, so guest state is always correctly (re)written.
Deliberately did *not* wire this to the existing (still commented-out)
`AuthCubit.anonymousUser()`/`signInAnonymously()` path — that would add a
real new Supabase call this button never made before, dependent on
anonymous auth being enabled on the project, which isn't verifiable from
here.
**Test:** `test/features/auth/presentation/screens/welcome_screen_test.dart`.

### 3. Missing `dart_mappable_builder` dependency
`auth_model.mapper.dart`/`pet_model.mapper.dart` already existed as
committed generated output before this branch, but `dart_mappable_builder`
was never in `pubspec.yaml` at all — `build_runner` couldn't have
regenerated even those two files. Added it so the whole project's model
codegen (including the new `adoption_model.mapper.dart`) actually works.

### 4. Missing DI annotation on `AdoptionRepositoryData`
`AdoptionRepositoryData implements AdoptionRepositoryDomain` had no
`@LazySingleton(as: ...)` annotation, so nothing ever registered it —
`CreateAdoptionPostUseCase`/`FetchAdoptionPostsUseCase` depended on an
unregistered type. This is also why `adoption_model.dart`'s old freezed
classes' missing-implementation compile errors didn't block a full build
sooner: nothing on the reachable Auth/Splash/Onboarding/Nav path touched
adoption's DI graph. Found and fixed while converting the `di/` folders to
annotation-only DI (matching the pattern `AuthRepoData` already used).

## Cleanliness

- **`_structure_reference/`**: confirmed via
  `git log --all --full-history -- '**/_structure_reference/**'` that it
  was never committed to this repo at any point — nothing to clean up.
- **Dead dependencies removed**: `go_router` (this project routes on
  `auto_route`; every `go_router` reference beyond a bare import line was
  either nothing or inside already-commented-out dead code) and
  `json_annotation`/`json_serializable` (zero `@JsonSerializable` usage or
  `.g.dart` files left anywhere once `dart_mappable` covers every model).
- **Debug prints / TODOs**: three pre-existing `print`/`debugPrint` calls
  exist (`choose_path.dart`, `splash_screen.dart`, `app_device_utils.dart`)
  — confirmed all three predate this branch (present at the pre-migration
  commit `ec5e9c9`), so left untouched per the audit's own scope (only
  migration-introduced debug artifacts were in scope for removal). No
  TODO/FIXME markers or newly-introduced commented-out code exist anywhere
  in this branch's diff.
- **No reference-app branding leaked** — the only "Ajras" match anywhere in
  the repo is inside `docs/agras_structure_map.md` itself, which is
  *describing* that reference project; nothing in `lib/`, `pubspec.yaml`,
  or platform config references it.
- **`docs/agras_structure_map.md` and `docs/migration_plan.md`** existed in
  the working tree from earlier planning phases but were never actually
  committed to this branch until this same final commit — bundled in here
  alongside this summary rather than left permanently untracked.

## Verification

- `flutter analyze`: 32 issues, 0 errors (started at 41 pre-existing before
  this branch; down further from there, purely from the dependency
  cleanup — nothing this branch touched introduced a new issue at any
  point, verified by diffing analyzer output after every commit).
- `flutter test`: 22/22 passing, including both crash-regression tests and
  17 fromJson/toJson round-trip tests for the `dart_mappable` adoption
  models.
- `dart run build_runner build --delete-conflicting-outputs`: confirmed
  clean — 0 outputs written, nothing stale or uncommitted.

## Known remaining issues / follow-ups (not acted on in this branch)

- **`sizer` package is dead** (only consumer is
  `shared/extensions/font_extensions.dart`, which itself has zero call
  sites anywhere), but removing it means deleting that source file too,
  not just a `pubspec.yaml` line — left as a follow-up rather than bundled
  into this audit's dependency cleanup.
- **Adoption feature is incomplete**: `AdoptionRoute` is still commented
  out in `app_router.dart`, so the feature isn't reachable from the app at
  all yet. `adoption_feature_screen.dart` is a placeholder.
- **`AuthCubit.anonymousUser()` stays commented out** — the real
  Supabase-anonymous-auth path this suggests was intended is still not
  wired up anywhere; the guest-login fix in this branch only fixes local
  storage state, deliberately not this.
- **Two parallel error-handling systems** (`Failure`/`FailureExceptions`
  used only by `add_pet`, vs `CustomException`/`CatchErrorMessage` used by
  `auth`/`home`) both still exist side by side — flagged during the
  original structural migration, not something this branch unifies.
- **Duplicate bootstrap calls**: `main.dart` calls `setup()` then
  `configureDependencies()`, and both independently call
  `dotenv.load`/`Supabase.initialize`/`GetStorage.init()` — pre-existing,
  harmless in practice, not touched.
- **`AuthUseCase` stays one consolidated class** rather than split
  per-verb like the reference's `LoginUseCase`/`SignUpUseCase`/etc. — a
  deliberate call from the original migration plan (splitting it would
  rewire `AuthCubit`'s constructor and every call site, a business-logic
  change beyond a structural pass), not revisited here.
