# Feature Conventions: Worked Examples (auth, add_pet, home)

This is a companion to [`docs/project_structure.md`](./project_structure.md).
That doc explains the *shape* of the convention (layers, naming, DI
mechanics, routing, theming) in the abstract. This doc does the opposite:
it picks one concrete user action in each of the three fully-built
features — **auth**, **add_pet**, and **home** (the "pet_profile" feature
the project brief refers to — see the note below) — and follows it, real
file and line by real file and line, from the widget the user taps down to
the actual Supabase call. Its purpose is to be the reference you hand back
to me when we build **Hotel**: "do it exactly like this."

**Note on "pet_profile":** there is no `features/pet_profile/` folder. The
screen that shows a single pet's full profile
(`features/account/presentation/screens/pet_profile_screen.dart`) is
actually powered by two *other* features' cubits
(`EditPetCubit` + `HealthRecordCubit`), not by `home`. What `home` owns is
the **Home screen's "Your Pets" strip** — the read/fetch flow that loads
the signed-in user's profile + pet list for display. That's the flow this
doc traces as the third worked example, since it's what the project brief's
parenthetical `pet_profile (home)` points at (`features/home/`), it's a
complete three-layer slice, and it's the read-side counterpart to
add_pet's write-side trace.

---

## 1. End-to-end traces: UI widget → Cubit → UseCase → Repo → DataSource → Supabase

### 1.1 add_pet — tapping "Save" inserts a pet row, a photo row, and uploads to Storage

| Layer | File | Symbol |
|---|---|---|
| UI (widget) | `lib/features/add_pet/presentation/screens/add_pet_screen.dart` | `CustomeButtonWidgets.onPressed` → `context.read<AddPetCubit>().addPet(...)` |
| Presentation (state) | `lib/features/add_pet/presentation/cubit/add_pet_cubit.dart` | `AddPetCubit.addPet()` |
| Domain (use case) | `lib/features/add_pet/domain/use_cases/add_pet_use_case.dart` | `AddPetUseCase.addPet()` |
| Domain (contract) | `lib/features/add_pet/domain/repositories/add_pet_repo_domain.dart` | `abstract class AddPetRepoDomain` |
| Data (repo impl) | `lib/features/add_pet/data/repositories/add_pet_repo_data.dart` | `AddPetRepoData.addPet()` |
| Data (datasource) | `lib/features/add_pet/data/datasources/add_pet_data_source.dart` | `AddPetDataSource.addPet()` |
| Supabase | — | `supabase.storage.from('pet_photos').upload(...)`, `supabase.from('pets').insert(...)`, `supabase.from('pet_photos').insert(...)` |

Step 1 — the button's `onPressed` validates the form, resolves the owner id
straight from the Supabase auth session, and calls the cubit
(`add_pet_screen.dart:190-206`):

```dart
Future<String?> getOwnerId() async {
  // profiles.id matches auth.users.id
  return Supabase.instance.client.auth.currentUser?.id;
}
// ...
final ownerId = await getOwnerId();
context.read<AddPetCubit>().addPet(
  ownerId: ownerId,
  name: nameCtrl.text,
  species: form.species,
  gender: form.gender,
  breed: breedCtrl.text,
  birthdate: form.birthdate!,
  photoFile: form.photoFile!,
);
```

Step 2 — the cubit emits `Loading`, awaits the use case, and emits
`Success`/`Failure` from a plain `try`/`catch` (`add_pet_cubit.dart:15-41`):

```dart
Future<void> addPet({required String ownerId, /* ... */}) async {
  emit(AddPetLoading());
  try {
    await addPetUseCase.addPet(ownerId: ownerId, /* ... */);
    emit(AddPetSuccess("Pet added successfully"));
  } catch (e) {
    emit(AddPetFailure(e.toString()));
  }
}
```

