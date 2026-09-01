



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AdoptionHeader extends StatelessWidget {
  const AdoptionHeader({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
    required this.userInitial,
  });

  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final String userInitial;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.10),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // =========================
          // Profile
          // =========================
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.primary.withValues(alpha: 0.12),
                border: Border.all(
                  color: context.primary,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                userInitial,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: context.primary,
                ),
              ),
            ),
          ),

          const Spacer(),

          // =========================
          // Title
          // =========================
          Text(
            AppLocalizations.of(context)!.adoption_screenTitle,
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
              color: context.primary50,
            ),
          ),

          const Spacer(),

          // =========================
          // Notification
          // =========================
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotificationTap,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  minWidth: 40.w,
                  minHeight: 40.w,
                ),
                icon: Icon(
                  Icons.notifications_none_rounded,
                  size: 32.sp,
                  color: context.primary50,
                ),
              ),

              Positioned(
                right: 2.w,
                top: 1.h,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}