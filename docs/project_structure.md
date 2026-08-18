# Project Structure

A reference for navigating and extending this codebase. Read this once and
you should be able to find your way to any layer of any feature, and know
where new code belongs.

## 1. Top-level `lib/` layout

```
lib/
  main.dart        # app entrypoint: bootstrap, DI init, MaterialApp.router
  features/         # one folder per feature (vertical slice)
  shared/            # cross-feature infrastructure — the "core" layer
```

`lib/main.dart` does four things, in order: initializes localization
(`easy_localization`), runs `setup()` (env/Supabase/local-storage bootstrap,
see §3), runs `configureDependencies()` (DI wiring, see §6), then calls
`runApp` with `MaterialApp.router` wired to the generated `AppRouter`.

There is no `lib/l10n/` folder — this project uses `easy_localization`
directly against `.arb`-free JSON translation files under
`assets/translations/`, loaded by the `EasyLocalization` widget in
`main.dart`. There's nothing to generate or hand-maintain under `lib/` for
localization.

## 2. Feature layering: `data/` / `domain/` / `presentation/`

Each folder under `lib/features/<name>/` is a vertical slice. A feature with
real business logic (talks to Supabase, has state to manage) gets all three
layers; a feature that's just static UI (nothing to fetch, nothing to
decide) only gets `presentation/`. Don't invent `data/`/`domain/` folders
for a screen that has no data or business logic — `features/onboarding/`
and `features/splash/` are presentation-only for exactly this reason.

Using `features/auth/` as the concrete, fully-layered example:

```
features/auth/
  data/
    datasources/
      auth_data_source.dart       # BaseAuthDataSource (abstract) + SubaBaseDataSource (impl)
    models/
      auth_model.dart             # AuthModel — dart_mappable, see §7
    repositories/
      auth_repo_data.dart         # AuthRepoData implements AuthRepoDomain
  domain/
    entities/
      auth_entity.dart            # AuthEntity — plain domain object
    repositories/
      auth_repository_domain.dart # AuthRepoDomain (abstract contract)
    use_cases/
      auth_use_case.dart          # AuthUseCase
  presentation/
    cubit/
      auth_cubit.dart / auth_state.dart
    screens/
      auth_screen.dart, otp_screen.dart, welcome_screen.dart, ...
    widgets/
      auth_tab_bar.dart, container_button.dart, ...
```

**What belongs in each layer:**

- **`domain/`** is the contract layer — no Supabase, no `dio`, no Flutter
  imports. `auth_repository_domain.dart` declares `abstract class
  AuthRepoDomain` with methods like `login`, `signUp`, `logOut` returning
  `Future<Result<T, Object>>` (this project uses the `multiple_result`
  package's `Result` type, not exceptions, for expected failure cases).
  `auth_use_case.dart`'s `AuthUseCase` depends only on `AuthRepoDomain` (the
  interface), never on the concrete data-layer class:

  ```dart
  @lazySingleton
  class AuthUseCase {
    final AuthRepoDomain authRepoData;
    const AuthUseCase({required this.authRepoData});

    Future<Result<Null, Object>> login({required String email, required String password}) async =>
        await authRepoData.login(email: email, password: password);
  }
  ```

- **`data/`** implements the contract. A `*DataSource` talks to the raw
  client (here, `SupabaseClient` directly — this project has no repository
  pattern indirection between Supabase and the datasource); a `*RepoData`
  implements the domain repository interface and delegates to the
  datasource:

  ```dart
  @LazySingleton(as: AuthRepoDomain)
  class AuthRepoData implements AuthRepoDomain {
    final BaseAuthDataSource authDataSource;
    AuthRepoData({required this.authDataSource});

    @override
    Future<Result<Null, Object>> login({required String email, required String password}) async =>
        await authDataSource.login(email: email, password: password);
  }
  ```

  `models/` holds the data-shape classes that actually get parsed from (or
  sent to) Supabase — see §7.

- **`presentation/`** holds `cubit/` (state management, §4), `screens/`
  (routable, `@RoutePage()`-annotated top-level widgets), and `widgets/`
  (everything else — sub-components composed inside a screen, with no route
  of their own). A screen and its sub-widgets are split by that rule, not
  by file size: `auth_screen.dart` is a screen (routed); `login_tab.dart`
  and `auth_tab_bar.dart`, which it composes, are widgets (not routed).

