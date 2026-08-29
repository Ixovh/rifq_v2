import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class PetCard extends StatelessWidget {
  final AddPetEntity pet;
  final VoidCallback onTap;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // Pet Image
            // =========================
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 290.h,
                child: pet.photoUrl.isNotEmpty
                    ? Image.network(
                        pet.photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: context.neutral100,
                            child: Icon(
                              Icons.pets,
                              size: 60.r,
                              color: context.neutral400,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: context.neutral100,
                        child: Icon(
                          Icons.pets,
                          size: 60.r,
                          color: context.neutral400,
                        ),
                      ),
              ),
            ),

            // =========================
            // Pet Information
            // =========================
            Padding(
              padding: EdgeInsets.fromLTRB(
                20.w,
                14.h,
                16.w,
                18.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet name + gender
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          pet.name,
                          style: context.body1.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: context.neutral600,
                          ),
                        ),
                      ),

                      // Gender icon
                      Container(
                        width: 42.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          pet.gender.toLowerCase() == 'male'
                              ? Icons.male
                              : Icons.female,
                          color: const Color(0xFF80A8E8),
                          size: 24.r,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Species + breed
                  Row(
                    children: [
                      Icon(
                        Icons.pets,
                        size: 18.r,
                        color: context.primary300,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${pet.species} • ${pet.breed}',
                          style: context.body2.copyWith(
                            fontSize: 15.sp,
                            color: context.neutral400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Gender
                  Text(
                    'Gender: ${pet.gender}',
                    style: context.body2.copyWith(
                      fontSize: 15.sp,
                      color: context.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}