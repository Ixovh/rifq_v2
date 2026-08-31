import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/utils/app_date_utils.dart';

class AdoptionPetListSection extends StatelessWidget {
  const AdoptionPetListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        if (state.isLoadingPosts) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(state.errorMessage!, textAlign: TextAlign.center),
            ),
          );
        }

        if (state.adoptionPetCards.isEmpty) {
          return Center(
            child: Text(
              'No pets available for adoption',
              style: context.body1.copyWith(color: context.neutral400),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 100.h),
          itemCount: state.adoptionPetCards.length,
          itemBuilder: (context, index) {
            final pet = state.adoptionPetCards[index];

            return InkWell(
              onTap: () {
                context.router.push(PetDetailsRoute(pet: pet));
              },
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 220.h,
                        child: pet.imageUrl != null && pet.imageUrl!.isNotEmpty
                            ? Image.network(
                                pet.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return _PlaceholderImage();
                                },
                              )
                            : _PlaceholderImage(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet.name,
                            style: context.body1.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: context.neutral700,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20.r,
                                color: context.primary,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  pet.location,
                                  style: context.body2.copyWith(
                                    color: context.neutral400,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),

                          Row(
                            children: [
                              Icon(
                                Icons.cake_outlined,
                                size: 20.r,
                                color: context.primary,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                AppDateUtils.formatAge(pet.birthdate),
                                style: context.body2.copyWith(
                                  color: context.neutral400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.neutral100,
      child: Icon(Icons.pets, size: 60.r, color: context.primary),
    );
  }
}
