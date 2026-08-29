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
/// [BookingDetailsScreen]
class BookingDetailsRoute extends PageRouteInfo<BookingDetailsRouteArgs> {
  BookingDetailsRoute({
    Key? key,
    required HotelDetailEntity hotel,
    List<PageRouteInfo>? children,
  }) : super(
         BookingDetailsRoute.name,
         args: BookingDetailsRouteArgs(key: key, hotel: hotel),
         initialChildren: children,
       );

  static const String name = 'BookingDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingDetailsRouteArgs>();
      return BookingDetailsScreen(key: args.key, hotel: args.hotel);
    },
  );
}

class BookingDetailsRouteArgs {
  const BookingDetailsRouteArgs({this.key, required this.hotel});

  final Key? key;

  final HotelDetailEntity hotel;

  @override
  String toString() {
    return 'BookingDetailsRouteArgs{key: $key, hotel: $hotel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingDetailsRouteArgs) return false;
    return key == other.key && hotel == other.hotel;
  }

  @override
  int get hashCode => key.hashCode ^ hotel.hashCode;
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
/// [ConfirmAndPayScreen]
class ConfirmAndPayRoute extends PageRouteInfo<ConfirmAndPayRouteArgs> {
  ConfirmAndPayRoute({
    Key? key,
    required BookingDraftEntity draft,
    List<PageRouteInfo>? children,
  }) : super(
         ConfirmAndPayRoute.name,
         args: ConfirmAndPayRouteArgs(key: key, draft: draft),
         initialChildren: children,
       );

  static const String name = 'ConfirmAndPayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmAndPayRouteArgs>();
      return ConfirmAndPayScreen(key: args.key, draft: args.draft);
    },
  );
}

class ConfirmAndPayRouteArgs {
  const ConfirmAndPayRouteArgs({this.key, required this.draft});

  final Key? key;

  final BookingDraftEntity draft;

  @override
  String toString() {
    return 'ConfirmAndPayRouteArgs{key: $key, draft: $draft}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ConfirmAndPayRouteArgs) return false;
    return key == other.key && draft == other.draft;
  }

  @override
  int get hashCode => key.hashCode ^ draft.hashCode;
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
/// [HotelDetailScreen]
class HotelDetailRoute extends PageRouteInfo<HotelDetailRouteArgs> {
  HotelDetailRoute({
    Key? key,
    required String hotelId,
    List<PageRouteInfo>? children,
  }) : super(
         HotelDetailRoute.name,
         args: HotelDetailRouteArgs(key: key, hotelId: hotelId),
         initialChildren: children,
       );

  static const String name = 'HotelDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HotelDetailRouteArgs>();
      return HotelDetailScreen(key: args.key, hotelId: args.hotelId);
    },
  );
}

class HotelDetailRouteArgs {
  const HotelDetailRouteArgs({this.key, required this.hotelId});

  final Key? key;

  final String hotelId;

  @override
  String toString() {
    return 'HotelDetailRouteArgs{key: $key, hotelId: $hotelId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HotelDetailRouteArgs) return false;
    return key == other.key && hotelId == other.hotelId;
  }

  @override
  int get hashCode => key.hashCode ^ hotelId.hashCode;
}

/// generated route for
/// [HotelListScreen]
class HotelListRoute extends PageRouteInfo<void> {
  const HotelListRoute({List<PageRouteInfo>? children})
    : super(HotelListRoute.name, initialChildren: children);

  static const String name = 'HotelListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HotelListScreen();
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
/// [PaymentSuccessScreen]
class PaymentSuccessRoute extends PageRouteInfo<PaymentSuccessRouteArgs> {
  PaymentSuccessRoute({
    Key? key,
    required BookingConfirmationEntity confirmation,
    List<PageRouteInfo>? children,
  }) : super(
         PaymentSuccessRoute.name,
         args: PaymentSuccessRouteArgs(key: key, confirmation: confirmation),
         initialChildren: children,
       );

  static const String name = 'PaymentSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentSuccessRouteArgs>();
      return PaymentSuccessScreen(
        key: args.key,
        confirmation: args.confirmation,
      );
    },
  );
}

class PaymentSuccessRouteArgs {
  const PaymentSuccessRouteArgs({this.key, required this.confirmation});

  final Key? key;

  final BookingConfirmationEntity confirmation;

  @override
  String toString() {
    return 'PaymentSuccessRouteArgs{key: $key, confirmation: $confirmation}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentSuccessRouteArgs) return false;
    return key == other.key && confirmation == other.confirmation;
  }

  @override
  int get hashCode => key.hashCode ^ confirmation.hashCode;
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
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    required BoardingTab initialTab,
    List<PageRouteInfo>? children,
  }) : super(
         SearchRoute.name,
         args: SearchRouteArgs(key: key, initialTab: initialTab),
         initialChildren: children,
       );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchRouteArgs>();
      return SearchScreen(key: args.key, initialTab: args.initialTab);
    },
  );
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key, required this.initialTab});

  final Key? key;

  final BoardingTab initialTab;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, initialTab: $initialTab}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SearchRouteArgs) return false;
    return key == other.key && initialTab == other.initialTab;
  }

  @override
  int get hashCode => key.hashCode ^ initialTab.hashCode;
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
/// [SitterDetailScreen]
class SitterDetailRoute extends PageRouteInfo<SitterDetailRouteArgs> {
  SitterDetailRoute({
    Key? key,
    required String sitterId,
    List<PageRouteInfo>? children,
  }) : super(
         SitterDetailRoute.name,
         args: SitterDetailRouteArgs(key: key, sitterId: sitterId),
         initialChildren: children,
       );

  static const String name = 'SitterDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SitterDetailRouteArgs>();
      return SitterDetailScreen(key: args.key, sitterId: args.sitterId);
    },
  );
}

class SitterDetailRouteArgs {
  const SitterDetailRouteArgs({this.key, required this.sitterId});

  final Key? key;

  final String sitterId;

  @override
  String toString() {
    return 'SitterDetailRouteArgs{key: $key, sitterId: $sitterId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SitterDetailRouteArgs) return false;
    return key == other.key && sitterId == other.sitterId;
  }

  @override
  int get hashCode => key.hashCode ^ sitterId.hashCode;
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
