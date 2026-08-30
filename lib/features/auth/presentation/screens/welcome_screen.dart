import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
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
          final l10n = AppLocalizations.of(context)!;

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
                  context.showErrorToast(state.msg);
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
                              l10n.welcome_title,
                              style: context.h3.copyWith(
                                color: context.primary300,
                              ),
                            ),
                            Text(
                              l10n.welcome_subtitle,
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
                              l10n.welcome_signInPrompt,
                              style: context.bodyMedium.copyWith(
                                color: context.neutral900,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ContainerButton(
                              label: l10n.welcome_signIn,
                              containerColor: context.primary300,
                              textColor: context.neutral100,
                              fontSize: 20,
                              onTap: () {
                                context.pushRoute(AuthRoute(role: 'pet_owner'));
                                // context.go(Routes.auth);
                              },
                            ),
                            SizedBox(height: 18.h),
                            ContainerButton(
                              onTap: () async {
                                // Explicitly persist guest state — without
                                // this, "Continue as Guest" only happened
                                // to look like it worked when local storage
                                // was already empty. Any stale non-guest
                                // login data left over from a previous
                                // session (e.g. Splash's unconfirmed-email
                                // sign-out path, which clears the Supabase
                                // session but not this local flag) would
                                // otherwise still read as a real signed-in
                                // user.
                                await AuthHelper.saveGuestLogin();
                                if (!context.mounted) return;
                                context.replaceRoute(const NavWrapperRoute());
                                // context.go(Routes.navbar);
                              },
                              label: l10n.welcome_continueGuest,
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
