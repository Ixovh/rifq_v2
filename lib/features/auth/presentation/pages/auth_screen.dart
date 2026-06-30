import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:rifq_v2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq_v2/features/auth/presentation/pages/auth_tab_bar.dart';
import 'package:rifq_v2/features/auth/presentation/pages/login_tab.dart';
import 'package:rifq_v2/features/auth/presentation/pages/sign_up_tab.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../../core/theme/app_theme.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key,required  this.role});
    final String role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I.get<AuthUseCase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AuthCubit>();
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthSuccessState _:
                  context.replaceRoute(const NavWrapperRoute());
                  break;
                case AuthSignUPSuccessState _:
                  context.pushRoute(OtpRoute(isResetPassword: false,email: cubit.sinUpEmailController.text,));
                  // context.push(Routes.otpScreen, extra: {"cubit":cubit, "isPassword": false});
                  break;
                case AuthErrorState _:
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.msg)));
                  break;
                case AuthLoadingState _:
                  Center(child: CircularProgressIndicator());
                  break;
              }
            },
            child: Scaffold(
              backgroundColor: context.neutral100,
              resizeToAvoidBottomInset: false,
              bottomSheet: CustomBottomSheet(
                content: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const AuthTabBar(),
                      Expanded(
                        child: TabBarView(children: [LoginTab(), SignUpTab(role: role)]),
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/icon/logo.svg'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