Step 3 — the use case is a pure passthrough to the domain interface
(`add_pet_use_case.dart:13-31`), and the repo impl is a pure passthrough to
the datasource (`add_pet_repo_data.dart:14-34`) — neither layer touches
Supabase directly; they exist purely to keep `domain/` free of Supabase
imports.

Step 4 — the datasource is where Supabase actually gets called
(`add_pet_data_source.dart:26-87`):

```dart
final storagePath = '$ownerId/$fileName';
await supabase.storage.from(StorageBuckets.petPhotos).upload(storagePath, photoFile);
final photoUrl = supabase.storage.from(StorageBuckets.petPhotos).getPublicUrl(storagePath);

final response = await supabase.from('pets').insert({
  'owner_id': ownerId,
  'name': name,
  'species': species,
  'gender': gender,
  'breed': breed,
  'birthdate': _dateOnly(birthdate),
  'age': _ageInYears(birthdate),
}).select().single();

await supabase.from('pet_photos').insert({
  'pet_id': response['id'],
  'uploader_id': ownerId,
  'storage_path': storagePath,
  'public_url': photoUrl,
  'is_primary': true,
  'display_order': 0,
});

await UserDataStore.addPet(ownerId, { /* mirrors the local cache, see §2.3 */ });
return PetModelMapper.fromMap({...response, 'photo': photoUrl});
```

### 1.2 auth — tapping "Sign up" calls Supabase Auth directly (no table write)

| Layer | File | Symbol |
|---|---|---|
| UI (widget) | `lib/features/auth/presentation/widgets/sign_up_tab.dart` | `ContainerButton.onTap` → `cubit.signUp(...)` |
| Presentation (state) | `lib/features/auth/presentation/cubit/auth_cubit.dart` | `AuthCubit.signUp()` |
| Domain (use case) | `lib/features/auth/domain/use_cases/auth_use_case.dart` | `AuthUseCase.signUp()` |
| Domain (contract) | `lib/features/auth/domain/repositories/auth_repository_domain.dart` | `abstract class AuthRepoDomain` |
| Data (repo impl) | `lib/features/auth/data/repositories/auth_repo_data.dart` | `AuthRepoData.signUp()` |
| Data (datasource) | `lib/features/auth/data/datasources/auth_data_source.dart` | `SubaBaseDataSource.signUp()` |
| Supabase | — | `supabase.auth.signUp(email:, password:, data:)` |

Step 1 — the widget validates the form and calls the cubit
(`sign_up_tab.dart:81-95`):

```dart
onTap: () async {
  if (cubit.sinUpFormKey.currentState?.saveAndValidate() ?? false) {
    await cubit.signUp(
      name: cubit.nameController.text,
      email: cubit.sinUpEmailController.text,
      password: cubit.sinUpPasswordController.text,
      role: role,
    );
  }
},
```

Step 2 — the cubit emits `Loading`, then branches on a `Result<T, Object>`
via `.when()` (`multiple_result` package) rather than `try`/`catch`
(`auth_cubit.dart:31-57`):

```dart
Future signUp({required String name, required String email, required String password, required String role}) async {
  emit(AuthLoadingState());
  (await _authUseCase.signUp(name: name, email: email, password: password, role: role)).when(
    (whenSuccess) { this.email = email; emit(AuthSignUPSuccessState()); },
    (whenError) => emit(AuthErrorState(msg: CatchErrorMessage(error: whenError).getWriteMessage())),
  );
}
```

Step 3 — use case and repo impl are pure passthroughs again
(`auth_use_case.dart:13-23`, `auth_repo_data.dart:24-35`).

Step 4 — the datasource calls Supabase Auth directly and never touches a
table (`auth_data_source.dart:58-76`):

```dart
Future<Result<Null, Object>> signUp({required String name, required String email, required String password, required String role}) async {
  try {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name, 'role': role}, // becomes auth.users.raw_user_meta_data
    );
    this.email = email;
    return Success(null);
  } catch (e) {
    return Result.error(CatchErrorMessage(error: e).getWriteMessage());
  }
}
```

