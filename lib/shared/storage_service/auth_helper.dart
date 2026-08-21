import 'package:get_storage/get_storage.dart';

class AuthHelper {
  static final _box = GetStorage();
  static const _key = 'login';

  //!! -------IF GUEST-------

  static bool isGuestUser() {
    final data = _box.read(_key);
    if (data == null) return true;
    return data['isGuest'] == true;
  }

  //!! -------GET USER ID-------
  static String? getUserId() {
    final data = _box.read(_key);
    if (data == null) return null;
    return data['userId'];
  }

  //!! -------SAVE LOGIN-------
  static Future<void> saveLogin({
    required String token,
    required String refreshToken,
    required String userId,
  }) async {
    await _box.write(_key, {
      'token': token,
      'refreshToken': refreshToken,
      'userId': userId,
      'isGuest': false,
    });
  }

  //!! -------SAVE GUEST LOGIN-------
  static Future<void> saveGuestLogin() async {
    await _box.write(_key, {
      'isGuest': true,
    });
  }

  //!! -------LOGOUT-------
  static Future<void> logout() async {
    await _box.remove(_key);
  }
}
