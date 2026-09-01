import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/account/presentation/cubit/account_cubit.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_pet_card.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_back_icon.dart';

@RoutePage()
class AccountPetsScreen extends StatelessWidget {
  const AccountPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AccountCubit>()..loadAccount(),
      child: const _AccountPetsView(),
    );
  }
}

class _AccountPetsView extends StatelessWidget {
  const _AccountPetsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 48.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.common_yourPets,
                    style: context.h5.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.neutral1000,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () => context.router.maybePop(),
                      icon: AppBackIcon(color: context.neutral1000, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoading || state is AccountInitial) {
                    return const LottieLoding();
                  }

                  if (state is AccountErrorState) {
                    return Center(
                      child: TextButton(
                        onPressed: () =>
                            context.read<AccountCubit>().loadAccount(),
                        child: Text(AppLocalizations.of(context)!.common_retry),
                      ),
                    );
                  }

                  final pets = switch (state) {
                    AccountLoadedState(:final data) => data.pets,
                    AccountUpdatingState(:final data) => data.pets,
                    AccountUpdateSuccessState(:final data) => data.pets,
                    _ => const [],
                  };

                  if (pets.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.account_noPetsYet,
                        style: context.body2.copyWith(
                          color: context.neutral600,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      return AccountPetCard(
                        pet: pet,
                        fullWidth: true,
                        onTap: () async {
                          await context.pushRoute(
                            PetProfileRoute(petId: pet.id),
                          );
                          if (context.mounted) {
                            context.read<AccountCubit>().loadAccount();
                          }
                        },
                        onEditTap: () async {
                          await context.pushRoute(EditPetRoute(petId: pet.id));
                          if (context.mounted) {
                            context.read<AccountCubit>().loadAccount();
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
