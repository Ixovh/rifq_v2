import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/presentation/cubit/account_cubit.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_avatar.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_info_row.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_menu_tile.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_pet_card.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_section_header.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_confirm_sheet.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
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
          context.showErrorToast(state.msg);
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
              child: Text(AppLocalizations.of(context)!.common_retry),
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
                label: AppLocalizations.of(context)!.account_securityPrivacy,
                onTap: () {},
              ),
              AccountMenuTile(
                icon: Icons.language,
                label: AppLocalizations.of(context)!.account_language,
                onTap: () {},
              ),
              AccountMenuTile(
                icon: Icons.logout,
                label: AppLocalizations.of(context)!.account_logout,
                labelColor: context.red10,
                onTap: () => _confirmLogout(context),
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
          onRefresh: () =>
              context.read<AccountCubit>().loadAccount(forceRefresh: true),
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
                          // Force refresh: an email change confirmed via OTP
                          // only exists server-side, the local snapshot
                          // can't know about it.
                          context.read<AccountCubit>().loadAccount(
                            forceRefresh: true,
                          );
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
                  label: AppLocalizations.of(context)!.common_email,
                  value: data.email.isEmpty ? '-' : data.email,
                ),
                AccountInfoRow(
                  label: AppLocalizations.of(context)!.common_phoneNumber,
                  value: (profile.phoneNumber?.isNotEmpty ?? false)
                      ? profile.phoneNumber!
                      : '-',
                ),
                if (data.pets.isNotEmpty) ...[
                  SizedBox(height: 20.h),
                  AccountSectionHeader(
                    title: AppLocalizations.of(context)!.common_yourPets,
                    actionLabel: AppLocalizations.of(context)!.common_seeAll,
                    onAction: () => context.pushRoute(AccountPetsRoute()),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.pets.length,
                      itemBuilder: (context, index) {
                        final pet = data.pets[index];
                        return AccountPetCard(
                          pet: pet,
                          onTap: () async {
                            await context.pushRoute(
                              PetProfileRoute(petId: pet.id),
                            );
                            if (context.mounted) {
                              context.read<AccountCubit>().loadAccount();
                            }
                          },
                          onEditTap: () async {
                            await context.pushRoute(
                              EditPetRoute(petId: pet.id),
                            );
                            if (context.mounted) {
                              context.read<AccountCubit>().loadAccount();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
                SizedBox(height: 28.h),
                AccountMenuTile(
                  icon: Icons.privacy_tip_outlined,
                  label: AppLocalizations.of(context)!.account_securityPrivacy,
                  onTap: () {},
                ),
                AccountMenuTile(
                  icon: Icons.language,
                  label: AppLocalizations.of(context)!.account_language,
                  onTap: () {},
                ),
                AccountMenuTile(
                  icon: Icons.logout,
                  label: AppLocalizations.of(context)!.account_logout,
                  labelColor: context.red10,
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
}

Future<void> _confirmLogout(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await showAppConfirmSheet(
    context: context,
    title: l10n.account_logout,
    message: l10n.account_logoutConfirmMessage,
    confirmLabel: l10n.account_logout,
    icon: Icons.logout_rounded,
    isDestructive: true,
  );

  if (confirmed && context.mounted) {
    await context.read<AccountCubit>().logOut();
  }
}
