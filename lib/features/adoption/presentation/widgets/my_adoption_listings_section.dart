import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/my_adoption_pet_card.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class MyAdoptionListingsSection extends StatelessWidget {
  const MyAdoptionListingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        if (state.isLoadingMyAdoptionPets) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.myAdoptionPets.isEmpty) {
          return Center(
            child: Text(
              'You have no pets for adoption',
              style: context.body1.copyWith(
                color: context.neutral400,
              ),
            ),
          );
        }

        return ListView(
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

            SizedBox(
              height: 390.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.myAdoptionPets.length,
                separatorBuilder: (_, __) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final pet = state.myAdoptionPets[index];

                  return SizedBox(
                    width: 342.w,
                    child: MyAdoptionPetCard(
                      pet: pet,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}