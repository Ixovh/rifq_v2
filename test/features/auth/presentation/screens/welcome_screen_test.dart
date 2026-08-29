import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/screens/welcome_screen.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';

/// None of WelcomeScreen's "Continue as Guest" path calls into the auth
/// repo — this only exists to satisfy AuthCubit's constructor so the
/// widget tree builds.
class _UnusedAuthRepoDomain implements AuthRepoDomain {
  @override
  Future<Result<Null, Object>> anonymousUser() => throw UnimplementedError();
  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) => throw UnimplementedError();
  @override
  Future<Result<Null, Object>> logOut() => throw UnimplementedError();
  @override
  Future<Result<Null, Object>> resetPassword({required String newPassword}) =>
      throw UnimplementedError();
  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) => throw UnimplementedError();
  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  }) => throw UnimplementedError();
  @override
  Future<Result<AuthEntity, Object>> verifyAccount({
    required String email,
    required String otp,
  }) => throw UnimplementedError();
  @override
  Future<Result<AuthEntity, Object>> verifyOtp({
    required String email,
    required String otp,
    required OtpPurpose purpose,
  }) => throw UnimplementedError();
  @override
  Future<Result<Null, Object>> resendOtp({
    required String email,
    required OtpPurpose purpose,
  }) => throw UnimplementedError();
}

Widget _wrap(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(402, 874),
    builder: (_, _) => MaterialApp(home: child),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // get_storage always calls path_provider's platform channel to find
    // the app documents directory, even when the isn't otherwise used on
    // this platform target — mock it so GetStorage.init() doesn't need a
    // real device/plugin registration.
    final tempDir = Directory.systemTemp.createTempSync('get_storage_test');
    addTearDown(() => tempDir.deleteSync(recursive: true));
    TestWidgetsFlutterBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async {
            if (call.method == 'getApplicationDocumentsDirectory') {
              return tempDir.path;
            }
            return null;
          },
        );

    await GetStorage.init();
  });

  setUp(() {
    GetIt.instance.registerFactory<AuthUseCase>(
      () => AuthUseCase(authRepoData: _UnusedAuthRepoDomain()),
    );
  });

  tearDown(() async {
    await GetIt.instance.reset();
    await GetStorage().erase();
  });

  testWidgets(
    'tapping "Continue as Guest" saves guest state, overwriting any stale '
    'real-login data left over from a previous session',
    (tester) async {
      // Simulate a previous real session that never got cleanly logged out
      // (e.g. SplashScreen's unconfirmed-email path calls
      // Supabase.auth.signOut() but never AuthHelper.logout(), so this data
      // can genuinely linger).
      await GetStorage().write('login', {
        'token': 'stale-token',
        'refreshToken': 'stale-refresh',
        'userId': 'stale-user-id',
        'isGuest': false,
      });
      expect(
        AuthHelper.isGuestUser(),
        isFalse,
        reason: 'sanity check: stale non-guest data is in place',
      );

      await tester.pumpWidget(_wrap(const WelcomeScreen()));
      await tester.pump();

      // ContainerButton.onTap is `void Function()`, so the async lambda in
      // WelcomeScreen's "Continue as Guest" onTap returns an orphaned
      // Future that nothing awaits. It awaits AuthHelper.saveGuestLogin()
      // *before* navigating, so context.replaceRoute() — which throws here
      // because WelcomeScreen isn't wrapped in a real AutoRouter, only a
      // plain MaterialApp; in the real app it always renders under the
      // real AppRouter — runs a microtask later, as an unhandled rejection
      // on that orphaned Future. That's not something a try/catch around
      // tester.pump() can catch (it isn't part of this test's await
      // chain), so catch it at the zone level instead.
      await runZonedGuarded(() async {
        await tester.tap(find.text('Continue as Guest'));
        await tester.pump();
        await tester.pump();
      }, (error, stack) {});

      expect(
        AuthHelper.isGuestUser(),
        isTrue,
        reason:
            '"Continue as Guest" must explicitly persist guest state, not '
            'rely on storage happening to already be empty',
      );
    },
  );
}
