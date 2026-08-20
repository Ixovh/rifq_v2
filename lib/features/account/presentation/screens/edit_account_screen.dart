import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/account/presentation/cubit/account_cubit.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_avatar.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_outlined_field.dart';
import 'package:rifq_v2/features/auth/presentation/widgets/container_button.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AccountCubit>()..loadAccount(),
      child: const _EditAccountView(),
    );
  }
}

class _EditAccountView extends StatelessWidget {
  const _EditAccountView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountCubit>();

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountUpdateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated')),
          );
          context.router.maybePop(true);
        }
        if (state is AccountErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.msg)),
          );
        }
      },
      builder: (context, state) {
        if (state is AccountLoading || state is AccountInitial) {
          return const Scaffold(body: LottieLoding());
        }

        if (state is AccountGuestState) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.router.maybePop(),
                child: const Text('Sign in to edit profile'),
              ),
            ),
          );
        }

        final isUpdating = state is AccountUpdatingState;
        final profile = state is AccountLoadedState
            ? state.data.profile
            : state is AccountUpdatingState
                ? state.data.profile
                : state is AccountUpdateSuccessState
                    ? state.data.profile
                    : null;

        if (profile == null) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => cubit.loadAccount(),
                child: const Text('Retry'),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: context.background,
          body: SafeArea(
            child: Form(
              key: cubit.editFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.router.maybePop(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.sp,
                            color: context.neutral1000,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Edit Profile',
                            textAlign: TextAlign.center,
                            style: context.h4.copyWith(
                              color: context.primary300,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          AccountAvatar(
                            initials: profile.initials,
                            avatarUrl: profile.avatarUrl,
                            size: 157,
                            showEditBadge: true,
                            onEditTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Avatar upload coming soon',
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 48.h),
                          AccountOutlinedField(
                            label: 'First Name',
                            controller: cubit.firstNameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: 'Last Name',
                            controller: cubit.lastNameController,
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: 'Email',
                            controller: cubit.emailController,
                            readOnly: true,
                          ),
                          SizedBox(height: 42.h),
                          AccountOutlinedField(
                            label: 'Phone number',
                            controller: cubit.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
                    child: ContainerButton(
                      label: 'Save',
                      containerColor: context.primary300,
                      textColor: context.neutral100,
                      fontSize: 20,
                      isLoading: isUpdating,
                      onTap: () {
                        if (cubit.editFormKey.currentState?.validate() ??
                            false) {
                          cubit.saveProfile();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
