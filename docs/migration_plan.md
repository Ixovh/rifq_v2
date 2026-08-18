# Migration Plan: Splash, Auth, Onboarding, Navigation Bar & Shared/Core

Phase 2 of 3 — **planning only, no edits made**. Maps every current file/folder
in scope to its new location per `docs/agras_structure_map.md`'s conventions
(folder shape, layering, naming), while keeping this project's own packages,
visuals, and behavior unchanged. Review this document; nothing executes until
it's approved.

---

## 0. This project's actual stack (confirmed from code, not assumed)

| Concern | Reference (`_structure_reference/`) uses | **This project actually uses** | Plan changes it? |
|---|---|---|---|
| State management | `flutter_bloc` (Cubit) | `flutter_bloc` / `bloc` (Cubit) — same | **No** |
| Routing | `go_router` | **`auto_route`** (`@AutoRouterConfig`, `@RoutePage()`, `context.router`/`.pushRoute`/`.replaceRoute`, generated `app_router.gr.dart`) | **No** |
| DI / service locator | `get_it` + `injectable` | `get_it` + `injectable` — same | **No** |
| Networking | `dio` | `dio` (present but currently unused — app is 100% Supabase) | **No** |
| Result/error type | `dartz` (declared, unused) | `multiple_result` (`Result`/`Success`/`Error`) | **No** |

**Important:** `go_router` is a listed `pubspec.yaml` dependency and is
*imported* in 5 files (`app_router.dart`, `custom_app_bar.dart`,
`guest_card_widget.dart`, `nav_screen.dart`, `onboarding_feature_screen.dart`),
but grepping actual navigation calls shows every real navigation in the app
goes through **auto_route** (`context.router.push/replace`, `context.pushRoute`,
`context.replaceRoute`, `AutoRoute`/`RoutePage`). The `go_router` imports are
dead/vestigial (leftover from an earlier implementation), and `core/navigation/routers.dart`'s
`Routes` string-path class is likewise dead — every live reference to it is
inside a comment. **This plan treats auto_route as the project's real router
and does not touch the go_router dependency or imports** (removing dead
imports/deps is a code-content decision, not a structural one — flagged in
§5 for you to decide separately, not actioned here).

---

## 1. Ground rules applied throughout this plan

1. **Relocate, don't rewrite.** Every row below is a file move (+ folder
   rename where the folder name itself violates convention, e.g. `pages/` →
   `screens/`, `prsentaion/` → `presentation/`). No function bodies, widget
   trees, colors, text styles, or DI annotations change.
2. **No invented layers.** Onboarding and the Navigation Bar have no
   data/domain logic today, so they get `presentation/` only — no empty
   `data/`/`domain/` folders invented, mirroring how the reference leaves
   its own stub features presentation-only.
3. **Shared widget vs. feature widget is decided by actual current
   consumers**, not by where the file happens to sit today:
   - Used only by an **in-scope** feature → pushed down into that feature's
     own `presentation/widgets/`.
   - Used by an **out-of-scope** feature (`home`, `add_pet`, `adoption`) —
     whether alone or alongside an in-scope feature — stays in shared, since
     restructuring `home`/`add_pet`/`adoption` is out of scope (rule 4 of
     your hard constraints).
4. **Spelling typos are left alone; convention-name violations are fixed.**
   `prsentaion` → `presentation` is fixed (it's literally the required layer
   name). `custome_button_widgets.dart`, `lottie_loding.dart`, `custome_exception.dart`
   are cosmetic misspellings, not convention violations — left as-is to keep
   diffs structural, not a spelling pass. (Called out per-item below.)
5. **Ripple effect is unavoidable and OK.** Moving any shared/core file
   changes its import path everywhere it's used, including in out-of-scope
   features. That's a mechanical import-path fix in those files, not a
   restructure of them — full list of affected out-of-scope files is in §4
   so it isn't a surprise during execution.

---

## 2. Target shape (in-scope subset)

