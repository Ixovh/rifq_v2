# Agras Structure Map (`_structure_reference/`)

Read-only architectural analysis of the `_structure_reference/` Flutter project
("Ajras", package `sa.aisc.tawtheeq`). Purpose: capture folder layout, layering,
state management, routing, DI, theming, and naming conventions so they can be
reproduced in this project's real `lib/`. Screen/feature *content* in the
reference is irrelevant — only structure and convention matter.

Stack: Flutter, `flutter_bloc` (Cubit), `go_router`, `get_it` + `injectable`,
`dio`, `shared_preferences`, `equatable`, `dartz` (declared but not evidenced
in surviving code), `flutter_svg`, `cached_network_image`.

---

## 1. Top-level folder layout

```
lib/
  configs/            # Build-flavor / environment bootstrapping
    environments/
      development/main_development.dart
      production/main_production.dart
    models/
      app_config.dart          # AppConfig singleton + AppConfigModel
      app_config_bundle.dart   # AppBundle enum -> package/bundle id per flavor
      app_config_type.dart     # AppConfigType enum (development/production)

  features/           # One folder per feature/screen-group ("vertical slice")
    <feature_name>/
      data/           # (seen in build cache only, feature since removed — see §2)
      domain/
      presentation/
        screens/
        (cubit/ — expected, see §2)

  l10n/               # Localization
    cubit/            # LocaleCubit (Cubit<LocaleState>) + LocaleState (part file)
    generated/         # flutter gen-l10n output, do not hand-edit
    app_ar.arb, app_en.arb   # source strings (lives one level up, lib/l10n/*.arb)

  shared/             # Cross-feature infrastructure — the "core" layer
    constants/         # App-wide enums/const values (home_tabs.dart, app_defines.dart, locales.dart)
    errors/            # Failure hierarchy (failure.dart)
    extensions/         # BuildContext / GoRouter extensions (non-presentation-specific? see note)
    networking/         # Dio wrapper, endpoints, request/response models
      errors/
      interceptors/
    presentation/       # UI-layer shared code
      assets/            # Assets enum (svg/image paths, RTL/LTR aware)
      extensions/         # presentation-only extensions (snackbar helper)
      router/             # go_router setup
      screens/             # shared/fallback screens (error route)
      theme/               # ThemeData + ThemeExtension + ThemeCubit
        cubit/
        extension/
      widgets/             # Shared reusable widgets (GenericImage, etc.)
    service_locator/     # get_it + injectable wiring
      shared/               # @module classes providing hand-built singletons
    storage_service/     # SharedPreferences wrapper + StorageKeys
    utils/                # Free functions/top-level getters (tr, envs, launch_url, widget_unwrapper)

  main.dart             # mainCommon(AppConfigModel) + MyApp (MaterialApp.router)
```

Root-level non-`lib` folders (`android/`, `ios/`, `web/`, `assets/`, `test/`,
`scripts/`) are standard Flutter platform scaffolding and build tooling — not
relevant to app architecture.

### Note on `shared/extensions/` vs `shared/presentation/extensions/`
The reference is inconsistent here: `context_theme_extension.dart`,
`go_router_extensions.dart`, and `localization_extension.dart` live directly
under `shared/extensions/` even though they are presentation-facing (they
extend `BuildContext`/`GoRouterState`), while `custom_snack_bar.dart` lives
under `shared/presentation/extensions/`. Treat `shared/presentation/extensions/`
as the intended home for UI extensions; the top-level `shared/extensions/`
folder appears to be legacy/inconsistent placement rather than a deliberate
second convention.

---

## 2. Feature-internal layering

The **only feature with full layering evidence** is `auth`, whose source was
deleted from `lib/` but whose compiled artifacts survive in
`.dart_tool/build/generated/Ajras/lib/features/auth/**/*.injectable.json`.
This reveals the intended convention is **Clean Architecture** (data / domain
/ presentation), even though the five currently-surviving features
(`create`, `developer_view`, `home`, `home_tabs`, `messaging`,
`my_activities`) only have a bare `presentation/screens/` folder (they're
UI-only stubs with no backing logic yet).

Reconstructed `auth` feature layout, from artifact import paths:

```
features/auth/
  data/
    datasources/
      auth_data_source.dart        # abstract AuthDataSource + AuthDataSourceImpl
                                    #   (depends on SupabaseClient — injected)
    repositories/
      auth_repo_data.dart          # class AuthRepoData implements AuthRepoDomain
                                    #   (depends on AuthDataSource — injected)
  domain/
    repositories/
      auth_repository_domain.dart  # abstract AuthRepoDomain (the interface data/ implements)
    use_cases/
      login_use_case.dart          # class LoginUseCase (depends on AuthRepoDomain)
      sign_up_use_case.dart
      verify_account_use_case.dart
  presentation/
    (cubit/ + screens/, per AppRouter's commented-out AuthCubit/OnboardingCubit refs)
```

