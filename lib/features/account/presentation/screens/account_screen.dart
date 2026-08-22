import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/presentation/cubit/account_cubit.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_avatar.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_info_row.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_menu_tile.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_pet_card.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/theme/app_color.dart';
import 'package:rifq_v2/shared/presentation/widgets/guest_card_widget.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AccountCubit>()..loadAccount(),
      child: const _AccountView(),
    );
  }
}

class _AccountView extends StatelessWidget {
  const _AccountView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.msg)),
          );
        }
        if (state is AccountLogoutSuccessState) {
          context.router.replaceAll([const ChoosePathRoute()]);
        }
      },
      builder: (context, state) {
          if (state is AccountLoading || state is AccountInitial) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: LottieLoding(),
            );
          }

        if (state is AccountGuestState) {
          return const _GuestAccountBody();
        }

        if (state is AccountLoadedState || state is AccountUpdatingState) {
          final data = state is AccountLoadedState
              ? state.data
              : (state as AccountUpdatingState).data;
          return _SignedAccountBody(data: data);
        }

        if (state is AccountUpdateSuccessState) {
          return _SignedAccountBody(data: state.data);
        }

        return Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => context.read<AccountCubit>().loadAccount(),
              child: const Text('Retry'),
            ),
          ),
        );
      },
    );
  }
}

class _GuestAccountBody extends StatelessWidget {
  const _GuestAccountBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              IconButton(
                onPressed: () => context.router.maybePop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: context.neutral1000,
                ),
              ),
              SizedBox(height: 24.h),
              const GuestCard(),
              SizedBox(height: 28.h),
              AccountMenuTile(
                icon: Icons.privacy_tip_outlined,
                label: 'Security & Privacy',
                onTap: () {},
              ),
              AccountMenuTile(
                icon: Icons.language,
                label: 'Language',
                onTap: () {},
              ),
              AccountMenuTile(
                icon: Icons.logout,
                label: 'Log out',
                labelColor: const Color(0xFFFF383C),
                onTap: () => context.read<AccountCubit>().logOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignedAccountBody extends StatelessWidget {
  const _SignedAccountBody({required this.data});

  final AccountDataEntity data;

  @override
  Widget build(BuildContext context) {
    final profile = data.profile;

    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<AccountCubit>().loadAccount(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.router.maybePop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20.sp,
                        color: context.neutral1000,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        final updated = await context.pushRoute(
                          const EditAccountRoute(),
                        );
                        if (updated == true && context.mounted) {
                          context.read<AccountCubit>().loadAccount();
                        }
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 24.sp,
                        color: context.primary300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                AccountAvatar(
                  initials: profile.initials,
                  avatarUrl: profile.avatarUrl,
                ),
                SizedBox(height: 16.h),
                Text(
                  profile.displayName,
                  style: context.h4.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: context.neutral1000,
                  ),
                ),
                SizedBox(height: 20.h),
                AccountInfoRow(
                  label: 'Email',
                  value: data.email.isEmpty ? '-' : data.email,
                ),
                AccountInfoRow(
                  label: 'Phone number',
                  value: (profile.phoneNumber?.isNotEmpty ?? false)
                      ? profile.phoneNumber!
                      : '-',
                ),
                if (data.pets.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 185.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.pets.length,
                      itemBuilder: (context, index) {
                        final pet = data.pets[index];
                        return AccountPetCard(pet: pet);
                      },
                    ),
                  ),
                ],
                SizedBox(height: 28.h),
                AccountMenuTile(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Security & Privacy',
                  onTap: () {},
                ),
                AccountMenuTile(
                  icon: Icons.language,
                  label: 'Language',
                  onTap: () {},
                ),
                AccountMenuTile(
                  icon: Icons.logout,
                  label: 'Log out',
                  labelColor: const Color(0xFFFF383C),
                  onTap: () => _confirmLogout(context),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.neutral700),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Log out',
              style: TextStyle(color: Color(0xFFFF383C)),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<AccountCubit>().logOut();
    }
  }
}
