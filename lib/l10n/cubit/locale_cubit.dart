import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/storage_service/locale_store.dart';

part 'locale_state.dart';

/// Holds the active [Locale] for the whole app.
///
/// [changeLocale] persists the choice to local storage (`GetStorage`, the same
/// convention `AuthHelper` / `UserDataStore` use) and then emits, so
/// `MaterialApp` rebuilds with the new language and text direction live — no
/// restart. The saved value is read back by `MainDependencies.localeCubit` on
/// the next launch to seed the initial state.
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required Locale locale}) : super(LocaleState(locale));

  Future<void> changeLocale({required LanguagesEnum language}) async {
    if (language.name == state.locale.languageCode) return;
    // Awaited on purpose: the write has to land before the app can be killed,
    // otherwise the picked language silently reverts on next launch.
    await LocaleStore.write(language.name);
    emit(LocaleState(Locale(language.name)));
  }
}