```
lib/
  main.dart
  shared/
    setup.dart
    constants/
      app_enums.dart
      app_icons.dart
      app_images.dart
    errors/
      failure.dart
      network_exceptions.dart
      custome_exception.dart
    extensions/
      color_extensions.dart
      string_extensions.dart
      font_extensions.dart
    networking/
      dio_client.dart
      api_endpoints.dart
    storage_service/
      local_keys_service.dart
      auth_helper.dart
    utils/
      formatters.dart
      validators.dart
      app_device_utils.dart
    service_locator/
      service_locator.dart
      service_locator.config.dart      (generated)
      shared/
        main_dependencies.dart
    presentation/
      extensions/
        context_theme_extension.dart
        context_extensions.dart
      theme/
        app_color.dart
        app_text_theme.dart
      router/
        app_router.dart
        app_router.gr.dart             (generated)
        routers.dart
      widgets/
        custom_app_bar.dart
        custome_button_widgets.dart
        guest_card_widget.dart
        loading_overlay.dart
        loading_widget.dart
        lottie_loding.dart

  features/
    splash/
      presentation/
        screens/
          splash_screen.dart
          choose_path.dart
        widgets/
          path_button.dart
    auth/
      data/
        datasources/auth_data_source.dart
        models/auth_model.dart, auth_model.mapper.dart
        repositories/auth_repo_data.dart
      domain/
        entities/auth_entity.dart
        repositories/auth_repository_domain.dart
        use_cases/auth_use_case.dart
      di/auth_di.dart, auth_di.config.dart
      presentation/
        cubit/auth_cubit.dart, auth_state.dart
        screens/
          auth_screen.dart, otp_screen.dart, reset_password_screen.dart,
          sends_to_email_screen.dart, welcome_screen.dart
        widgets/
          auth_tab_bar.dart, login_tab.dart, sign_up_tab.dart,
          container_button.dart, custom_bottom_sheet.dart,
          custom_form_builder_text_field.dart
    onboarding/
      presentation/
        cubit/onboarding_cubit.dart, onboarding_state.dart
        screens/onboarding_feature_screen.dart
        widgets/custome_container_widgets.dart
    nav/
      presentation/
        cubit/nav_cubit.dart, nav_state.dart
        screens/nav_wrapper_screen.dart
        widgets/nav_screen.dart
```

---

## 3. File-by-file mapping

### 3.1 Shared / Core

