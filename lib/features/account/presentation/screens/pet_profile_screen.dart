import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/presentation/widgets/pet_label_helpers.dart';
import 'package:rifq_v2/features/edit_pet/presentation/cubit/edit_pet_cubit.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/health_record/presentation/cubit/health_record_cubit.dart';
import 'package:rifq_v2/features/health_record/presentation/widgets/pet_health_record_tab.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_back_icon.dart';

@RoutePage()
class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key, required this.petId});

  final String petId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<EditPetCubit>()..loadPet(petId)),
        BlocProvider(
          create: (_) => GetIt.I<HealthRecordCubit>()..loadRecords(petId),
        ),
      ],
      child: _PetProfileView(petId: petId),
    );
  }
}

class _PetProfileView extends StatefulWidget {
  const _PetProfileView({required this.petId});

  final String petId;

  @override
  State<_PetProfileView> createState() => _PetProfileViewState();
}

class _PetProfileViewState extends State<_PetProfileView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _openEdit(BuildContext context) async {
    final updated = await context.pushRoute(EditPetRoute(petId: widget.petId));
    if (updated == true && context.mounted) {
      context.read<EditPetCubit>().loadPet(widget.petId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPetCubit, EditPetState>(
      builder: (context, state) {
        if (state is EditPetLoading || state is EditPetInitial) {
          return const Scaffold(body: LottieLoding());
        }

        final pet = switch (state) {
          EditPetLoaded(:final pet) => pet,
          EditPetUpdating(:final pet) => pet,
          EditPetUpdateSuccess(:final pet) => pet,
          _ => null,
        };

        if (pet == null) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.router.maybePop(),
                child: Text(AppLocalizations.of(context)!.common_goBack),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: context.background,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.router.maybePop(),
                        icon: AppBackIcon(color: context.neutral1000, size: 20.sp),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.petProfile_title,
                          textAlign: TextAlign.center,
                          style: context.h4.copyWith(
                            color: context.neutral1000,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _openEdit(context),
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 24.sp,
                          color: context.primary300,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                _PetHero(pet: pet),
                SizedBox(height: 24.h),
                _PetTabs(tabController: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      PetHealthRecordTab(petId: widget.petId),
                      const _AppointmentTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PetHero extends StatelessWidget {
  const _PetHero({required this.pet});

  final AccountPetEntity pet;

  @override
  Widget build(BuildContext context) {
    final isFemale = pet.gender.toLowerCase().startsWith('f');

    return Column(
      children: [
        Container(
          width: 146.w,
          height: 146.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.neutral100,
            border: Border.all(color: context.primary300, width: 2),
            image: pet.photoUrl != null && pet.photoUrl!.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(pet.photoUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: pet.photoUrl == null || pet.photoUrl!.isEmpty
              ? Icon(Icons.pets, size: 48.sp, color: context.primary300)
              : null,
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pet.name,
              style: context.h4.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: isFemale ? context.secondary10 : context.primary100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFemale ? Icons.female : Icons.male,
                size: 12.sp,
                color: isFemale ? context.secondary200 : context.primary300,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          pet.breed.isEmpty ? petSpeciesLabel(context, pet) : pet.breed,
          style: context.body2.copyWith(color: context.neutral600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InfoChip(
              icon: Icons.cake_outlined,
              label: petAgeLabel(context, pet).toLowerCase(),
            ),
            SizedBox(width: 18.w),
            _InfoChip(
              icon: Icons.monitor_weight_outlined,
              label: petWeightLabel(context, pet),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: context.primary300),
        SizedBox(width: 4.w),
        Text(
          label,
          style: context.body2.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PetTabs extends StatelessWidget {
  const _PetTabs({required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: context.primary300,
      unselectedLabelColor: context.neutral600,
      indicatorColor: context.primary300,
      indicatorWeight: 3,
      labelStyle: context.body2.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: context.body2,
      tabs: [
        Tab(text: AppLocalizations.of(context)!.petProfile_tabHealthRecord),
        Tab(text: AppLocalizations.of(context)!.petProfile_tabAppointment),
      ],
    );
  }
}

class _AppointmentTab extends StatelessWidget {
  const _AppointmentTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.petProfile_noAppointments,
        style: context.body1.copyWith(
          color: context.neutral700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
