// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddPetScreen]
class AddPetRoute extends PageRouteInfo<AddPetRouteArgs> {
  AddPetRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        AddPetRoute.name,
        args: AddPetRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AddPetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPetRouteArgs>(
        orElse: () => const AddPetRouteArgs(),
      );
      return AddPetScreen(key: args.key);
    },
  );
}

class AddPetRouteArgs {
  const AddPetRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AddPetRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddPetRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({Key? key, required String role, List<PageRouteInfo>? children})
    : super(
        AuthRoute.name,
        args: AuthRouteArgs(key: key, role: role),
        initialChildren: children,
      );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>();
      return AuthScreen(key: args.key, role: args.role);
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key, required this.role});

  final Key? key;

  final String role;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [ChoosePathScreen]
class ChoosePathRoute extends PageRouteInfo<void> {
  const ChoosePathRoute({List<PageRouteInfo>? children})
    : super(ChoosePathRoute.name, initialChildren: children);

  static const String name = 'ChoosePathRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChoosePathScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [NavWrapperScreen]
class NavWrapperRoute extends PageRouteInfo<void> {
  const NavWrapperRoute({List<PageRouteInfo>? children})
    : super(NavWrapperRoute.name, initialChildren: children);

  static const String name = 'NavWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NavWrapperScreen();
    },
  );
}

/// generated route for
/// [OnbordingScreen]
class OnbordingRoute extends PageRouteInfo<OnbordingRouteArgs> {
  OnbordingRoute({
    Key? key,
    required String role,
    List<PageRouteInfo>? children,
  }) : super(
         OnbordingRoute.name,
         args: OnbordingRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'OnbordingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnbordingRouteArgs>();
      return OnbordingScreen(key: args.key, role: args.role);
    },
  );
}

class OnbordingRouteArgs {
  const OnbordingRouteArgs({this.key, required this.role});

  final Key? key;

  final String role;

  @override
  String toString() {
    return 'OnbordingRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OnbordingRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [OtpScreen]
class OtpRoute extends PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    Key? key,
    bool? isResetPassword = false,
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(
           key: key,
           isResetPassword: isResetPassword,
           email: email,
         ),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return OtpScreen(
        key: args.key,
        isResetPassword: args.isResetPassword,
        email: args.email,
      );
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    this.isResetPassword = false,
    required this.email,
  });

  final Key? key;

  final bool? isResetPassword;

  final String email;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, isResetPassword: $isResetPassword, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key &&
        isResetPassword == other.isResetPassword &&
        email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ isResetPassword.hashCode ^ email.hashCode;
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [SendsToEmailScreen]
class SendsToEmailRoute extends PageRouteInfo<void> {
  const SendsToEmailRoute({List<PageRouteInfo>? children})
    : super(SendsToEmailRoute.name, initialChildren: children);

  static const String name = 'SendsToEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SendsToEmailScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomeScreen();
    },
  );
}
