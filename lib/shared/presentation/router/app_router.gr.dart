// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccountPetsScreen]
class AccountPetsRoute extends PageRouteInfo<void> {
  const AccountPetsRoute({List<PageRouteInfo>? children})
    : super(AccountPetsRoute.name, initialChildren: children);

  static const String name = 'AccountPetsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountPetsScreen();
    },
  );
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountScreen();
    },
  );
}

/// generated route for
/// [AddPetScreen]
class AddPetRoute extends PageRouteInfo<AddPetRouteArgs> {
  AddPetRoute({
    Key? key,
    bool showAdoptionFields = false,
    List<PageRouteInfo>? children,
  }) : super(
         AddPetRoute.name,
         args: AddPetRouteArgs(
           key: key,
           showAdoptionFields: showAdoptionFields,
         ),
         initialChildren: children,
       );

  static const String name = 'AddPetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPetRouteArgs>(
        orElse: () => const AddPetRouteArgs(),
      );
      return AddPetScreen(
        key: args.key,
        showAdoptionFields: args.showAdoptionFields,
      );
    },
  );
}

class AddPetRouteArgs {
  const AddPetRouteArgs({this.key, this.showAdoptionFields = false});

  final Key? key;

  final bool showAdoptionFields;

  @override
  String toString() {
    return 'AddPetRouteArgs{key: $key, showAdoptionFields: $showAdoptionFields}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddPetRouteArgs) return false;
    return key == other.key && showAdoptionFields == other.showAdoptionFields;
  }

  @override
  int get hashCode => key.hashCode ^ showAdoptionFields.hashCode;
}

/// generated route for
/// [AdoptionFeatureScreen]
class AdoptionFeatureRoute extends PageRouteInfo<void> {
  const AdoptionFeatureRoute({List<PageRouteInfo>? children})
    : super(AdoptionFeatureRoute.name, initialChildren: children);

  static const String name = 'AdoptionFeatureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdoptionFeatureScreen();
    },
  );
}

/// generated route for
/// [AdoptionFormScreen]
class AdoptionFormRoute extends PageRouteInfo<AdoptionFormRouteArgs> {
  AdoptionFormRoute({
    Key? key,
    required String adoptionPostId,
    List<PageRouteInfo>? children,
  }) : super(
         AdoptionFormRoute.name,
         args: AdoptionFormRouteArgs(key: key, adoptionPostId: adoptionPostId),
         initialChildren: children,
       );

  static const String name = 'AdoptionFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AdoptionFormRouteArgs>();
      return AdoptionFormScreen(
        key: args.key,
        adoptionPostId: args.adoptionPostId,
      );
    },
  );
}

class AdoptionFormRouteArgs {
  const AdoptionFormRouteArgs({this.key, required this.adoptionPostId});

  final Key? key;

  final String adoptionPostId;

  @override
  String toString() {
    return 'AdoptionFormRouteArgs{key: $key, adoptionPostId: $adoptionPostId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AdoptionFormRouteArgs) return false;
    return key == other.key && adoptionPostId == other.adoptionPostId;
  }

  @override
  int get hashCode => key.hashCode ^ adoptionPostId.hashCode;
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
/// [CheckEmailScreen]
class CheckEmailRoute extends PageRouteInfo<CheckEmailRouteArgs> {
  CheckEmailRoute({
    Key? key,
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
         CheckEmailRoute.name,
         args: CheckEmailRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'CheckEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckEmailRouteArgs>();
      return CheckEmailScreen(key: args.key, email: args.email);
    },
  );
}

class CheckEmailRouteArgs {
  const CheckEmailRouteArgs({this.key, required this.email});

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'CheckEmailRouteArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CheckEmailRouteArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
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
/// [EditAccountScreen]
class EditAccountRoute extends PageRouteInfo<void> {
  const EditAccountRoute({List<PageRouteInfo>? children})
    : super(EditAccountRoute.name, initialChildren: children);

  static const String name = 'EditAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditAccountScreen();
    },
  );
}

/// generated route for
/// [EditPetScreen]
class EditPetRoute extends PageRouteInfo<EditPetRouteArgs> {
  EditPetRoute({Key? key, required String petId, List<PageRouteInfo>? children})
    : super(
        EditPetRoute.name,
        args: EditPetRouteArgs(key: key, petId: petId),
        initialChildren: children,
      );

  static const String name = 'EditPetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditPetRouteArgs>();
      return EditPetScreen(key: args.key, petId: args.petId);
    },
  );
}

class EditPetRouteArgs {
  const EditPetRouteArgs({this.key, required this.petId});

  final Key? key;

  final String petId;

  @override
  String toString() {
    return 'EditPetRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditPetRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
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
    required String email,
    OtpPurpose purpose = OtpPurpose.signUp,
    List<PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(key: key, email: email, purpose: purpose),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return OtpScreen(key: args.key, email: args.email, purpose: args.purpose);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.email,
    this.purpose = OtpPurpose.signUp,
  });

  final Key? key;

  final String email;

  final OtpPurpose purpose;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, email: $email, purpose: $purpose}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key && email == other.email && purpose == other.purpose;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode ^ purpose.hashCode;
}

/// generated route for
/// [PetDetailsScreen]
class PetDetailsRoute extends PageRouteInfo<PetDetailsRouteArgs> {
  PetDetailsRoute({
    Key? key,
    required AdoptionPetCardEntity pet,
    List<PageRouteInfo>? children,
  }) : super(
         PetDetailsRoute.name,
         args: PetDetailsRouteArgs(key: key, pet: pet),
         initialChildren: children,
       );

  static const String name = 'PetDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PetDetailsRouteArgs>();
      return PetDetailsScreen(key: args.key, pet: args.pet);
    },
  );
}

class PetDetailsRouteArgs {
  const PetDetailsRouteArgs({this.key, required this.pet});

  final Key? key;

  final AdoptionPetCardEntity pet;

  @override
  String toString() {
    return 'PetDetailsRouteArgs{key: $key, pet: $pet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PetDetailsRouteArgs) return false;
    return key == other.key && pet == other.pet;
  }

  @override
  int get hashCode => key.hashCode ^ pet.hashCode;
}

/// generated route for
/// [PetProfileScreen]
class PetProfileRoute extends PageRouteInfo<PetProfileRouteArgs> {
  PetProfileRoute({
    Key? key,
    required String petId,
    List<PageRouteInfo>? children,
  }) : super(
         PetProfileRoute.name,
         args: PetProfileRouteArgs(key: key, petId: petId),
         initialChildren: children,
       );

  static const String name = 'PetProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PetProfileRouteArgs>();
      return PetProfileScreen(key: args.key, petId: args.petId);
    },
  );
}

class PetProfileRouteArgs {
  const PetProfileRouteArgs({this.key, required this.petId});

  final Key? key;

  final String petId;

  @override
  String toString() {
    return 'PetProfileRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PetProfileRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
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
