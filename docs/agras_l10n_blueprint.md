# Flutter Localization Blueprint

**Portable engineering reference — Flutter i18n**

Everything needed to rebuild the `gen-l10n` + ARB + `LocaleCubit` localization stack
from a real bilingual (English / Arabic) Flutter app, in a brand-new project. The
mechanism is described generically; this codebase's own files are shown only as
worked examples.

| | |
|---|---|
| **Tooling** | `flutter gen-l10n` |
| **Packages** | `flutter_localizations` · `intl` |
| **State** | `flutter_bloc` Cubit |
| **Persistence** | `shared_preferences` |
| **Locales** | `en` · `ar` (RTL) |

## Contents

1. [Packages & dependency setup](#1--packages--dependency-setup)
2. [Configuration file](#2--configuration-file)
3. [Source-of-truth files](#3--source-of-truth-files)
4. [Code generation](#4--code-generation)
5. [Locale switching mechanism](#5--locale-switching-mechanism)
6. [Wiring into the app root](#6--wiring-into-the-app-root)
7. [RTL / LTR handling](#7--rtl--ltr-handling)
8. [Usage pattern in widgets](#8--usage-pattern-in-widgets)
9. [End-to-end: add a new translated string](#9--end-to-end-add-one-new-translated-string)
10. [Appendix: minimal file set](#10--appendix-minimal-file-set-to-replicate-this-from-scratch)

---

## 1 · Packages & dependency setup

### Two packages do all the work

Flutter's first-party localization stack needs only **two** dependencies. Everything
else in this architecture (the cubit, persistence) is ordinary app code you would
have anyway.

- **`flutter_localizations`** — an SDK package (not from pub.dev). Supplies
  `GlobalMaterialLocalizations`, `GlobalWidgetsLocalizations` and
  `GlobalCupertinoLocalizations`: the built-in translations and, critically, the
  **text-direction** resolution for every locale (this is what flips the whole app
  to RTL for Arabic).
- **`intl`** — provides `Intl.pluralLogic`, `Intl.select`, `DateFormat`,
  `NumberFormat`. The generated code calls into it at runtime. Pin the version that
  matches your Flutter SDK's constraint (Flutter bumps this in lockstep).

The relevant `pubspec.yaml` entries, verbatim from this project:

```yaml
# pubspec.yaml — dependencies
dependencies:
  flutter:
    sdk: flutter

  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2

  # ... rest of app deps
  flutter_bloc: ^9.1.1         # Cubit that holds the active Locale
  injectable: ^2.1.0           # DI annotations
  get_it: ^7.6.0               # service locator the cubit is resolved from
  shared_preferences: ^2.2.3   # persists the chosen language across restarts
```

```yaml
# pubspec.yaml — flutter: section
flutter:
  generate: true          # ← turns on gen-l10n. Without this, nothing is generated.
  uses-material-design: true
```

`generate: true` is the switch that makes `flutter` run the localization generator
as part of `pub get` / `run` / `build`. It is easy to miss and produces no error
when absent — the generated class simply never appears.

> **Gotcha — the extra `flutter_intl:` block**
>
> This project's `pubspec.yaml` also contains a `flutter_intl:` section
> (`enabled: true`, `gen_l10n: true`). That belongs to the third-party *"Flutter
> Intl"* IDE plugin. Because `gen_l10n: true` tells that plugin to defer to the
> official generator and honour `l10n.yaml`, it is effectively redundant here.
> **You do not need it** in a new project — `generate: true` plus
> `flutter gen-l10n` is the whole mechanism.

---

## 2 · Configuration file

### l10n.yaml — four lines, project root

`flutter gen-l10n` auto-reads `l10n.yaml` from the project root. This project keeps
it minimal; every other option stays at its default.

```yaml
# l10n.yaml — complete file
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-dir: lib/l10n/generated/
```

| Setting | Value here | What it does |
|---|---|---|
| `arb-dir` | `lib/l10n` | Folder the generator scans for `*.arb` translation files. |
| `template-arb-file` | `app_en.arb` | The canonical file. Its keys define the API surface; its values are the fallback used when another locale is missing a key. English is the source of truth. |
| `output-localization-file` | `app_localizations.dart` | Name of the main generated Dart file. The abstract class inside it is named from this (`app_localizations` → `AppLocalizations`). |
| `output-dir` | `lib/l10n/generated/` | Where generated files land. Placing it inside `lib/` means the code is imported with a normal `package:` path and is committed to version control (see §4). |

### Defaults worth knowing (not set here, so they apply)

- `output-class: AppLocalizations` — the class name callers use.
- `nullable-getter: true` — `AppLocalizations.of(context)` returns
  `AppLocalizations?`. This is why app code that unwraps it uses `!` (see §8). Set
  it to `false` if you prefer a non-null return.
- `synthetic-package: false` is now the effective behaviour — generated files are
  real files in `output-dir`, not a hidden `package:flutter_gen`.
- `untranslated-messages-file` — unset, so missing translations are only reported
  as console warnings during generation. Point it at a file if you want a
  machine-readable list of gaps.

---

## 3 · Source-of-truth files

### ARB files: JSON with an ICU dialect

**ARB** ("Application Resource Bundle") is plain JSON. One file per locale, named
`app_<langcode>.arb`. This project has exactly two: `lib/l10n/app_en.arb`
(template) and `lib/l10n/app_ar.arb`. Every file starts with the required
`@@locale` key.

### Anatomy of an entry

Each user-facing string is one JSON member. An optional sibling member whose key is
the same string prefixed with `@` carries *metadata* (description, placeholder
types).

```jsonc
// lib/l10n/app_en.arb — template · excerpt
{
  "@@locale": "en",

  // 1 — simple string, no metadata needed
  "onboarding_start_now": "Start Now",
  "settings_section_language": "Language",

  // 2 — string with a named placeholder {name}
  "app_header_hello": "Hello {name}",
  "@app_header_hello": {
    "placeholders": {
      "name": { "type": "String" }
    }
  },

  // 3 — two int placeholders
  "home_installment_progress": "Installment {number} of {total}",
  "@home_installment_progress": {
    "placeholders": {
      "number": { "type": "int" },
      "total":  { "type": "int" }
    }
  },

  // 4 — ICU plural. {days, plural, one{...} other{...}} — nested {days} is the value.
  "home_due_in_days": "{days, plural, one{Due in 1 day} other{Due in {days} days}}",
  "@home_due_in_days": {
    "placeholders": { "days": { "type": "int" } }
  }
}
```

```jsonc
// lib/l10n/app_ar.arb — Arabic · same keys, translated values
{
  "@@locale": "ar",
  "onboarding_start_now": "ابدأ الآن",
  "settings_section_language": "اللغة",
  "app_header_hello": "مرحبا {name}",
  "home_installment_progress": "القسط {number} من {total}",
  "home_due_in_days": "{days, plural, one{يستحق خلال يوم واحد} other{يستحق خلال {days} أيام}}"
}
```

### Syntax rules

- **Key** — `snake_case` by convention here; becomes a Dart identifier, so it must
  be a valid one. A loose namespace prefix (`home_`, `register_`, `settings_`)
  keeps ~600 keys navigable.
- **Value** — the translated text. `{placeholderName}` interpolates a runtime
  argument.
- **Metadata** lives only in the `@key` sibling and only in the **template** file.
  Translation files carry *values only* — no `@` entries. `"description"` is
  optional free text for translators; `"placeholders"` declares argument names +
  `type` (`String`, `int`, `num`, `double`, `DateTime`). A placeholder used in the
  string but not declared defaults to `Object`.
- **ICU plural** — `{arg, plural, one{…} other{…}}`. Categories:
  `zero one two few many other`; `other` is mandatory. `select`
  (`{arg, select, …}`) works the same way for enum-like branching.

> **Key parity**
>
> In this codebase `app_en.arb` and `app_ar.arb` have **full key parity** — every
> English key has an Arabic value. When a locale *is* missing a key, generation
> still succeeds: the getter is emitted using the template's English string and a
> warning is printed. Treat those warnings as a translation to-do list.

> **Gotcha — Arabic plural categories**
>
> The ARB plurals here define only `one` and `other`. Arabic's CLDR rules actually
> distinguish `zero`, `one`, `two`, `few` (3–10) and `many` (11–99).
> `Intl.pluralLogic` falls back to `other` for any category you didn't supply, so
> grammatically-imperfect Arabic counting is silently accepted. If exactness
> matters, add the missing categories to the Arabic value only.

---

## 4 · Code generation

### From ARB to a typed Dart API

#### Which command, and when it runs

- **Automatically** — because `generate: true` is set, the generator runs during
  `flutter pub get`, `flutter run` and `flutter build`.
- **On demand** — `flutter gen-l10n` (reads `l10n.yaml`, no args). This project's
  `CLAUDE.md` instructs developers to run it after editing any ARB file. It is
  *not* a `build_runner` task — `dart run build_runner` (used here for DI + JSON
  models) does not touch localizations.
- **IDE** — the Flutter/Dart plugins regenerate on ARB save when `generate: true`.

> **Committed, not ignored**
>
> `lib/l10n/generated/` is checked into git in this repo (nothing in `.gitignore`
> excludes it). Regenerating produces a reviewable diff you commit alongside the
> ARB change. CI here only runs `flutter pub get`, which regenerates them anyway —
> committing keeps local analyzer/IDE happy without a build step.

#### What gets generated

Three files, from `output-localization-file: app_localizations.dart`:

- `app_localizations.dart` — the abstract `AppLocalizations` class (the API), the
  `LocalizationsDelegate`, the supported-locale list, and the
  `lookupAppLocalizations()` switch.
- `app_localizations_en.dart` — `class AppLocalizationsEn extends AppLocalizations`
  with every string as a concrete `@override`.
- `app_localizations_ar.dart` — likewise `AppLocalizationsAr`.

```dart
// lib/l10n/generated/app_localizations.dart — generated · API surface
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  // the lookup entry point callers use
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // this delegate + the three Global*Localizations delegates, ready for MaterialApp
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  // simple key  →  a getter
  String get onboarding_start_now;

  // placeholder key  →  a method with typed params
  String app_header_hello(String name);
  String home_installment_progress(int number, int total);

  // plural key  →  also a method
  String home_due_in_days(int days);
}
```

```dart
// lib/l10n/generated/app_localizations_en.dart — generated · concrete impl
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboarding_start_now => 'Start Now';

  @override
  String app_header_hello(String name) {
    return 'Hello $name';
  }

  @override
  String home_due_in_days(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Due in $days days',
      one: 'Due in 1 day',
    );
    return '$_temp0';
  }
}
```

```dart
// lib/l10n/generated/app_localizations.dart — generated · delegate + lookup
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }
  throw FlutterError('...unsupported locale "$locale"...');
}
```

**The generated API in one line:** get an instance with
`AppLocalizations.of(context)`, then read `.someKey` (getter) or call
`.someKey(arg)` (placeholder / plural).

---

## 5 · Locale switching mechanism

### A one-field Cubit, backed by SharedPreferences

The active locale is application state, held in a `flutter_bloc` `Cubit`. Nothing
about the generated code knows this exists — the cubit's only job is to feed a
`Locale` into `MaterialApp` (§6) and to persist the choice.

### The state & the cubit

```dart
// lib/l10n/cubit/locale_state.dart — complete
part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}
```

```dart
// lib/l10n/cubit/locale_cubit.dart — complete
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required Locale locale}) : super(LocaleState(locale));

  Future<void> changeLocale({required SupportedLocale localeCode}) async {
    // Awaited on purpose: the write has to land before the app can be
    // killed or restarted, otherwise the picked language silently reverts
    // on next launch. It also feeds the Accept-Language header, which reads
    // this key straight from storage on every request.
    await StorageService.setString(StorageKeys.localCode, localeCode.name);
    emit(LocaleState(Locale(localeCode.name)));
  }
}
```

The supported set is a tiny enum — its `.name` (`"en"` / `"ar"`) is both the
storage value and the `Locale` language code:

```dart
// lib/shared/constants/locales.dart — complete
enum SupportedLocale { en, ar }
```

### Persistence — SharedPreferences, one string key

The choice is stored as a plain string under the key `localCode` via a thin static
wrapper around `shared_preferences`. Not secure storage — a language preference is
not a secret, and it must be readable synchronously at startup.

```dart
// lib/shared/storage_service/*.dart — relevant parts

// storage_keys.dart
class StorageKeys {
  static const String localCode = 'localCode';
  // ...
}

// storage_service.dart — SharedPreferences loaded once at boot, then sync access
class StorageService {
  static late SharedPreferences _prefs;
  Future<void> initialize() async { _prefs = await SharedPreferences.getInstance(); }

  static Future<bool> setString(String key, dynamic value) async =>
      _prefs.setString(key, value.toString());
  static String? getString(String key) => _prefs.getString(key);
}
```

### Exposed through the service locator

`LocaleCubit` needs a constructed `Locale` argument, so it can't be a bare
`@injectable`. It is registered as a **`@singleton`** via an `injectable`
**module** getter that reads the saved value (defaulting to Arabic) and builds the
initial state:

```dart
// lib/shared/service_locator/shared/main_dependencies.dart — excerpt
@module
abstract class MainDependencies {

  @singleton
  LocaleCubit get localeCubit {
    final savedLocale = StorageService.getString(StorageKeys.localCode) ?? 'ar';
    return LocaleCubit(locale: Locale(savedLocale));
  }

  // The SAME storage key is also read on every HTTP request to set the
  // Accept-Language header — locale state and API language stay in sync
  // because both derive from StorageKeys.localCode, not from each other.
  // (inside the Dio dynamic-headers interceptor)
  ApiConfiguration.acceptLanguageKey:
      StorageService.getString(StorageKeys.localCode) ?? 'ar',
}
```

```dart
// lib/shared/service_locator/service_locator.config.dart — generated by injectable
gh.singleton<LocaleCubit>(() => mainDependencies.localeCubit);
```

Boot order in `main()` matters — storage must be ready before the cubit is built:

```dart
// lib/main.dart — mainCommon()
Future<void> mainCommon(AppConfigModel appConfigModel) async {
  await StorageService.instance.initialize();  // 1. prefs loaded
  await FirebaseManager.initializeFirebase();
  configureDependencies();                     // 2. builds LocaleCubit, reads saved locale
  runApp(appConfigModel.appWidget);            // 3. UI starts already on the right language
}
```

### Persisted across restarts?

**Yes.** `changeLocale` `await`s the SharedPreferences write; on the next launch
`MainDependencies.localeCubit` reads it back and seeds the initial `LocaleState`.
No app restart is needed to *apply* a change at runtime — see §6.

---

## 6 · Wiring into the app root

### The cubit's `Locale` drives `MaterialApp`

Three properties connect the generated code to the framework; a fourth (`locale`)
connects the cubit. The app watches the cubit, so emitting a new `LocaleState`
rebuilds `MaterialApp` with a new `locale:`, and every
`AppLocalizations.of(context)` below it returns the new language — live, no
restart.

```dart
// lib/main.dart — MyApp.build()
return MultiBlocProvider(
  providers: [
    BlocProvider<LocaleCubit>(create: (_) => getIt<LocaleCubit>()),
    BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>()),
    BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()),
  ],
  child: Builder(
    builder: (buildContext) {
      // watch → this Builder rebuilds whenever the locale changes
      final locale = buildContext.watch<LocaleCubit>().state.locale;

      return MaterialApp.router(
        routerConfig: AppRouter.routerConfig,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: locale,                             // ← from the cubit
        theme: _applyFont(AppTheme.light, locale),  // per-locale font, see §7
        darkTheme: _applyFont(AppTheme.dark, locale),
        themeMode: themeMode,
        builder: (context, child) => VpnGuard(child: child!),
      );
    },
  ),
);
```

| Property | Fed from | Role |
|---|---|---|
| `localizationsDelegates` | `AppLocalizations.localizationsDelegates` | Your generated delegate + the 3 `Global*Localizations` delegates. Loads the right `AppLocalizations*` subclass and drives Material/Cupertino/Widgets translations and text direction. |
| `supportedLocales` | `AppLocalizations.supportedLocales` | `[Locale('ar'), Locale('en')]`. Used for device-locale negotiation when `locale:` is null. |
| `locale` | `context.watch<LocaleCubit>().state.locale` | Forces the app to this exact locale, overriding the device. Changing it re-runs the delegates. |

### Data flow

```
                changeLocale() writes here first
        ┌──────────────────────────────────────────────────────────┐
        │                                                          ▼
┌───────────────────┐  read    ┌──────────────┐        ┌──────────────────┐
│  SharedPreferences │ at boot  │  LocaleCubit │        │   MaterialApp    │
│  key: localCode    │─────────▶│  @singleton  │───────▶│  locale: ·       │──rebuild──▶ tr.someKey
│                    │          │  state:Locale│        │  delegates       │            AppLocalizations
└───────────────────┘          └──────────────┘        │  context.watch   │            .of(context)!
        │                                              └──────────────────┘
        │  same key, read per-request
        └───────────────────────────────────────────────▶ Dio interceptor
                                                          Accept-Language header
```

One SharedPreferences key is the single source of truth. `changeLocale()` writes
it, then emits; `MaterialApp` re-reads via `watch` and reloads the delegates; the
network layer reads the same key independently, so UI language and API
`Accept-Language` never drift.

---

## 7 · RTL / LTR handling

### Direction is automatic; the work is the exceptions

Because `GlobalWidgetsLocalizations.delegate` is in the delegate list, selecting
`Locale('ar')` makes Flutter wrap the app in
`Directionality(textDirection: rtl)`. Layout widgets that use *directional* insets
(`EdgeInsetsDirectional`, `AlignmentDirectional`, `start`/`end`) mirror for free;
rows, text alignment, drawer side, back-button direction all flip. **You write no
code for the common case.**

This codebase's manual interventions are all in one of four buckets:

### 1 · Force LTR for inherently-LTR data

Phone numbers, IBANs, emails, and money read left-to-right even in an Arabic UI.
These are wrapped in an explicit `Directionality` override.

```dart
// lib/shared/presentation/widgets/riyal_amount.dart — excerpt
// Directionality.ltr forces the same layout in BOTH English and Arabic:
// riyal icon always on the left, digits always on the right.
return Directionality(
  textDirection: TextDirection.ltr,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SvgPicture.asset('assets/icons/saudi-riyal.svg', width: iconSize, height: iconSize),
      const SizedBox(width: 2),
      Text(textValue),   // textValue = '\u200E-1,234.5' — U+200E LRM pins the minus to the digits
    ],
  ),
);
```

Same pattern in `phone_input_field.dart` (wraps `IntlPhoneField`),
`profile_form_widget.dart` / `profile_header_widget.dart` (email & phone fields),
and `wallet_card_widget.dart`. The Unicode `\u200E` (LEFT-TO-RIGHT MARK, U+200E) trick
keeps a leading `-` glued to the number inside an RTL paragraph.

### 2 · Direction-aware asset selection

An `enum` of assets stores an `ltrPath` and an `rtlPath` and picks at build time
off the ambient direction — used for chevrons/arrows that must point the "forward"
way in each locale.

```dart
// lib/shared/presentation/assets/assets.dart — excerpt
String getPath(BuildContext context) {
  return Directionality.of(context) == TextDirection.rtl ? rtlPath : ltrPath;
}
```

### 3 · Locale-keyed subtree rebuilds

The global `tr` accessor (§8) is not a widget dependency — a screen that only reads
`tr.*` won't rebuild when the language changes mid-session unless something forces
it. Screens that can be visible during a switch (onboarding) put a `ValueKey` on
the locale so the subtree is torn down and rebuilt:

```dart
// lib/features/onboarding/presentation/screens/onboarding_screen.dart — excerpt
BlocBuilder<LocaleCubit, LocaleState>(
  builder: (context, localeState) {
    // Keying by locale forces a fresh subtree (re-running every tr.* below)
    // whenever the language is switched.
    return _OnboardingView(
      key: ValueKey(localeState.locale.languageCode),
      pages: _pages(context),
    );
  },
)
```

Screens navigated to *after* a switch don't need this — they build fresh with the
new locale already active. This only matters for UI that outlives the toggle.

### 4 · Per-locale font family

Latin and Arabic scripts get different typefaces. `MaterialApp`'s `theme` is
rebuilt through `_applyFont(base, locale)` on every locale change:

```dart
// lib/main.dart — MyApp._applyFont
static ThemeData _applyFont(ThemeData base, Locale locale) {
  if (locale.languageCode == 'ar') {
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'ExpoArabic'),        // bundled font
      primaryTextTheme: base.primaryTextTheme.apply(fontFamily: 'ExpoArabic'),
    );
  }
  return base.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(base.textTheme),         // Latin
    primaryTextTheme: GoogleFonts.montserratTextTheme(base.primaryTextTheme),
  );
}
```

### Bilingual content from the backend

When the API returns both an English and an Arabic label, the app selects with the
`isLTR` helper (§8) rather than the localization system:
`Text(isLTR ? term.labelEn : term.labelAr)` in `financing_term_selector.dart`. ARB
is for *app* strings; server data carries its own translations.

> **Gotchas found in this codebase**
>
> - **Hardcoded `EdgeInsets.only(left:)`** — a few widgets (e.g. the phone field's
>   `flagsButtonPadding`) use physical `left`/`right` instead of
>   `EdgeInsetsDirectional.only(start:)`. Those do *not* mirror. Prefer the
>   directional variants everywhere unless you deliberately want a fixed side.
> - **iOS `Info.plist`** declares only `CFBundleDevelopmentRegion` — there is no
>   `CFBundleLocalizations` array. The in-app forced `locale:` makes this invisible
>   day-to-day, but adding `<key>CFBundleLocalizations</key>` with `en` + `ar` is
>   the clean fix so the OS reports the app as bilingual (App Store metadata,
>   system share sheets, keyboard suggestions).
> - **`intl` import clash** — `package:intl` exports a `TextDirection` that
>   collides with Flutter's. Files that need both import intl as
>   `import 'package:intl/intl.dart' hide TextDirection;`.

---

## 8 · Usage pattern in widgets

### A global `tr` getter, no `context` needed

The stock call is `AppLocalizations.of(context)!.some_key`. This project wraps that
in a zero-argument global getter so strings can be read from widgets, cubits,
routers and plain functions without threading `BuildContext`:

```dart
// lib/shared/utils/tr.dart — complete
import 'package:Ajras/l10n/generated/app_localizations.dart';
import 'package:Ajras/shared/presentation/router/app_router.dart';

// Resolves AppLocalizations off the router's root navigator context.
AppLocalizations get tr =>
    AppLocalizations.of(AppRouter.rootNavigatorKey.currentContext!)!;

// Convenience direction flag derived from the active locale.
bool get isLTR =>
    AppLocalizations.of(AppRouter.rootNavigatorKey.currentContext!)!.localeName == 'en';
```

It works because `AppRouter.rootNavigatorKey` (a `GlobalKey<NavigatorState>`) is
handed to `go_router`'s `navigatorKey`, so `.currentContext` is a context that sits
under `MaterialApp`'s `Localizations` widget.

#### Typical widget

```dart
// lib/features/profile_settings/presentation/widgets/language_selector_widget.dart — excerpt
import 'package:Ajras/shared/utils/tr.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.watch<LocaleCubit>().state.locale.languageCode;

    return SettingsSection(
      title: tr.settings_section_language,          // ← plain getter
      children: [
        for (final locale in SupportedLocale.values)
          SettingsChoiceRow(
            label: switch (locale) {
              SupportedLocale.en => tr.language_name_en,
              SupportedLocale.ar => tr.language_name_ar,
            },
            selected: locale.name == current,
            onTap: () => context.read<LocaleCubit>().changeLocale(localeCode: locale),
          ),
      ],
    );
  }
}
```

#### With placeholders / plurals

```dart
// call sites — method form
Text(tr.app_header_hello(user.firstName))          // "Hello Sara" / "مرحبا Sara"
Text(tr.home_due_in_days(daysLeft))               // "Due in 1 day" / "Due in 5 days"
Text(tr.home_installment_progress(n, total))      // "Installment 2 of 6"
```

> **Trade-offs of the global `tr`**
>
> - **Not reactive.** Reading `tr.x` creates no dependency on `LocaleCubit`, so a
>   purely-`tr` screen won't restring itself on a live language switch — hence the
>   `ValueKey(locale)` pattern in §7. Widgets that already rebuild for other
>   reasons (or sit under the root `Builder`) are fine.
> - **Force-unwraps.** `currentContext!` and `...of(...)!` throw if called before
>   the root navigator is mounted (e.g. in `main()` before `runApp`, or in a zone
>   error handler during startup). Use the `context`-based form in those windows.
> - If you want reactivity without the key trick, skip the global and read
>   `AppLocalizations.of(context)!` directly in `build` — the `Localizations`
>   widget *is* an inherited dependency.

---

## 9 · End-to-end: add one new translated string

The full loop a developer runs in this project, start to finish:

1. **Pick a key.** `snake_case`, namespaced by feature — e.g.
   `transfer_review_confirm_button`. Check it doesn't already exist in
   `app_en.arb`.

2. **Add it to the template — `lib/l10n/app_en.arb`.** Add the key + English value.
   If it takes runtime arguments, add the `{placeholder}` tokens in the value *and*
   a sibling `"@key"` block declaring each placeholder's `type`. For counts, write
   an ICU `plural`.

   ```jsonc
   // app_en.arb
   "transfer_review_confirm_button": "Send SAR {amount}",
   "@transfer_review_confirm_button": {
     "placeholders": { "amount": { "type": "String" } }
   }
   ```

3. **Add the same key to every other locale — `lib/l10n/app_ar.arb`.** Value only,
   no `@` block. Keep the identical `{placeholder}` names. Keep any ICU plural
   categories valid for that language.

   ```jsonc
   // app_ar.arb
   "transfer_review_confirm_button": "إرسال {amount} ريال"
   ```

   Skipping this is allowed (English is used as fallback + a warning) but leaves
   the feature untranslated. Aim for parity.

4. **Regenerate.** Run `flutter gen-l10n` (or `flutter pub get`). New files under
   `lib/l10n/generated/` gain a getter
   `String get transfer_review_confirm_button` or a method
   `String transfer_review_confirm_button(String amount)`.

5. **Use it in the widget.**
   `import 'package:<app>/shared/utils/tr.dart';` then
   `Text(tr.transfer_review_confirm_button(formattedAmount))`. Or, for reactivity,
   `Text(AppLocalizations.of(context)!.transfer_review_confirm_button(...))`.

6. **If layout depends on the string** — e.g. a highlighted substring of a
   headline (this app's onboarding does this with `onboarding_highlight_1`). Keep
   that relationship true in **all** locales — the substring must actually occur in
   each translation.

7. **Verify both directions.** Run the app, switch language in Settings (or the
   onboarding toggle). Confirm the string, its placeholders, and surrounding layout
   read correctly in LTR and RTL. Wrap in
   `Directionality(textDirection: ltr)` if it contains numbers / Latin-only data.

8. **Commit ARB + generated files together.** `lib/l10n/*.arb` and the regenerated
   `lib/l10n/generated/*.dart` go in the same commit, so the tree always builds
   without a codegen step.

---

## 10 · Appendix: minimal file set to replicate this from scratch

In a fresh Flutter app, this is the entire footprint. Roughly 120 lines of
hand-written code.

| File | Hand-written? | Purpose |
|---|---|---|
| `pubspec.yaml` | edit | Add `flutter_localizations`, `intl`; set `flutter: generate: true`. |
| `l10n.yaml` | yes (4 lines) | Generator config (§2). |
| `lib/l10n/app_en.arb` | yes | Template + metadata. Source of truth. |
| `lib/l10n/app_ar.arb` | yes | Arabic values (add one file per extra locale). |
| `lib/l10n/generated/*.dart` | generated | 3 files from `flutter gen-l10n`. Commit them. |
| `lib/…/constants/locales.dart` | yes (1 line) | `enum SupportedLocale { en, ar }`. |
| `lib/l10n/cubit/locale_cubit.dart` + `locale_state.dart` | yes (~30 lines) | Holds the active `Locale`; `changeLocale` persists + emits (§5). |
| storage wrapper | reuse | Any sync `SharedPreferences` accessor + a `localCode` key. |
| DI module getter | yes (~4 lines) | Build `LocaleCubit` from the saved value; register as singleton. |
| `lib/shared/utils/tr.dart` | optional (~6 lines) | Global `tr` / `isLTR` convenience (§8). Needs a root `navigatorKey`. |
| `main.dart` / `MyApp` | edit | `BlocProvider<LocaleCubit>`, `watch` the locale, pass the 3 properties + `locale:` to `MaterialApp` (§6). |

### Assembly order

1. pubspec deps + `generate: true` → `flutter pub get`.
2. Write `l10n.yaml` + both ARB files (start with one key each).
3. `flutter gen-l10n` → confirm `lib/l10n/generated/` appears.
4. Add `SupportedLocale`, `LocaleCubit`/`LocaleState`, the storage key.
5. Register `LocaleCubit` in DI, seeding from storage (default locale of your choice).
6. In `MyApp`: provide the cubit, `watch` its `Locale`, wire the 4 `MaterialApp`
   properties.
7. Optional: add the `tr` getter once a root `navigatorKey` exists.
8. Build a language picker that calls `changeLocale`. Done.

---

*Reference distilled from the **Ajras** Flutter codebase — `gen-l10n` + ARB +
`LocaleCubit` + `shared_preferences`. All file paths and code excerpts are from
that repository and current as of the audit. Adapt names freely; the mechanism is
the point.*