`login` follows the same shape but additionally persists the session
locally on success (`auth_data_source.dart:102-127`):

```dart
final response = await _supabase.auth.signInWithPassword(email: email, password: password);
final session = response.session;
if (session == null) return Error(Exception('No session returned from Supabase.'));
await AuthHelper.saveLogin(
  token: session.accessToken,
  refreshToken: session.refreshToken!,
  userId: session.user.id,
);
return Success(null);
```

`AuthHelper` (`lib/shared/storage_service/auth_helper.dart`) is a thin
`GetStorage` wrapper — the session token/refresh token/user id/guest flag
live under one local key, `login`. This is how every other feature answers
"who's signed in" (see `AuthHelper.getUserId()` / `isGuestUser()` in the
home trace below) without re-reading Supabase's own session object.

### 1.3 home ("pet_profile") — opening the Home screen loads profile + pets

| Layer | File | Symbol |
|---|---|---|
| UI (widget) | `lib/features/home/presentation/screens/home_feature_screen.dart` | `BlocProvider(create: (_) => GetIt.I<HomeCubit>()..loadHomeData())` |
| Presentation (state) | `lib/features/home/presentation/cubit/home_cubit.dart` | `HomeCubit.loadHomeData()` |
| Domain (use case) | `lib/features/home/domain/use_cases/home_use_case.dart` | `HomeUseCase.getHomeData()` |
| Domain (contract) | `lib/features/home/domain/repositories/home_repository_domain.dart` | `abstract class HomeRepoDomain` |
| Data (repo impl) | `lib/features/home/data/repositories/home_repo_data.dart` | `HomeRepoData.getHomeData()` |
| Data (datasource) | `lib/features/home/data/datasources/home_data_source.dart` | `HomeDataSource.getHomeData()` |
| Local cache | `lib/shared/storage_service/user_data_store.dart` | `UserDataStore.fetchAndCache()` |
| Supabase | — | `supabase.from('profiles').select(...)`, `supabase.from('pets').select(...)` |

Step 1 — the screen kicks the load off the moment its `BlocProvider` is
built, no button tap needed (`home_feature_screen.dart:26-31`):

```dart
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => GetIt.I<HomeCubit>()..loadHomeData(),
    child: const _HomeView(),
  );
}
```

Step 2 — the cubit emits `Loading`, then branches into `Empty` vs `Loaded`
vs a special `Guest` state on the `Result`'s error channel
(`home_cubit.dart:16-43`):

```dart
Future<void> loadHomeData({bool silent = false, bool forceRefresh = false}) async {
  if (!silent) emit(HomeLoading());
  (await _homeUseCase.getHomeData(forceRefresh: forceRefresh)).when(
    (data) => emit(data.pets.isEmpty ? HomeEmptyState(data: data) : HomeLoadedState(data: data)),
    (error) {
      if (error.toString() == 'guest') { emit(const HomeGuestState()); return; }
      emit(HomeErrorState(msg: CatchErrorMessage(error: error).getWriteMessage()));
    },
  );
}
```

Step 3 — use case and repo impl are pure passthroughs again
(`home_use_case.dart:12-14`, `home_repo_data.dart:13-16`).

Step 4 — the datasource reads from a **local-first snapshot** rather than
hitting Supabase on every load (`home_data_source.dart:22-65`):

```dart
final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
if (userId == null) return Error('User not found');

// Shared snapshot with Account: whichever screen loads first fetches
// once, every later read is local.
var snapshot = forceRefresh ? null : UserDataStore.read(userId);
snapshot ??= await UserDataStore.fetchAndCache(_supabase, userId);

final profile = UserDataStore.profileOf(snapshot);
final pets = UserDataStore.petsOf(snapshot).map((pet) => HomePetEntity(
  id: pet['id'] as String, name: pet['name'] as String? ?? '', photoUrl: pet['photo_url'] as String?,
)).toList();

return Success(HomeDataEntity(username: profile['full_name'] ?? 'User', imageUrl: profile['image_url'], pets: pets));
```