| Current path | New path | Note |
|---|---|---|
| `lib/core/setup.dart` | `lib/shared/setup.dart` | Relocate only (`core` → `shared`). Content (dotenv/Supabase/GetStorage bootstrap) unchanged. |
| `lib/core/constants/app_enums.dart` | `lib/shared/constants/app_enums.dart` | Relocate only. Currently no consumers anywhere in the app (scaffold). |
| `lib/core/constants/app_icons.dart` | `lib/shared/constants/app_icons.dart` | Relocate only. No current consumers. |
| `lib/core/constants/app_images.dart` | `lib/shared/constants/app_images.dart` | Relocate only. No current consumers. |
| `lib/core/errors/failure.dart` | `lib/shared/errors/failure.dart` | Relocate only. |
| `lib/core/errors/network_exceptions.dart` | `lib/shared/errors/network_exceptions.dart` | Relocate only. |
| `lib/core/errors/custome_exception.dart` | `lib/shared/errors/custome_exception.dart` | Relocate only. Filename typo ("custome") is cosmetic, left as-is — see rule 4. |
| `lib/core/extensions/color_extensions.dart` | `lib/shared/extensions/color_extensions.dart` | Relocate only. Not BuildContext-specific, so it belongs in the general `extensions/`, not `presentation/extensions/`. No current consumers. |
| `lib/core/extensions/string_extensions.dart` | `lib/shared/extensions/string_extensions.dart` | Relocate only. No current consumers. |
| `lib/core/extensions/font_extensions.dart` | `lib/shared/extensions/font_extensions.dart` | Relocate only. No current consumers. |
| `lib/core/extensions/context_extensions.dart` | `lib/shared/presentation/extensions/context_extensions.dart` | Relocate + re-layer: it's a `BuildContext` extension (snackbar/loading/bottom-sheet helpers), so per the reference's own note it belongs under `presentation/extensions/`, not the bare `extensions/` folder. File is currently 100% commented out (dead) — carried over unchanged, not revived. |
| `lib/core/theme/app_theme.dart` | `lib/shared/presentation/extensions/context_theme_extension.dart` | Relocate + rename. This file is actually the `BuildContext` extension (`AppThemeX`) exposing `context.primary`, `context.h1`, etc. — functionally identical to the reference's canonical `context_theme_extension.dart`, so the filename is aligned to match. **Class name `AppThemeX` and all members are untouched.** |
| `lib/core/theme/app_color.dart` | `lib/shared/presentation/theme/app_color.dart` | Relocate only. `AppColors` values untouched — this is the file that must not change a single hex value. |
| `lib/core/theme/app_text_theme.dart` | `lib/shared/presentation/theme/app_text_theme.dart` | Relocate only. `AppTextStyles` (Poppins sizes/weights/line-heights) untouched. |
| `lib/core/network/dio_client.dart` | `lib/shared/networking/dio_client.dart` | Relocate + folder rename (`network` → `networking`, matching convention). Currently unused (no feature calls Dio; app is Supabase-only) — carried over as scaffolding, not deleted. |
| `lib/core/network/api_endpoints.dart` | `lib/shared/networking/api_endpoints.dart` | Relocate + folder rename, same as above. |
| `lib/core/services/local_keys_service.dart` | `lib/shared/storage_service/local_keys_service.dart` | Relocate + re-layer into `storage_service/` (matches reference's "SharedPreferences wrapper + StorageKeys" role). Currently unused/vestigial (its key constants aren't consulted by `AuthHelper`) — carried over as-is. |
| `lib/core/services/app_device_utils.dart` | `lib/shared/utils/app_device_utils.dart` | Relocate into `utils/` (device/package info helpers fit the reference's "free functions/utilities" folder better than storage). Currently unused elsewhere in the app. |
| `lib/core/utils/formatters.dart` | `lib/shared/utils/formatters.dart` | Relocate only. |
| `lib/core/utils/validators.dart` | `lib/shared/utils/validators.dart` | Relocate only. |
| `lib/core/di/configure_dependencies.dart` | `lib/shared/service_locator/service_locator.dart` | Relocate + rename to match reference's exact DI-entrypoint convention (`getIt` instance + `@InjectableInit` `configureDependencies()`). Same `get_it`+`injectable` usage, no package swap. |
| `lib/core/di/configure_dependencies.config.dart` | `lib/shared/service_locator/service_locator.config.dart` | Relocate + rename (generated file — regenerate via `dart run build_runner build` after the move; not hand-edited). |
| `lib/core/di/third_part.dart` | `lib/shared/service_locator/shared/main_dependencies.dart` | Relocate + rename to match reference's `@module`-class convention for hand-built singletons (`GetStorage`, `SupabaseClient`). Same annotations, same singletons. |
| `lib/core/navigation/app_router.dart` | `lib/shared/presentation/router/app_router.dart` | Relocate only. `AppRouter`/`@AutoRouterConfig`/route table untouched — **auto_route stays**, this only matches the reference's `shared/presentation/router/` folder location, not its go_router content. |
| `lib/core/navigation/app_router.gr.dart` | `lib/shared/presentation/router/app_router.gr.dart` | Relocate alongside `app_router.dart` (it's a `part of` file, must move with it; regenerate via build_runner after the move). |
| `lib/core/navigation/routers.dart` | `lib/shared/presentation/router/routers.dart` | Relocate only. Kept as its current simple `Routes` string-constants class rather than reshaped into the reference's `RouteNames` enum — it's already dead code (see §0), so reshaping it is a content change with no behavioral payoff; not part of this move. |
| `lib/core/widgets/appbar/custom_app_bar.dart` | `lib/shared/presentation/widgets/custom_app_bar.dart` | Relocate + flatten (drop the single-file `appbar/` subfolder — reference's `shared/presentation/widgets/` is flat). Only consumer is `home` (out of scope), so it stays shared rather than moving into a feature. |
| `lib/core/widgets/button/path_button.dart` | `lib/features/splash/presentation/widgets/path_button.dart` | **Moved out of shared, into Splash.** Its only consumer is `choose_path.dart` (in-scope, Splash), so per rule 3 it belongs in Splash's own `presentation/widgets/`, not cross-feature shared. |
| `lib/core/widgets/custome_button_widgets.dart` | `lib/shared/presentation/widgets/custome_button_widgets.dart` | Relocate + flatten. Genuinely cross-feature (`add_pet` + `onboarding`), so stays shared. Filename typo left as-is (rule 4). |
| `lib/core/widgets/guest_card/guest_card_widget.dart` | `lib/shared/presentation/widgets/guest_card_widget.dart` | Relocate + flatten. Only consumer is `home` (out of scope) → stays shared. |
| `lib/core/widgets/loading/loading_overlay.dart` | `lib/shared/presentation/widgets/loading_overlay.dart` | Relocate + flatten. No current consumers found — carried over as-is. |
| `lib/core/widgets/loading_widget.dart` | `lib/shared/presentation/widgets/loading_widget.dart` | Relocate only. Entire file is commented-out/dead code — carried over unchanged, not revived or deleted. |
| `lib/core/widgets/lottie_loading/lottie_loding.dart` | `lib/shared/presentation/widgets/lottie_loding.dart` | Relocate + flatten. Only consumer is `home` (out of scope) → stays shared. Filename typo ("loding") left as-is. |
| `lib/core/widgets/shared/shared_in_owner_flow/shared_auth/entities/auth_entity.dart` | `lib/features/auth/domain/entities/auth_entity.dart` | **Moved into the Auth feature's own `domain/`.** Only ever used inside `features/auth/**` — it's Auth's domain entity, not shared code. This also matches the pattern already used by `add_pet`/`adoption`/`home` (`domain/entities/<feature>_entity.dart`), which Auth was the one feature missing. |
| `lib/core/widgets/shared/shared_in_owner_flow/shared_auth/models/auth_model.dart` | `lib/features/auth/data/models/auth_model.dart` | Moved into Auth's own `data/models/`, matching the same sibling-feature pattern. `dart_mappable` usage unchanged. |
| `lib/core/widgets/shared/shared_in_owner_flow/shared_auth/models/auth_model.mapper.dart` | `lib/features/auth/data/models/auth_model.mapper.dart` | Moves with its `part` parent (generated file — regenerate via build_runner after the move). |
| `lib/core/widgets/shared/shared_in_owner_flow/shared_auth/helpers/auth_helper.dart` | `lib/shared/storage_service/auth_helper.dart` | **Stays shared** (unlike the two files above) — it's genuinely cross-feature: used by both `auth` and `home` (out of scope) for guest/session checks. Re-layered into `storage_service/` since it wraps `GetStorage` for session persistence, matching the reference's storage-wrapper role. The awkward `shared/shared_in_owner_flow/shared_auth/` nesting is dropped — nothing in the current codebase reflects an "owner flow" grouping distinct from the rest of the app. |

### 3.2 Splash

| Current path | New path | Note |
|---|---|---|
| `lib/features/splash/prsentation/pages/splash_screen.dart` | `lib/features/splash/presentation/screens/splash_screen.dart` | Folder fix: `prsentation` → `presentation` (typo in the required layer name) and `pages` → `screens` (convention folder name). No feature has `data`/`domain` — none invented (rule 2). Content, animations, Supabase session-check logic all untouched. |
| `lib/features/splash/prsentation/pages/choose_path.dart` | `lib/features/splash/presentation/screens/choose_path.dart` | Same folder fix. |
| *(new)* — | `lib/features/splash/presentation/widgets/path_button.dart` | See §3.1 — `PathButton` relocated here from shared, since Splash is its only consumer. |

### 3.3 Auth

| Current path | New path | Note |
|---|---|---|
| `lib/features/auth/data/datasources/auth_data_source.dart` | *(same path)* | **No change.** Already matches convention exactly (`data/datasources/<feature>_data_source.dart`). ~250 lines of commented-out legacy implementation at the bottom are untouched (not a structural concern). |
| `lib/features/auth/data/repositories/auth_repo_data.dart` | *(same path)* | **No change.** Already matches convention exactly — file name, `AuthRepoData implements AuthRepoDomain` class shape both match the reference's naming table precisely. |
| `lib/features/auth/domain/repositories/auth_repository_domain.dart` | *(same path)* | **No change.** Already matches convention (`<feature>_repository_domain.dart`, class `AuthRepoDomain`). |
| `lib/features/auth/domain/use_cases/auth_use_case.dart` | *(same path)* | **No change — flagged decision, see §5.** Reference splits one use case per verb (`LoginUseCase`, `SignUpUseCase`, ...); this project has one consolidated `AuthUseCase` with all methods. Splitting it would force `AuthCubit`'s constructor and every call site to change shape — that crosses from "move files" into "rewrite business-logic wiring," which conflicts with your hard constraint 3. Left as one file; call out below if you want that split done as an explicit, separate follow-up. |
| `lib/features/auth/di/auth_di.dart` | *(same path)* | **No change.** Per-feature DI init file, already an established project pattern (mirrored by `adoption/di/adoption_di.dart`), not something from the reference to conform to or against. |
| `lib/features/auth/di/auth_di.config.dart` | *(same path)* | **No change** (generated). |
| `lib/features/auth/presentation/cubit/auth_cubit.dart` | *(same path)* | **No change.** Already exact convention match: Cubit + `part`/`part of` state file pair. |
| `lib/features/auth/presentation/cubit/auth_state.dart` | *(same path)* | **No change.** |
| `lib/features/auth/presentation/pages/auth_screen.dart` | `lib/features/auth/presentation/screens/auth_screen.dart` | `pages` → `screens`. True routed screen (`@RoutePage()`). |
| `lib/features/auth/presentation/pages/otp_screen.dart` | `lib/features/auth/presentation/screens/otp_screen.dart` | Same. |
| `lib/features/auth/presentation/pages/reset_password_screen.dart` | `lib/features/auth/presentation/screens/reset_password_screen.dart` | Same. |
| `lib/features/auth/presentation/pages/sends_to_email_screen.dart` | `lib/features/auth/presentation/screens/sends_to_email_screen.dart` | Same. |
| `lib/features/auth/presentation/pages/welcomscreen.dart` | `lib/features/auth/presentation/screens/welcome_screen.dart` | `pages` → `screens`, **plus filename fix** `welcomscreen.dart` → `welcome_screen.dart`. This one *is* fixed (unlike the cosmetic typos left alone elsewhere) because it directly violates the reference's documented `_screen.dart` suffix convention, not just a spelling preference. Class name (`WelcomeScreen`) is already correct — only the filename changes. |
| `lib/features/auth/presentation/pages/auth_tab_bar.dart` | `lib/features/auth/presentation/widgets/auth_tab_bar.dart` | **Re-layered, not just renamed.** It's a plain `StatelessWidget` with no `@RoutePage()` — a sub-widget of `AuthScreen`, not a routed screen, so it belongs in `widgets/` (matching how `add_pet` already separates its stepper sub-widgets from its screen). |
| `lib/features/auth/presentation/pages/login_tab.dart` | `lib/features/auth/presentation/widgets/login_tab.dart` | Same reasoning — no `@RoutePage()`, it's a tab-content widget composed inside `AuthScreen`. |
| `lib/features/auth/presentation/pages/sign_up_tab.dart` | `lib/features/auth/presentation/widgets/sign_up_tab.dart` | Same. |
| `lib/features/auth/presentation/widgets/container_button.dart` | *(same path)* | **No change.** Already correctly placed. |
| `lib/features/auth/presentation/widgets/custom_bottom_sheet.dart` | *(same path)* | **No change.** |
| `lib/features/auth/presentation/widgets/custom_form_builder_text_field.dart` | *(same path)* | **No change.** |
| *(new, from §3.1)* | `lib/features/auth/domain/entities/auth_entity.dart` | Moved in from the misplaced `core/widgets/shared/...` location. |
| *(new, from §3.1)* | `lib/features/auth/data/models/auth_model.dart` (+ `.mapper.dart`) | Moved in from the misplaced `core/widgets/shared/...` location. |

### 3.4 Onboarding

| Current path | New path | Note |
|---|---|---|
| `lib/features/onboarding/presentation/pages/onboarding_feature_screen.dart` | `lib/features/onboarding/presentation/screens/onboarding_feature_screen.dart` | `pages` → `screens`. Filename's `_feature_screen.dart` suffix is this project's own established pattern (shared with `home_feature_screen.dart`, `adoption_feature_screen.dart`) and still ends in `_screen.dart` — kept as-is, not forced to a bare `onboarding_screen.dart`. |
| `lib/features/onboarding/presentation/cubit/onboarding_cubit.dart` | *(same path)* | **No change.** Already exact convention match (Cubit + `part`/`part of`). Note: `OnboardingCubit extends Cubit<int>` while `onboarding_state.dart` separately declares an unused `OnboardingState`/`OnboardingInitial` — pre-existing dead code inside the file, not a structural issue, left untouched. |
| `lib/features/onboarding/presentation/cubit/onboarding_state.dart` | *(same path)* | **No change.** |
| `lib/features/onboarding/presentation/widgets/custome_container_widgets.dart` | *(same path)* | **No change.** Already correctly placed in `widgets/`; filename typo left as-is (rule 4). |

### 3.5 Navigation Bar (`nav` feature)

| Current path | New path | Note |
|---|---|---|
| `lib/features/nav/prsentaion/cubit/nav_cubit.dart` | `lib/features/nav/presentation/cubit/nav_cubit.dart` | Folder fix: `prsentaion` → `presentation`. |
| `lib/features/nav/prsentaion/cubit/nav_state.dart` | `lib/features/nav/presentation/cubit/nav_state.dart` | Same folder fix. (Uses plain `import` rather than `part`/`part of` like `auth_state.dart`/`onboarding_state.dart` do — a pre-existing inconsistency, not changed here; see §5.) |
| `lib/features/nav/prsentaion/pages/nav_screen.dart` | **split into two files:**<br>`lib/features/nav/presentation/screens/nav_wrapper_screen.dart`<br>`lib/features/nav/presentation/widgets/nav_screen.dart` | The single file currently holds two classes: `NavWrapperScreen` (has `@RoutePage()` — the actual routed screen, just provides `NavCubit` and renders `NavScreen`) and `NavScreen` (the real bottom-nav-bar + FAB UI, a plain widget, no route annotation). Splitting these mirrors the routed-screen-vs-widget separation applied to Auth in §3.3: the router-facing class goes in `screens/`, the presentational bottom-bar widget goes in `widgets/`. No behavior/visual change — pure file split along the existing class boundary. |

### 3.6 App bootstrap

| Current path | New path | Note |
|---|---|---|
| `lib/main.dart` | *(same path)* | **No structural move.** Only its 3 internal imports (`core/setup.dart`, `core/di/configure_dependencies.dart`, `core/navigation/app_router.dart`) get updated to their new `shared/...` paths. `EasyLocalization`/`ScreenUtilInit`/`MaterialApp.router` setup, and the commented-out `theme:`/`darkTheme:` lines, are untouched. |
| `pubspec.yaml` | *(same path)* | **No change.** No dependency added, removed, or swapped. |

---

## 4. Ripple effect: out-of-scope files needing an import-path fix

These files belong to `home`/`add_pet` (out of scope — **not restructured**),
but they import a file that this plan moves, so their `import` statements
need a one-line path update in Phase 3. Nothing else in them changes:

- `features/home/presentation/pages/home_feature_screen.dart` — imports `core/navigation/app_router.dart`, `core/navigation/routers.dart`, `core/theme/app_theme.dart`, `core/widgets/appbar/custom_app_bar.dart`, `core/widgets/guest_card/guest_card_widget.dart`, `core/widgets/lottie_loading/lottie_loding.dart`, `features/nav/prsentaion/cubit/nav_cubit.dart`
- `features/home/presentation/widgets/recommendation_card_widget.dart`, `quick_service_widget.dart`, `pet_circle_widget.dart` — import `core/theme/app_theme.dart`
- `features/home/data/datasources/home_remote_data_source.dart` — imports `core/errors/custome_exception.dart`, `core/widgets/shared/shared_in_owner_flow/shared_auth/helpers/auth_helper.dart`
- `features/home/data/repositories/home_repository_data.dart` — imports the same `auth_helper.dart`
- `features/add_pet/presentation/pages/add_pet_screen.dart` — imports `core/theme/app_theme.dart`, `core/widgets/custome_button_widgets.dart`, `core/di/configure_dependencies.dart`
- `features/add_pet/presentation/widgets/step1_add_pet.dart`, `step2_add_pet.dart` — import `core/theme/app_theme.dart`

`adoption` has no imports into any file this plan touches — unaffected.

---

## 5. Explicitly not changing (with reasons)

- **`go_router` dependency/imports** — dead code (see §0). Removing it is a
  dependency/content cleanup decision, not a structural move; left for you
  to decide separately.
- **Duplicate bootstrap calls** — `setup()` and `configureDependencies()`
  both call `dotenv.load`, `Supabase.initialize`, and `GetStorage.init()`
  (both run, back to back, from `main.dart`). Pre-existing behavior, not
  touched — deduplicating it is a logic change, out of scope for a
  structural pass.
- **Two parallel error-handling systems** — `Failure`/`FailureExceptions`
  (used only by `add_pet`) and `CustomException`/`CatchErrorMessage` (used
  by `auth` and `home`) both exist and both move into `shared/errors/`
  as-is. Unifying them is a business-logic decision, not this plan's job.
- **`AuthUseCase` staying one class** instead of one-class-per-verb — see
  §3.3.
- **Cosmetic filename typos** (`custome_button_widgets.dart`,
  `custome_exception.dart`, `lottie_loding.dart`, `custome_container_widgets.dart`)
  — left alone; they don't violate any documented naming *convention*, just
  spelling. `welcomscreen.dart` was the one exception fixed, because it
  collides with the documented `_screen.dart` suffix rule, not just spelling.
- **`nav_state.dart`'s `import` instead of `part`/`part of`** — inconsistent
  with `auth_state.dart`/`onboarding_state.dart`, but changing it edits
  Dart code (declarations), not just file location — left as an
  observation, not actioned.
- **Feature-level `di/` files** (`auth_di.dart`, and out-of-scope
  `adoption_di.dart`) whose `configureAuth()`/`configureAdoption()`
  functions appear uncalled from the active `configureDependencies()` (the
  call site is commented out) — a possible pre-existing DI wiring gap, not
  a structural issue; flagged for your awareness only.

---

## 6. Execution notes for Phase 3 (not done yet)

- After moving files, run `dart run build_runner build --delete-conflicting-outputs`
  to regenerate `service_locator.config.dart`, `app_router.gr.dart`,
  `auth_di.config.dart`, and `auth_model.mapper.dart` with corrected paths.
- Every `import 'package:rifq_v2/core/...'` across the whole repo (in-scope
  and the out-of-scope files listed in §4) needs updating to `package:rifq_v2/shared/...`
  or the new feature path — a mechanical find/replace per moved file, not a
  logic change.
- Recommend moving+verifying one area at a time (e.g. Shared/Core first,
  then Splash, Auth, Onboarding, Nav) and running `flutter analyze` +
  a manual app launch after each, rather than one giant move.

---

## Open decisions for you to confirm before Phase 3

1. **`PathButton` → Splash-only widgets/** (§3.1) instead of staying shared —
   OK, or keep it shared for anticipated reuse?
2. **`AuthUseCase` stays a single consolidated class** (§3.3/§5) rather than
   being split into one-class-per-verb like the reference — OK, or do you
   want that split done as an explicit follow-up?
3. **`nav_screen.dart` split into `nav_wrapper_screen.dart` (screens/) +
   `nav_screen.dart` (widgets/)** (§3.5) — OK with the split, or prefer it
   stay one file?
4. **Cosmetic typos left unfixed** (§5) — OK to leave, or fix them all while
   we're in these files anyway?
