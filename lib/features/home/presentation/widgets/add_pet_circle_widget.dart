import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AddPetCircleWidget extends StatelessWidget {
  const AddPetCircleWidget({
    super.key,
    required this.onTap,
    this.showLabel = false,
  });

  final VoidCallback onTap;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: context.primary300,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 32.sp),
            ),
            if (showLabel) ...[
              SizedBox(height: 4.h),
              Text(
                AppLocalizations.of(context)!.home_addPet,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.body3.copyWith(
                  color: context.neutral1000,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