The actual Supabase reads only happen inside `UserDataStore.fetchAndCache`
(`user_data_store.dart:107-136`) — see §2.3 for the exact `select` shape.

---

## 2. Supabase specifics per feature

### 2.1 add_pet

- **Tables written:**
  - `pets` — insert `{owner_id, name, species, gender, breed, birthdate, age}`, then `.select().single()` to get the generated `id`/`created_at` back.
  - `pet_photos` — insert `{pet_id, uploader_id, storage_path, public_url, is_primary, display_order}`, one row per uploaded photo (the first photo is inserted with `is_primary: true, display_order: 0`).
- **Storage:** bucket `pet_photos` (`StorageBuckets.petPhotos`, defined in `lib/shared/constants/storage_buckets.dart`). Path convention: **`<ownerId>/<millisSinceEpoch>_<originalFileName>`** — the owner id as the top-level "folder" is what makes a `storage.objects` RLS policy like `owner_id = auth.uid()` (matched against the path prefix) enforceable. Public URL is fetched via `getPublicUrl(storagePath)` immediately after upload and stored verbatim in `pet_photos.public_url`.
- **Ownership on the client:** `owner_id` is set from `Supabase.instance.client.auth.currentUser?.id`, resolved in the *screen* (`add_pet_screen.dart:61-64`) before the cubit is even called — not derived server-side. RLS on `pets`/`pet_photos` is what's expected to actually enforce that a user can only insert rows for themselves; the client only supplies the value.
- **Error handling — the outlier:** unlike auth/home, the datasource has **no `try`/`catch` at all** — a Supabase exception (`PostgrestException`, `StorageException`) propagates straight up through the repo/use-case passthroughs. It's only caught once, in `AddPetCubit.addPet`'s `catch (e)`, and turned into user-facing text with **`e.toString()`** — not `CatchErrorMessage`. That means add_pet's error toasts show the raw exception string (e.g. `PostgrestException(message: null value in column "name" violates not-null constraint, code: 23502, ...)`) instead of the clean mapped text (`"Required field is missing"`) that auth/home produce. This is a real inconsistency, not an intentional variant — **for Hotel, follow the auth/home pattern** (§2.2), not this one.

### 2.2 auth

- **Tables:** none, directly. Every method in `SubaBaseDataSource` calls a `supabase.auth.*` API (`signUp`, `signInWithPassword`, `verifyOTP`, `resend`, `resetPasswordForEmail`, `signInAnonymously`, `signOut`, `updateUser`) — no `supabase.from(...)` call appears anywhere in `auth_data_source.dart`. `signUp` passes `full_name`/`role` as **auth user metadata** (`data: {...}`), not as a table insert; a `public.profiles` row presumably gets created by a Supabase DB trigger on `auth.users` insert (not part of this Flutter codebase, so not verifiable from here — worth confirming server-side before assuming the same trigger will cover any new signup-adjacent fields Hotel might need).
- **Storage:** none.
- **Ownership:** N/A (auth is the thing that *establishes* identity, not a consumer of `owner_id`). Post-login, `AuthHelper.saveLogin` persists `token`/`refreshToken`/`userId` to local `GetStorage` — this is the local source of truth every other feature reads via `AuthHelper.getUserId()`.
- **Error handling:** every method wraps its Supabase call in `try { ... } catch (e) { return Result.error(CatchErrorMessage(error: e).getWriteMessage()); }`. `CatchErrorMessage.getWriteMessage()` (`lib/shared/errors/custome_exception.dart:17-70`) switches on the exception's runtime type — `PostgrestException`, `AuthApiException`, `AuthException`, `StorageException`, `SocketException`, plain `String`, `CustomException`, generic `Exception` — and extracts a clean, presentable message from each. The formatted `String` is what actually travels inside `Result.error(...)`; the cubit's own `CatchErrorMessage(error: whenError).getWriteMessage()` call on the error branch is therefore operating on an already-`String` value, which the `case String error:` branch just returns unchanged — so the real formatting happens exactly once, in the datasource.
- **A separate, unused mechanism worth knowing about:** `lib/shared/errors/failure.dart` (a `Failure`/`ServerFailure`/`ValidationFailure`/... hierarchy) and `lib/shared/errors/network_exceptions.dart` (`FailureExceptions.getException`, which maps exceptions to that hierarchy) exist in the codebase but **are not called anywhere** in auth, add_pet, or home. Every actual error path in these three features goes through `CatchErrorMessage.getWriteMessage() → String`, not `FailureExceptions.getException() → Failure`. Don't reach for `Failure` when building Hotel — it isn't the established pattern, `CatchErrorMessage` is.

