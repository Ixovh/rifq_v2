import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/profile_photo.dart';

class PetCircleWidget extends StatelessWidget {
  const PetCircleWidget({
    super.key,
    required this.petName,
    this.imageUrl,
    this.onTap,
  });

  final String petName;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          children: [
            ProfilePhoto(
              diameter: 64.w,
              imageUrl: imageUrl,
              backgroundColor: context.primary100,
              fallback: Icon(
                Icons.pets,
                color: context.primary300,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              petName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.body3.copyWith(
                color: context.neutral1000,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