**Naming convention for layered classes:**

| Role | File | Class |
|---|---|---|
| Abstract data source | `<feature>_data_source.dart` | `Base<Feature>DataSource` |
| Data source impl | same file | implementation class (naming varies — see below) |
| Abstract repository (domain) | `<feature>_repository_domain.dart` | `<Feature>RepoDomain` |
| Repository impl (data) | `<feature>_repo_data.dart` | `<Feature>RepoData` |
| Use case | `<feature>_use_case.dart` | `<Feature>UseCase` |

The domain-side interface carries no prefix (`AuthRepoDomain`, not
`IAuthRepoDomain`); the concrete implementation carries the layer as a
suffix (`AuthRepoData`). Data-source implementation class names aren't
perfectly uniform across features today (e.g. `SubaBaseDataSource` in auth
vs. `HomeDataSource` in home) — when adding a new feature, prefer
`<Feature>DataSourceImpl` unless you have a reason not to.

## 3. `shared/` — what's in each subfolder

Cross-feature code that more than one feature (or no feature in particular)
needs lives here. Nothing feature-specific belongs in `shared/` — if only
one feature uses it, it goes in that feature's own folder instead.

| Folder | Purpose | Example |
|---|---|---|
| `constants/` | App-wide enums and static value tables | `app_enums.dart` (`LoadingState`, `NetworkStatus`, ...), `app_icons.dart`/`app_images.dart` (asset path constants) |
| `errors/` | Failure/exception types and mapping | `failure.dart` (a `Failure` hierarchy), `network_exceptions.dart` (`FailureExceptions.getException` maps Dio/Supabase exceptions to `Failure`s), `custome_exception.dart` (`CustomException` + `CatchErrorMessage`, the error-message helper most datasources actually use — see the note below) |
| `extensions/` | General-purpose Dart extensions not tied to `BuildContext` | `string_extensions.dart`, `color_extensions.dart` |
| `networking/` | HTTP client wrapper, for any feature that needs to call a REST API directly (most features talk to Supabase directly and don't need this) | `dio_client.dart` (`DioClient`, wraps `Dio`), `api_endpoints.dart` |
| `presentation/extensions/` | `BuildContext` extensions | `context_theme_extension.dart` — see §8 |
| `presentation/theme/` | Raw design-system values | `app_color.dart`, `app_text_theme.dart` — see §8 |
| `presentation/router/` | Centralized routing | `app_router.dart`, generated `app_router.gr.dart` — see §5 |
| `presentation/widgets/` | Reusable widgets used by more than one feature | `custom_app_bar.dart`, `loading_overlay.dart` |
| `service_locator/` | DI wiring | `service_locator.dart`, generated `service_locator.config.dart`, `shared/main_dependencies.dart` — see §6 |
| `storage_service/` | Local persistence helpers | `auth_helper.dart` (`AuthHelper` — guest/session state via `GetStorage`), `local_keys_service.dart` |
| `utils/` | Free-standing helper functions/classes | `formatters.dart`, `validators.dart`, `app_device_utils.dart` |

**Note on error handling:** two error-reporting mechanisms currently coexist
— `Failure`/`FailureExceptions` (a typed exception→`Failure` mapper, used by
`add_pet`) and `CustomException`/`CatchErrorMessage` (a simpler
message-extraction helper, used by `auth` and `home`). Match whichever
pattern the feature you're touching already uses; don't mix them within one
feature.

## 4. State management: Cubit

State management is `flutter_bloc`'s **Cubit** — no `Bloc`, no `Event`
classes, anywhere in this project. Every feature's state lives in
`presentation/cubit/`, as a `<name>_cubit.dart` + `<name>_state.dart` pair
connected via `part`/`part of` (one library, two files):

```dart
// auth_cubit.dart
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase _authUseCase;
  AuthCubit(this._authUseCase) : super(AuthInitial());

  Future login({required String email, required String password}) async {
    emit(AuthLoadingState());
    (await _authUseCase.login(email: email, password: password)).when(
      (success) => emit(AuthSuccessState()),
      (error) => emit(AuthErrorState(msg: /* ... */ '')),
    );
  }
}

// auth_state.dart
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class AuthErrorState extends AuthState {
  final String msg;
  const AuthErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
```

State classes are a plain `abstract class ... extends Equatable` with one
concrete subclass per state (not a sealed union, not `freezed`). Screens
provide their Cubit with `BlocProvider` (often constructed inline with a
dependency pulled from DI, e.g. `BlocProvider(create: (_) =>
AuthCubit(GetIt.I.get<AuthUseCase>()))`) and read/react to it with
`context.read<XCubit>()` / `BlocBuilder<XCubit, XState>` /
`BlocListener<XCubit, XState>`, standard `flutter_bloc` usage.

Cubits are feature-scoped and created per-screen — there's no global Cubit
provided app-wide above `MaterialApp.router`.

## 5. Routing: auto_route

Routing is `auto_route`, centralized in `lib/shared/presentation/router/`:

- **`app_router.dart`** — imports every screen and declares the route table
  once, in `AppRouter.routes`:

  ```dart
  @AutoRouterConfig(replaceInRouteName: 'Screen,Route')
  class AppRouter extends RootStackRouter {
    @override
    List<AutoRoute> get routes => [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: AuthRoute.page, path: '/auth'),
      AutoRoute(page: NavWrapperRoute.page, path: '/navbar'),
      // ...
    ];
  }
  ```

- **`app_router.gr.dart`** — generated by `auto_route_generator` (part of
  `app_router.dart`; never hand-edit, regenerate with `dart run
  build_runner build`). For every `@RoutePage()`-annotated widget, this is
  where its `<Screen>Route` class comes from — `replaceInRouteName:
  'Screen,Route'` is why `AuthScreen` becomes `AuthRoute`,
  `OnbordingScreen` becomes `OnbordingRoute`, and so on.

Any widget that should be independently navigable gets `@RoutePage()` and
gets added to `AppRouter.routes` — there's no per-feature routes file, this
is the one place routes are declared. Navigate with `context.router.push(...)`
/ `context.pushRoute(...)` / `context.replaceRoute(...)`, passing the
generated route class (e.g. `context.pushRoute(AuthRoute(role: 'pet_owner'))`
for a route that takes constructor arguments — auto_route generates a
matching `*RouteArgs`/constructor from the screen widget's own constructor
params).

`routers.dart` (same folder) holds a `Routes` class of raw path-string
constants. It isn't part of the active navigation pattern — nothing calls
`context.go(Routes.x)` anywhere; every real navigation uses the typed
route classes above. Don't add new routes there.

## 6. Dependency injection: annotation-only, no per-feature `di/` folder

DI is `get_it` + `injectable`. There is a **single** entrypoint,
`lib/shared/service_locator/service_locator.dart`:

```dart
final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
Future<void> configureDependencies() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(url: ..., anonKey: ...);
  await GetStorage.init();
  getIt.init();  // calls into the generated service_locator.config.dart
}
```

`getIt.init()` (generated) scans the **entire** `lib/` tree for
`@injectable`/`@lazySingleton`/`@LazySingleton(as: ...)`/`@singleton`
annotations and wires everything up automatically. Concretely:

- Feature classes (datasources, repository impls, use cases, cubits) are
  registered by annotating the class directly:
  `@LazySingleton(as: AuthRepoDomain)` on `AuthRepoData`, `@lazySingleton`
  on `AuthUseCase`, `@injectable` on a cubit, etc. **This is the only
  registration step these classes need** — nothing else has to be touched
  for a new class to become resolvable via `GetIt.I<T>()`.
- Third-party objects that need custom construction logic (not just "make
  one of these") go in `shared/service_locator/shared/main_dependencies.dart`,
  a hand-written `@module` class:

  ```dart
  @module
  abstract class ThirdPartyModule {
    @singleton
    GetStorage get storage => GetStorage();
    @singleton
    SupabaseClient get supabaseClient => Supabase.instance.client;
  }
  ```

- `service_locator.config.dart` is **generated** (`dart run build_runner
  build`) — never hand-edit it.

**There is deliberately no per-feature `di/` folder** (no
`features/<name>/di/<name>_di.dart`). A feature-scoped `@InjectableInit`
entrypoint would register classes that the single project-wide scan above
already picks up, making it pure dead weight at best — and if it's never
actually called from `main.dart` (easy to get wrong, since nothing forces
you to wire a second init function into the bootstrap sequence), worse:
registrations quietly don't happen and nothing tells you why. **If you're
adding a new feature, do not create a `di/` folder for it.** Just annotate
your classes and they're wired up automatically.

## 7. Models: dart_mappable

Every data-layer model in this project (`AuthModel`, `PetModel`,
`ProfileModel`/`PetModel`/`PetPhotoModel`/`AdoptionPostModel` in adoption)
uses **`dart_mappable`** — not `freezed`, not `json_serializable`. A model:

```dart
import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';

part 'auth_model.mapper.dart';

@MappableClass()
class AuthModel extends AuthEntity with AuthModelMappable {
  const AuthModel({required super.token, required super.refreshToken});
}
```

`part 'auth_model.mapper.dart';` pulls in the generated
`AuthModelMapper`/`AuthModelMappable` mixin (`dart run build_runner build`,
via the `dart_mappable_builder` dev dependency) — this is what gives the
class `fromMap`/`toMap`/`toJson`/`copyWith`/`==`/`hashCode` without writing
any of it by hand.

Two details worth knowing before you add a new model:

- **JSON keys that don't match the Dart field name need an explicit
  annotation.** `dart_mappable` does not auto-convert `camelCase` fields to
  `snake_case` JSON keys — mark them:

  ```dart
  @MappableField(key: 'owner_id')
  final String ownerId;
  ```

- **`dart_mappable`'s own generated `fromJson` takes a JSON *string*, not a
  `Map`.** Supabase's client returns already-decoded `Map<String,
  dynamic>` objects, so models that get parsed straight from a Supabase
  response add their own small convenience factory:

  ```dart
  factory AdoptionPostModel.fromJson(Map<String, dynamic> json) =>
      AdoptionPostModelMapper.fromMap(json);
  ```

  (`AuthModel` doesn't have one of these because it's never parsed from
  JSON — it's built directly from a Supabase `Session` object's fields.)

A model doesn't have to extend its corresponding domain entity —
`AuthModel`/`PetModel` (add_pet) do (`class AuthModel extends AuthEntity
with AuthModelMappable`), because their fields are identical to the
entity's; adoption's models don't, because they carry extra
Supabase-specific shape (nested `pets`/`profiles`/`pet_photos` objects) and
instead expose an explicit `toEntity()` conversion method. Either is fine —
pick whichever fits the model's actual relationship to its entity.

## 8. Theming

Two files hold the actual design values, both under
`lib/shared/presentation/theme/`:

- **`app_color.dart`** — `abstract class AppColors`, all `static const
  Color` values (`primary50`...`primary500`, `secondary...`,
  `neutral...`, semantic aliases like `background`/`error`/`success`).
- **`app_text_theme.dart`** — `abstract class AppTextStyles`, `static
  TextStyle get` values built from a shared `_poppins(...)` helper
  (`h1`...`h5`, `body1`...`body3`), using `google_fonts` +
  `flutter_screenutil`'s `.sp`/`.h` for responsive sizing.

Screens and widgets **never** reference `AppColors`/`AppTextStyles`
directly for values that should track the theme — they go through the
`BuildContext` extension in
`lib/shared/presentation/extensions/context_theme_extension.dart`:

```dart
extension AppThemeX on BuildContext {
  Color get primary300 => AppColors.primary300;
  Color get primary => AppColors.primary300;      // semantic shortcut
  // ...
  TextStyle get h1 => AppTextStyles.h1;
  TextStyle get bodyLarge => body1;                // semantic shortcut
}
```

So a widget writes `Text('Sign in', style: context.h3.copyWith(color:
context.primary300))`, not `Text('Sign in', style:
AppTextStyles.h3.copyWith(color: AppColors.primary300))`. There's no
`ThemeData`/`ThemeExtension` wired into `MaterialApp` currently (the
`theme:`/`darkTheme:` params on `MaterialApp.router` in `main.dart` are
present but commented out) — every color and text style in the app today
flows through this one `BuildContext` extension. If dark mode or a
Flutter-native `ThemeData` ever gets wired up, this is the file whose
getters would start reading from `Theme.of(context)` instead of the static
`AppColors`/`AppTextStyles` tables — call sites wouldn't need to change.

## 9. Naming conventions

**Files:** `snake_case.dart`. Suffix indicates role:
`_screen.dart` (routed), `_cubit.dart`/`_state.dart` (state, `part`
pair), `_use_case.dart`, `_data_source.dart`, `_repo_data.dart` /
`_repository_domain.dart`, `_model.dart` (+ generated `_model.mapper.dart`),
`_entity.dart`, `_widget.dart` for a standalone reusable widget (not
required for every widget file, e.g. `container_button.dart` omits it).

**Folders:** `snake_case`, plural for collections: `screens/`, `widgets/`,
`repositories/`, `datasources/` (one word, no underscore), `entities/`.
`use_cases/` is the one folder that keeps an underscore. Feature folders
are singular-topic and unsuffixed: `auth`, `home`, `nav` — not
`auth_feature` or `authentication`.

**Classes:** `PascalCase`. Enums are `PascalCase` with `camelCase` values
(e.g. `LoadingState.initial`). A domain contract carries no prefix
(`AuthRepoDomain`, not `IAuthRepoDomain`); its implementation carries the
layer as a suffix (`AuthRepoData`). Cubits: `<Scope>Cubit` /
`<Scope>State`. Use cases: `<Feature>UseCase`.

**Constants:** grouped in an `abstract class` namespace of `static const`
members rather than top-level consts — `AppColors`, `AppTextStyles`,
`AppIcons`, `AppImages`.

**Import style:** absolute `package:rifq_v2/...` imports for
cross-directory references (especially from `features/**` into
`shared/**`), relative imports (`../repositories/...`) for files that stay
within the same feature/folder tree. Both styles appear throughout the
codebase; prefer absolute when crossing a `features/`↔`shared/` boundary,
relative for staying within one feature.

## 10. Adding a new feature — checklist

1. Create `lib/features/<name>/`.
2. Does it need to fetch/store/decide anything, or is it pure UI? If pure
   UI, you're done with structure — just add `presentation/{screens,widgets}`
   (+ `cubit/` if it has local UI state like a page indicator or a form).
   **Do not** create empty `data/`/`domain/` folders "for later."
3. If it has real logic:
   - `domain/entities/<name>_entity.dart` — plain object, no Flutter/Supabase imports.
   - `domain/repositories/<name>_repository_domain.dart` — abstract contract.
   - `domain/use_cases/<name>_use_case.dart` — depends on the domain repository interface only.
   - `data/models/<name>_model.dart` — `@MappableClass()`, `with <Name>ModelMappable`, `@MappableField(key: ...)` on any field whose JSON key differs from its Dart name.
   - `data/datasources/<name>_data_source.dart` — abstract `Base<Name>DataSource` + a concrete impl that talks to `SupabaseClient` (or `DioClient` if it's a plain REST API).
   - `data/repositories/<name>_repo_data.dart` — implements the domain interface, delegates to the datasource. Annotate with `@LazySingleton(as: <Name>RepoDomain)`.
   - Annotate the use case with `@lazySingleton`, the datasource impl with `@LazySingleton(as: Base<Name>DataSource)`.
4. `presentation/cubit/<name>_cubit.dart` + `<name>_state.dart` (`part`/`part of` pair, `Equatable` states). Annotate the cubit `@injectable` if you want it resolvable via `GetIt.I<XCubit>()`; otherwise construct it inline in the screen with its dependencies pulled from DI.
5. `presentation/screens/<name>_screen.dart` for anything that needs its own route — annotate `@RoutePage()`. Everything else composed inside it goes in `presentation/widgets/`.
6. Add the new screen's route to `AppRouter.routes` in `lib/shared/presentation/router/app_router.dart`.
7. **Do not** create a `di/` folder — annotations alone are enough (§6).
8. Run `dart run build_runner build --delete-conflicting-outputs` to generate the model mapper, the DI registration, and the route.
9. If the feature needs a color/text style that doesn't exist yet, add it to `AppColors`/`AppTextStyles` (§8) and expose it through `context_theme_extension.dart` — don't reference the raw classes from a screen.