### 2.3 home ("pet_profile")

- **Tables read** (`user_data_store.dart:107-136`, called from `HomeDataSource`):
  - `profiles` — `.select('id, role, full_name, phone_number, image_url, created_at, updated_at').eq('id', userId).maybeSingle()` (the exact column list lives in `UserDataStore.profileSelect`).
  - `pets` — `.select('id, name, species, gender, breed, age, birthdate, weight, pet_photos(public_url, is_primary, display_order), adoption_posts(status)').eq('owner_id', userId).order('created_at', ascending: false)`. Note the **nested embed syntax** (`pet_photos(...)`, `adoption_posts(...)`) — Supabase's PostgREST resolves these via the foreign-key relationship in one round trip rather than N+1 queries. The photo actually shown is picked client-side: sort by `is_primary` first, then `display_order`, take the first.
- **Storage:** none directly — `pet_photos.public_url` was already written by add_pet at upload time (§2.1); home only reads it.
- **Ownership:** both queries filter by the current user's id (`.eq('id', userId)` / `.eq('owner_id', userId)`), where `userId` comes from `AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id` — same client-supplies-the-filter, RLS-enforces-the-boundary pattern as add_pet.
- **Local-first caching:** `UserDataStore` (`lib/shared/storage_service/user_data_store.dart`, `GetStorage`-backed) holds one JSON snapshot per user (`{profile, email, pets}`). `HomeDataSource.getHomeData` reads the cached snapshot first and only calls `fetchAndCache` (the actual Supabase round trip) when nothing is cached yet or `forceRefresh: true` is passed (e.g. pull-to-refresh). Mutations elsewhere (`UserDataStore.addPet`, called from add_pet's datasource) patch the cache directly so Home reflects a new pet immediately without a refetch. **If Hotel needs to show booking data on Home or reuse the "who's the current user" snapshot, extend `UserDataStore` rather than adding a second local cache.**
- **Error handling:** identical `CatchErrorMessage` convention to auth (§2.2).

---

## 3. Model convention: dart_mappable, in practice

Full worked example — `PetModel` (`lib/features/add_pet/data/models/pet_model.dart`), the model returned by add_pet's datasource:

```dart
import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';

part 'pet_model.mapper.dart';

@MappableClass()
class PetModel extends AddPetEntity with PetModelMappable {
  @MappableField(key: 'owner_id')
  @override
  final String ownerId;

  @MappableField(key: 'photo')
  @override
  final String photoUrl;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  const PetModel({
    required String id, required this.ownerId, required String name,
    required String species, required String gender, required String breed,
    required DateTime birthdate, required this.photoUrl, required this.createdAt,
  }) : super(id: id, ownerId: ownerId, name: name, species: species, gender: gender,
             breed: breed, birthdate: birthdate, photoUrl: photoUrl);
}
```

What `dart run build_runner build` generates into `pet_model.mapper.dart`
(never hand-edited) — the pieces that matter day to day:

```dart
static PetModel fromMap(Map<String, dynamic> map) => ensureInitialized().decodeMap<PetModel>(map);
static PetModel fromJson(String json) => ensureInitialized().decodeJson<PetModel>(json);
// mixin PetModelMappable adds instance-side:
Map<String, dynamic> toMap() => PetModelMapper.ensureInitialized().encodeMap<PetModel>(this as PetModel);
String toJson() => PetModelMapper.ensureInitialized().encodeJson<PetModel>(this as PetModel);
```

Three things to reproduce exactly when Hotel gets its own model:

1. **`@MappableField(key: '...')` is required wherever the Dart field name
   and the Supabase column name differ** (`ownerId` ↔ `owner_id`, `photoUrl`
   ↔ `photo`, `createdAt` ↔ `created_at`). `dart_mappable` does not
   auto-convert `camelCase` ↔ `snake_case`.
2. **The generated `fromJson` takes a JSON `String`, not a `Map`** —
   `PetModel` is built from a decoded Supabase response via `fromMap`
   (`PetModelMapper.fromMap({...response, 'photo': photoUrl})` in
   `add_pet_data_source.dart:86`), not `fromJson`. Some models
   (`AccountModel`, in `account_model.dart:45-46`) add their own
   `factory X.fromJson(Map<String, dynamic> json) => XModelMapper.fromMap(json)`
   convenience wrapper for readability at the call site — either spelling
   is fine, just be clear it's calling `fromMap` under the hood.
3. **The model extends its entity** (`PetModel extends AddPetEntity with
   PetModelMappable`) when the fields line up 1:1, which is the common
   case and what Hotel should default to. (`AuthModel` does the same,
   trivially, in `lib/features/auth/data/models/auth_model.dart`.)

---

## 4. DI registration: annotate the class, nothing else

No feature in this project — including all three canonical ones — has a
`di/` folder; a project-wide `find lib/features -type d -name di` returns
nothing. Registration is purely annotation-driven, picked up by
`dart run build_runner build` into the single generated
`lib/shared/service_locator/service_locator.config.dart`. The add_pet chain,
end to end, as it actually appears in that generated file:

```dart
gh.lazySingleton<_i734.BaseAddPetDataSource>(
  () => _i734.AddPetDataSource(gh<_i454.SupabaseClient>()),
);
gh.lazySingleton<_i52.AddPetRepoDomain>(
  () => _i63.AddPetRepoData(gh<_i734.BaseAddPetDataSource>()),
);
gh.factory<_i667.AddPetUseCase>(
  () => _i667.AddPetUseCase(gh<_i52.AddPetRepoDomain>()),
);
gh.factory<_i493.AddPetCubit>(
  () => _i493.AddPetCubit(gh<_i667.AddPetUseCase>()),
);
```

That comes purely from the annotations on the source classes —
`@LazySingleton(as: BaseAddPetDataSource)` on `AddPetDataSource`,
`@LazySingleton(as: AddPetRepoDomain)` on `AddPetRepoData`,
`@injectable` on `AddPetUseCase` and `AddPetCubit`. `SupabaseClient` itself
comes from the one hand-written `@module` in
`lib/shared/service_locator/shared/main_dependencies.dart` — it's provided
once, globally, and every feature's datasource just declares it as a
constructor dependency.

**One exception worth knowing before copying a pattern wholesale:**
`AuthCubit` is **not** annotated at all — it doesn't appear in
`service_locator.config.dart`. Every screen that needs it constructs it
manually: `BlocProvider(create: (_) => AuthCubit(GetIt.I.get<AuthUseCase>()))`
(`auth_screen.dart:25`, `welcome_screen.dart:22`). This still works (the
use case underneath it *is* DI-registered), but it means `AuthCubit` can't
be resolved with `GetIt.I<AuthCubit>()`/`getIt<AuthCubit>()` the way
`AddPetCubit`/`HomeCubit`/`AccountCubit`/`EditPetCubit`/`HealthRecordCubit`
all can. **For Hotel, annotate `HotelCubit` with `@injectable`** and
construct it the add_pet/home way — `BlocProvider(create: (_) =>
getIt<HotelCubit>()..load())` — rather than the auth way. It's what every
other cubit in the project does; auth is the one holdout.

---

## 5. State/Cubit pattern: loading → success → error, as a template

add_pet's cubit/state pair is the cleanest minimal template — copy this
shape for any single-action flow (submit a form, fire one write) that
doesn't need a Result type:

```dart
// hotel_state.dart
part of 'hotel_cubit.dart';

sealed class HotelState extends Equatable {
  const HotelState();
  @override
  List<Object?> get props => [];
}

final class HotelInitial extends HotelState {}
final class HotelLoading extends HotelState {}
final class HotelSuccess extends HotelState {
  final String message;
  const HotelSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
final class HotelFailure extends HotelState {
  final String error;
  const HotelFailure(this.error);
  @override
  List<Object?> get props => [error];
}
```

```dart
// hotel_cubit.dart
@injectable
class HotelCubit extends Cubit<HotelState> {
  final HotelUseCase _useCase;
  HotelCubit(this._useCase) : super(HotelInitial());

  Future<void> bookHotel({/* ... */}) async {
    emit(HotelLoading());
    try {
      await _useCase.bookHotel(/* ... */);
      emit(HotelSuccess('Booking confirmed'));
    } catch (e) {
      emit(HotelFailure(e.toString()));
    }
  }
}
```

The UI reacts with a `BlocListener` for one-shot side effects (toast +
navigation pop) and a `BlocBuilder` for the button's loading spinner — this
is exactly `add_pet_screen.dart:68-77` and `:161-213`:

```dart
BlocListener<AddPetCubit, AddPetState>(
  listener: (context, state) {
    if (state is AddPetSuccess) {
      context.showSuccessToast('Pet added successfully');
      Navigator.pop(context, true);
    } else if (state is AddPetFailure) {
      context.showErrorToast(state.error);
    }
  },
  child: /* ... BlocBuilder<AddPetCubit, AddPetState> drives isLoading: state is AddPetLoading ... */
)
```

**One deliberate upgrade over the add_pet template:** for the *domain
contract* (the use case and repository interface), prefer the
`Future<Result<T, Object>>` shape that auth and home use, not add_pet's
`Future<T>` (throws-on-failure) shape. Concretely:

```dart
// domain/repositories/hotel_repository_domain.dart
abstract class HotelRepoDomain {
  Future<Result<HotelBookingEntity, Object>> bookHotel({/* ... */});
}
```

```dart
// hotel_cubit.dart, using Result instead of try/catch
Future<void> bookHotel({/* ... */}) async {
  emit(HotelLoading());
  (await _useCase.bookHotel(/* ... */)).when(
    (booking) => emit(HotelSuccess('Booking confirmed')),
    (error) => emit(HotelFailure(CatchErrorMessage(error: error).getWriteMessage())),
  );
}
```

This is the majority pattern (2 of 3 canonical features), it's what forces
the datasource to actually catch and format Supabase exceptions instead of
letting them propagate raw (§2.1's flagged add_pet gap), and it keeps error
formatting (`CatchErrorMessage`) at the datasource boundary where the
concrete exception type is known, instead of at the cubit where it isn't.

---

## 6. Recipe: building Hotel, file by file

This elaborates `docs/project_structure.md` §10 with Hotel-specific
specifics learned from tracing the three reference features above.

1. **Confirm the Supabase schema first** — table name(s) (e.g. `hotels`,
   `hotel_bookings`), their columns, and whether bookings need a storage
   bucket (e.g. room photos). Nothing below can be filled in accurately
   without this.
2. `lib/features/hotel/domain/entities/hotel_entity.dart` — plain
   `Equatable` class(es), no Flutter/Supabase imports (mirrors
   `add_pet_entity.dart`).
3. `lib/features/hotel/domain/repositories/hotel_repository_domain.dart` —
   abstract `HotelRepoDomain`, methods return `Future<Result<T, Object>>`
   (§5's recommended shape, not add_pet's throwing shape).
4. `lib/features/hotel/domain/use_cases/hotel_use_case.dart` — one
   `@injectable` (or `@lazySingleton`, both appear in the codebase; use
   `@lazySingleton` to match auth/home) class depending only on
   `HotelRepoDomain`, one thin passthrough method per action.
5. `lib/features/hotel/data/models/hotel_model.dart` (+ generated
   `hotel_model.mapper.dart`) — `@MappableClass()`, extends the entity,
   `with HotelModelMappable`, `@MappableField(key: 'snake_case_column')` on
   every field whose Supabase column name differs from the Dart field name
   (§3).
6. `lib/features/hotel/data/datasources/hotel_data_source.dart` — abstract
   `BaseHotelDataSource` + `HotelDataSource implements BaseHotelDataSource`,
   constructor-injects `SupabaseClient`, **wraps every Supabase call in
   `try`/`catch` and returns `Result.error(CatchErrorMessage(error: e).getWriteMessage())`
   on failure** (§2.2/§2.3 pattern — do not skip the try/catch the way
   add_pet did). Annotate `@LazySingleton(as: BaseHotelDataSource)`.
7. `lib/features/hotel/data/repositories/hotel_repo_data.dart` —
   `HotelRepoData implements HotelRepoDomain`, delegates to the datasource,
   `@LazySingleton(as: HotelRepoDomain)`.
8. `lib/features/hotel/presentation/cubit/hotel_cubit.dart` +
   `hotel_state.dart` — `part`/`part of` pair, `Equatable` states
   (`Initial`/`Loading`/`Loaded or Success`/`Error or Failure`),
   **`@injectable` on the cubit** (§4 — don't repeat auth's manual-construction
   exception).
9. `lib/features/hotel/presentation/screens/hotel_screen.dart` —
   `@RoutePage()`, `BlocProvider(create: (_) => getIt<HotelCubit>()..load())`.
   Everything else composed inside it goes in `presentation/widgets/`.
10. Register the route in
    `lib/shared/presentation/router/app_router.dart` — add the import and
    an `AutoRoute(page: HotelRoute.page, path: '/hotel')` entry (follow the
    existing `path:` naming style, all lowercase-hyphenated).
11. **Wire it into the bottom nav — this is Hotel-specific and already
    half-done:** `lib/features/nav/presentation/cubit/nav_cubit.dart`'s
    `screens` list has a commented-out `// HotelHomeScreen(),` at index 2,
    and `lib/features/nav/presentation/screens/nav_screen.dart`'s "Hotel"
    tab already calls `cubit.changeIndex(index: 2)`. Home's own "Pet Hotel"
    quick-service tile (`home_feature_screen.dart:181-186`) also already
    navigates to `index: 2` via `NavCubit`. All that's needed is
    uncommenting/adding the real screen widget into that list — no new nav
    wiring code.
12. If Hotel needs image upload (room photos, etc.), add a bucket constant
    to `lib/shared/constants/storage_buckets.dart` next to
    `petPhotos`/`userProfiles`, and follow add_pet's
    `<ownerOrEntityId>/<timestamp>_<filename>` path convention (§2.1) so an
    RLS policy can key off the path prefix.
13. Run `dart run build_runner build --delete-conflicting-outputs` once —
    this regenerates the model mapper, the DI config, and the route in one
    pass.
14. If a new color/text style is needed, add it to `AppColors`/
    `AppTextStyles` and expose it via `context_theme_extension.dart` —
    don't reference the raw theme classes from a screen (`project_structure.md` §8).
