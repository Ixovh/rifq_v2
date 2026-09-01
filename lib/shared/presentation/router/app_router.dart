import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rifq_v2/features/account/presentation/screens/account_pets_screen.dart';
import 'package:rifq_v2/features/account/presentation/screens/account_screen.dart';
import 'package:rifq_v2/features/account/presentation/screens/edit_account_screen.dart';
import 'package:rifq_v2/features/account/presentation/screens/pet_profile_screen.dart';
import 'package:rifq_v2/features/add_pet/presentation/screens/add_pet_screen.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_card_model.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_form_widget.dart';
import 'package:rifq_v2/features/edit_pet/presentation/screens/edit_pet_screen.dart';
import 'package:rifq_v2/features/auth/presentation/screens/auth_screen.dart';
import 'package:rifq_v2/features/auth/presentation/screens/check_email_screen.dart';
import 'package:rifq_v2/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:rifq_v2/features/auth/presentation/screens/sends_to_email_screen.dart';
import 'package:rifq_v2/features/auth/presentation/screens/welcome_screen.dart';
import 'package:rifq_v2/features/home/presentation/screens/home_feature_screen.dart';
import 'package:rifq_v2/features/nav/presentation/screens/nav_screen.dart';
import 'package:rifq_v2/features/onboarding/presentation/screens/onboarding_feature_screen.dart';
import 'package:rifq_v2/features/splash/presentation/screens/choose_path.dart';
import 'package:rifq_v2/features/splash/presentation/screens/splash_screen.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/screens/otp_screen.dart';
import 'package:rifq_v2/features/adoption/presentation/screens/adoption_feature_screen.dart';
import 'package:rifq_v2/features/adoption/presentation/screens/pet_details_screen.dart';
import 'package:rifq_v2/features/adoption/presentation/screens/adoption_requests_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnbordingRoute.page, path: '/onboarding'),
    AutoRoute(page: ChoosePathRoute.page, path: '/choose-path'),
    AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
    AutoRoute(page: AuthRoute.page, path: '/auth'),
    AutoRoute(page: OtpRoute.page, path: '/otp'),
    AutoRoute(page: SendsToEmailRoute.page, path: '/send-email'),
    AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
    AutoRoute(page: NavWrapperRoute.page, path: '/navbar'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: AddPetRoute.page, path: '/addpet'),
    AutoRoute(page: AccountRoute.page, path: '/account'),
    AutoRoute(page: AccountPetsRoute.page, path: '/account-pets'),
    AutoRoute(page: PetProfileRoute.page, path: '/pet-profile/:petId'),
    AutoRoute(page: EditPetRoute.page, path: '/edit-pet/:petId'),
    AutoRoute(page: EditAccountRoute.page, path: '/edit-account'),
 AutoRoute(
  page: PetDetailsRoute.page,
  path: '/pet-details',
),
AutoRoute(
  page: AdoptionFormRoute.page,
  path: '/adoption-form',
),
AutoRoute(
  page: AdoptionRequestsRoute.page,
),
  ];
}
