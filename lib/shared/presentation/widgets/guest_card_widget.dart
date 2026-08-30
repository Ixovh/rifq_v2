import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/theme/app_color.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class GuestCard extends StatelessWidget {
  const GuestCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("🐾", style: TextStyle(fontSize: 22.sp)), //!!!!!!!!
              SizedBox(width: 8.w),
              Text(
                l10n.guest_title,
                style: context.h5.copyWith(
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Text(
            l10n.guest_body,
            style: context.body3.copyWith(color: Colors.black87),
          ),

          SizedBox(height: 16.h),
          TextButton(
            onPressed: () {
              context.pushRoute(AuthRoute(role: 'pet_owner'));
            },
            child: Center(
              child: Text(
                l10n.guest_cta,
                style: context.h4.copyWith(
                  color: AppColors.primary300,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
