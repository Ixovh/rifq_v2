import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I.get<AuthUseCase>()),
      child: Builder(
        builder: (context) {
          final _ = context.read<AuthCubit>();

          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthAnonymousSuccessState _:
                  context.replaceRoute(const NavWrapperRoute()); //!!!!!!!
                  break;

                case AuthSuccessState _: //!!!!
              context.replaceRoute(const NavWrapperRoute());
                  break;

                case AuthErrorState _:
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.msg)));
                  break;

                case AuthLoadingState _:
                  break;
              }
            },
            child: Scaffold(
              backgroundColor: context.background,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Center(child: SvgPicture.asset('assets/icon/logo.svg')),

                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.r),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Welcome to Rifq',
                              style: context.h3.copyWith(
                                color: context.primary300,
                              ),
                            ),
                            Text(
                              'Your trusted space for pet care and services.',
                              style: context.bodyLarge.copyWith(
                                color: context.neutral700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(18.r),
                        child: Column(
                          children: [
                            Text(
                              'Sign in to continue caring with ease.',
                              style: context.bodyMedium.copyWith(
                                color: context.neutral900,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ContainerButton(
                              label: 'Sign in',
                              containerColor: context.primary300,
                              textColor: context.neutral100,
                              fontSize: 20,
                              onTap: () {
                                context.pushRoute( AuthRoute(role: 'pet_owner'));
                                // context.go(Routes.auth);
                              },
                            ),
                            SizedBox(height: 18.h),
                            ContainerButton(
                              onTap: ()  {
                                context.replaceRoute(const NavWrapperRoute());
                                  // context.go(Routes.navbar);
                              },
                              label: 'Continue as Guest',
                              containerColor: context.neutral100,
                              textColor: context.primary300,
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}