Layering rules implied by the dependency graph in the injectable JSON:

- **`domain/`** defines the contract: an abstract repository
  (`AuthRepoDomain`) and use case classes. Use cases depend only on the
  domain repository interface, never on `data/` or a concrete client SDK.
- **`data/`** implements the contract: a `*DataSource` (talks to the raw
  client — here `SupabaseClient`, but for this project it would be Dio/API)
  and a `*RepoData` (implements the domain interface, depends on the
  datasource, and — per `Failure` in `shared/errors/failure.dart` plus the
  `dartz` dependency — is expected to return `Either<Failure, T>` from
  repository/use-case methods, even though no surviving file shows this
  directly).
- **`presentation/`** holds `screens/` (widgets) and would hold a `cubit/`
  subfolder (Cubit + Equatable State) per feature — confirmed by the pattern
  used for `LocaleCubit` and `ThemeCubit` (see §3), and by `AppRouter`'s
  commented-out `AuthCubit(getIt(), getIt(), getIt(), getIt())`
  instantiation (4 use-case dependencies injected via `getIt()`).
- Every concrete implementation class (`AuthDataSourceImpl`, `AuthRepoData`,
  each use case) is registered with `injectable` (`injectableType: 2` =
  lazy singleton in the generator's encoding) and resolved through `get_it`
  — nothing is manually `new`'d outside DI registration/module code.

**Naming convention for layered classes:**
| Role | File name | Class name |
|---|---|---|
| Abstract data source | `<feature>_data_source.dart` | `<Feature>DataSource` |
| Data source impl | same file | `<Feature>DataSourceImpl` |
| Abstract repository (domain) | `<feature>_repository_domain.dart` | `<Feature>RepoDomain` |
| Repository impl (data) | `<feature>_repo_data.dart` | `<Feature>RepoData` |
| Use case | `<verb>_use_case.dart` | `<Verb>UseCase` |

---

## 3. State management

**`flutter_bloc`'s Cubit** (not full Bloc — no `Event` classes anywhere), used
consistently for cross-cutting state:

- `LocaleCubit extends Cubit<LocaleState>` — `lib/l10n/cubit/locale_cubit.dart`
- `ThemeCubit extends Cubit<ThemeState>` — `lib/shared/presentation/theme/cubit/theme_cubit.dart`

Pattern for every Cubit:
- File pair: `<name>_cubit.dart` (the Cubit class + constructor + methods
  that call `emit(...)`) and `<name>_state.dart` (declared via `part` /
  `part of`, holding a single `State` class).
- State classes extend `Equatable` (e.g. `ThemeState`, `LocaleState`
  presumably) for value equality, not just plain classes.
- Cubits are constructed once via the DI layer (`@singleton` in a
  `@module` class — see §5) and provided app-wide with `MultiBlocProvider`
  in `main.dart`'s `MyApp`, not created ad hoc in widgets.
- Screens read state with `context.watch<XCubit>()` / `BlocProvider.of`,
  consistent with standard `flutter_bloc` usage.
- Feature-scoped Cubits (like the commented-out `AuthCubit`,
  `OnboardingCubit`) are instantiated per-route in `AppRouter`'s route
  `builder`, wrapped in a local `BlocProvider(create: (context) =>
  XCubit(getIt(), getIt(), ...))` — i.e. scoped to the route/feature rather
  than provided globally, unlike Locale/Theme which are app-global.

No Provider, Riverpod, GetX, or setState-based state management is used for
anything beyond trivially local widget state.

---

## 4. Routing / navigation convention

**`go_router`**, centralized in `lib/shared/presentation/router/`:

- `router_names.dart` — single `enum RouteNames` where each case carries
  `name` (a `Set<String>` — support for aliases), `path`, and an
  `isPrivate` flag (auth-gating metadata, currently unused since auth was
  stripped, but the convention exists: `RouteNames.privateRoutes` /
  `.publicRoutes` static getters, and `.getRouteByName()` lookup helper).
- `app_router.dart` — a static-only `AppRouter` class holding:
  - `static GoRouter routerConfig` — the single router instance, built once.
  - `rootNavigatorKey` / `referralNavigatorKey` — `GlobalKey<NavigatorState>` kept as static fields for imperative navigation/dialogs outside the widget tree.
  - Route-scoped Cubits are commented in as static fields too (`static AuthCubit authCubit = ...`), with `dispose()`/`_resetSharedCubits()` static helpers to recreate them (e.g. on logout).
  - Bottom-tab navigation uses `StatefulShellRoute.indexedStack` with one `StatefulShellBranch` per tab (`home`, `create`, `myActivities`, `messages`, plus `developerView` gated by `kDebugMode`), wrapping `HomeTabScreen(navigationShell: navigationShell)`.
  - A private static `_homeTabsNavigationShell` plus a public `static bool goTo({required HomeTabs tab})` helper lets non-widget code (e.g. a push-notification handler) switch tabs programmatically.
  - `errorPageBuilder` renders a shared `ErrorRouteScreen` (`shared/presentation/screens/`).
  - `route_arguments.dart` is a documented-but-empty placeholder file showing the intended pattern for typed route arguments (a `<Screen>Arguments` class passed via route `extra`/builder), not yet used.
- `shared/extensions/go_router_extensions.dart` adds `GoRouter.popUntil(path)`
  and `GoRouterState.isDeepLink` / `isPrivatePath` (cross-references
  `RouteNames.privateRoutes`), i.e. auth-gating logic is meant to live at the
  router/extension layer, not duplicated per-screen.

Screens are wired into `GoRoute.builder`/`StatefulShellBranch.routes` by
importing the screen widget directly from
`features/<name>/presentation/screens/<name>_screen.dart` — no separate
route-config-per-feature file; all routes are declared centrally in
`app_router.dart`.

---

## 5. Dependency injection / service locator convention

**`get_it` + `injectable`**, in `lib/shared/service_locator/`:

- `service_locator.dart` — the only "public API": exposes `final getIt =
  GetIt.instance;` and `configureDependencies()` (annotated
  `@InjectableInit()`), which calls the generated `getIt.init()`. Called
  once from `mainCommon()` in `main.dart`, before `runApp`.
- `service_locator.config.dart` — **generated** (`build_runner` +
  `injectable_generator`; header says "DO NOT MODIFY BY HAND"). Never hand
  edit; regenerate via `dart run build_runner build`.
- `shared/main_dependencies.dart` — a **hand-written `@module` abstract
  class** (`MainDependencies`) for dependencies that need manual
  construction logic (reading `StorageService` to pick a saved locale/theme,
  building the `Dio`/`NetworkClient` with interceptors, etc.). Each getter is
  annotated `@singleton` and named after the concrete type it returns
  (`localeCubit`, `themeCubit`, and — notably — `AjrasBackend` for the app's
  single named `NetworkClient` instance, an app-specific network client
  name that should be renamed per-app, e.g. to match this project's brand).
- Feature classes (data sources, repo impls, use cases) instead use
  **annotation-based** registration directly on the class (`@injectable`
  or `@lazySingleton` — inferred from `injectableType: 2` in the generated
  JSON for `AuthDataSourceImpl`/`AuthRepoData`, both singleton-lifetime),
  with constructor-injected dependencies auto-wired by `injectable` — no
  manual `main_dependencies.dart` entry needed for feature-layer classes.
- **Convention split**: `@module` classes (in `service_locator/shared/`) are
  for third-party/framework objects or anything requiring custom
  construction logic; `@injectable`/`@lazySingleton` class annotations are
  for the app's own data/domain classes. Both funnel into the same
  generated `service_locator.config.dart`.
- Resolution everywhere is `getIt<T>()` (or bare `getIt()` when the type is
  inferable), never a raw `GetIt.instance` reference outside
  `service_locator.dart`.

---

## 6. Theming convention

Two-layer theming, both under `lib/shared/presentation/theme/`:

1. **`app_theme.dart`** — `enum AppThemeType { light, dark }` +
   `abstract class AppTheme` with a private `_light`/`_dark`
   `static final ThemeData` pair and a single public accessor
   `AppTheme.getTheme(AppThemeType)`. This is where `ColorScheme`,
   `AppBarTheme`, `BottomNavigationBarThemeData`, etc. (framework-level
   `ThemeData` fields) are defined. Comment markers (`//TODO: Add light
   Theme`) show this is the file to flesh out per-brand.
2. **`extension/main_colors.dart`** — a custom `ThemeExtension<MainColors>`
   (`primary`, `background`, `text`, `surface`, plus `error500/600/700` and
   `success500/600/700` semantic-status colors) with `.light()` factory,
   `.fallback()` factory, and required `copyWith`/`lerp` overrides. This is
   where **brand/semantic colors not covered by Material's `ColorScheme`**
   live — registered onto `ThemeData.extensions` (implied; not directly
   visible since no code currently calls `.copyWith(extensions: [...])`, but
   `context.mainColors` in the extension below assumes it's registered).

Access pattern: `lib/shared/extensions/context_theme_extension.dart` exposes
`context.theme` (`Theme.of(this)`) and `context.mainColors`
(`theme.extension<MainColors>() ?? MainColors.fallback()`) — **screens never
call `Theme.of(context)` or construct `MainColors` directly**, they use the
`BuildContext` extension.

State/switching: `cubit/theme_cubit.dart` — `ThemeCubit extends
Cubit<ThemeState>`, persists the chosen `AppThemeType` name string to
`StorageService`/`StorageKeys.themeType`, and `emit`s a new `ThemeState`
wrapping `AppTheme.getTheme(type)`. `ThemeCubit` is provided globally in
`main.dart` and `MaterialApp.router(theme: ...)` watches it.

Typography is **not** separately abstracted in the reference (no
`text_styles.dart`/`AppTextStyles` file found) — text styling appears to be
expected to live inside `AppTheme`'s `ThemeData` (e.g.
`textTheme:`) once fleshed out, or ad hoc per-widget. If this project already
has named text styles, that's an enhancement over the reference, not a
convention to strip out.

Fonts/spacing: no dedicated `spacing.dart`/`dimens.dart` or custom font
family setup exists in the reference either — only color theming is
represented. Treat this as **undocumented in the reference**, not as "no
spacing system should exist."

---

## 7. Naming conventions

**Files:** `snake_case.dart` throughout, no exceptions found. Suffix denotes
role: `_screen.dart`, `_cubit.dart`, `_state.dart` (part file), `_use_case.dart`,
`_data_source.dart`, `_repo_data.dart` / `_repository_domain.dart`,
`_interceptor.dart`, `_exception.dart`, `_extension.dart`, `_service.dart`.

**Folders:** `snake_case`, always plural for collections (`screens/`,
`repositories/`, `datasources/` — note: `datasources` is one word, not
`data_sources`, `use_cases/` is the one exception with an underscore).
Feature folder names are singular-topic (`auth`, `home`, `messaging`), not
suffixed with `_feature`.

**Classes:** `PascalCase`. Enums are `PascalCase` with `camelCase` values
(`AppConfigType.development`, `AppThemeType.light`). Abstract
interface/contract classes carry no `I`-prefix and no `Abstract`-prefix —
instead the **domain-side name is the "plain" name** (`AuthRepoDomain`) and
the **implementation carries the layer as a suffix** (`AuthRepoData`,
`AuthDataSourceImpl`). Cubits: `<Scope>Cubit` / `<Scope>State`. Use cases:
`<VerbPhrase>UseCase`.

**Constants/enums grouping:** domain-spanning constants live in dedicated
`abstract class` "namespaces" with all-`static const` members rather than
top-level consts — e.g. `ApiEndpoints`, `ApiConfiguration`, `StorageKeys`,
`AppDefines`, `Envs`. None of these are ever instantiated; some use a
private unnamed constructor (`Envs._()`) to enforce that.

**Route names:** `snake_case` string values matching the enum case's intent
(`'developer_view'`, `'my_activities'`), even though the Dart enum case
itself is `camelCase` (`developerView`, `myActivities`) — i.e. Dart
identifier casing and string/path casing are allowed to diverge
deliberately (Dart convention vs. URL convention).

**Import style:** absolute `package:Ajras/...` imports are used for
cross-directory references from `lib/features/**`, while relative imports
(`../../../shared/...`) are used more often *within* `shared/` and from deep
screen files reaching back into `shared/` — the reference is not fully
consistent, but leans toward package-absolute imports for feature code and
relative imports for shared/infrastructure code referencing sibling shared
code.

---

## 8. Summary for translation to this project

When porting structure only (not content) to the real app:
- Adopt `features/<name>/{data,domain,presentation}/` as the target layering
  even though most current reference features only stub `presentation/` —
  `auth` is the canonical fully-layered example to copy the *shape* of.
  This project's own working Auth/Onboarding code should be re-homed into
  this shape, not left flat.
  This project's existing color/font/spacing theme should be migrated into
  the `AppTheme` + `MainColors`-style two-layer structure (framework
  `ThemeData` vs. custom `ThemeExtension`), preserving this project's actual
  color/font values — the reference's specific colors are not meant to be
  copied.
- Reuse the `shared/service_locator/{service_locator.dart, shared/main_dependencies.dart}` + generated `service_locator.config.dart` split.
- Reuse the `RouteNames` enum + centralized `AppRouter` (`StatefulShellRoute.indexedStack` for the existing bottom nav bar) + `route_arguments.dart` placeholder pattern.
- Cubit+Equatable-state pattern (not Bloc, not Riverpod) for both global (locale/theme) and feature-scoped state.
