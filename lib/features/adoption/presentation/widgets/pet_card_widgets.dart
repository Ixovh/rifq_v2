import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/add_pet/domain/entities/add_pet_entity.dart';

import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class PetCard extends StatelessWidget {
  final AddPetEntity pet;
  final VoidCallback onTap;

  const PetCard({super.key, required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F656565),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Pet Photo
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: context.neutral200,
              ),
              child: pet.photoUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        pet.photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.pets,
                            size: 40.r,
                            color: context.neutral400,
                          );
                        },
                      ),
                    )
                  : Icon(Icons.pets, size: 40.r, color: context.neutral400),
            ),
            SizedBox(width: 16.w),
            // Pet Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: context.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.primary300,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${pet.species} • ${pet.breed}',
                    style: context.body2.copyWith(color: context.neutral400),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Gender: ${pet.gender}',
                    style: context.body2.copyWith(color: context.neutral400),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20.r, color: context.primary),
          ],
        ),
      ),
    );
  }
}