import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rifq_v2/l10n/cubit/locale_cubit.dart';
import 'package:rifq_v2/shared/storage_service/locale_store.dart';

@module
abstract class ThirdPartyModule {
  @singleton
  GetStorage get storage => GetStorage();

  @singleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  // LocaleCubit needs a constructed Locale, so it can't be a bare
  // @injectable — it is built here from the value saved by changeLocale(),
  // defaulting to Arabic on first launch. GetStorage.init() runs before
  // getIt.init() (see main()), so LocaleStore.read() is safe synchronously.
  @singleton
  LocaleCubit get localeCubit {
    final savedLocale = LocaleStore.read() ?? 'ar';
    return LocaleCubit(locale: Locale(savedLocale));
  }
}

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:injectable/injectable.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// @module
// abstract class ThirdPartyConfig {
//   //----------------------------------------------------------------------------
//   @lazySingleton
//   GetStorage get storage => GetStorage();
//   //----------------------------------------------------------------------------
//   @lazySingleton
//   SupabaseClient get supabaseClient => Supabase.instance.client;
//   //----------------------------------------------------------------------------
//   AndroidOptions _getAndroidOptions() =>
//       const AndroidOptions(encryptedSharedPreferences: true);
//   @lazySingleton
//   FlutterSecureStorage get flutterSecureStorage =>
//       FlutterSecureStorage(aOptions: _getAndroidOptions());
//   //----------------------------------------------------------------------------
// }
