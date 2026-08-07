import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rifq_v2/features/add_pet/presentation/pages/add_pet_screen.dart';
import 'package:rifq_v2/features/auth/presentation/pages/auth_screen.dart';
import 'package:rifq_v2/features/auth/presentation/pages/otp_screen.dart';
import 'package:rifq_v2/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:rifq_v2/features/auth/presentation/pages/sends_to_email_screen.dart';
import 'package:rifq_v2/features/auth/presentation/pages/welcomscreen.dart';
import 'package:rifq_v2/features/nav/prsentaion/pages/nav_screen.dart';
import 'package:rifq_v2/features/onboarding/presentation/pages/onboarding_feature_screen.dart';
import 'package:rifq_v2/features/splash/prsentation/pages/choose_path.dart';
import 'package:rifq_v2/features/splash/prsentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'routers.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/home/presentation/pages/home_feature_screen.dart';
import 'package:rifq_v2/features/home/presentation/cubit/home_cubit.dart';


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

        // AutoRoute(page: AdoptionRoute.page, path: '/adoption'),


];

}

