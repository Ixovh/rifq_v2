import 'package:get_storage/get_storage.dart';

/// Persisted UI language code (`'ar'` / `'en'`).
///
/// Thin `GetStorage` wrapper, same convention as [AuthHelper] /
/// [RecentSearchesStore] — a language preference is not a secret and it must
/// be readable synchronously at startup so the app opens in the right
/// language and text direction.
class LocaleStore {
  LocaleStore._();

  static final _box = GetStorage();
  static const _key = 'locale_code';

  static String? read() {
    final value = _box.read(_key);
    return value is String && value.isNotEmpty ? value : null;
  }

  static Future<void> write(String code) => _box.write(_key, code);
}
