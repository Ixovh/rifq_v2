import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/my_adoption_pet_card.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_confirm_sheet.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';

class MyAdoptionListingsSection extends StatelessWidget {
  const MyAdoptionListingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: context.primary,
          onRefresh: () => context.read<AdoptionCubit>().refreshCurrentTab(),
          child: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, AdoptionState state) {
        if (state.isLoadingMyAdoptionPets && state.myAdoptionPets.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.myAdoptionPets.isEmpty) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: 160.h),
              Center(
                child: Text(
                  'You have no pets for adoption',
                  style: context.body1.copyWith(
                    color: context.neutral400,
                  ),
                ),
              ),
            ],
          );
        }

        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            16.w,
            28.h,
            16.w,
            100.h,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Adoption Listings',
                  style: context.body1.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: context.neutral700,
                  ),
                ),
                Text(
                  'See all',
                  style: context.body2.copyWith(
                    color: context.neutral400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            ...state.myAdoptionPets.map(
              (pet) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: MyAdoptionPetCard(
                  pet: pet,
                  onDelete: () => _deleteListing(context, pet.adoptionPostId),
                ),
              ),
            ),
          ],
        );
  }

  Future<void> _deleteListing(
    BuildContext context,
    String adoptionPostId,
  ) async {
    final confirmed = await showAppConfirmSheet(
      context: context,
      title: 'Remove listing',
      message:
          'This will remove the pet from adoption. The pet will stay in your pets.',
      confirmLabel: 'Delete',
      icon: Icons.delete_outline_rounded,
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) return;

    final cubit = context.read<AdoptionCubit>();
    await cubit.deleteAdoptionPost(adoptionPostId: adoptionPostId);

    if (!context.mounted) return;

    if (cubit.state.errorMessage != null) {
      context.showErrorToast(cubit.state.errorMessage!);
      return;
    }

    context.showSuccessToast('Adoption listing removed');
  }
}