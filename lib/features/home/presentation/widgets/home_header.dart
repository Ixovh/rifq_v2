import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rifq_v2/shared/constants/app_icons.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/profile_photo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.isGuest,
    this.imageUrl,
    this.initials = 'U',
    required this.onAvatarTap,
    this.onNotificationTap,
  });

  final bool isGuest;
  final String? imageUrl;
  final String initials;
  final VoidCallback onAvatarTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: isGuest
                ? Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.primary100,
                    ),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 24.sp,
                      color: context.primary300,
                    ),
                  )
                : ProfilePhoto(
                    diameter: 45.w,
                    imageUrl: imageUrl,
                    backgroundColor: context.primary100,
                    fallback: Center(
                      child: Text(
                        initials,
                        style: context.body1.copyWith(
                          color: context.primary300,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
          const Spacer(),
          SvgPicture.asset(AppIcons.logo, width: 52.w, height: 52.w),
          const Spacer(),
          GestureDetector(
            onTap: onNotificationTap,
            child: SizedBox(
              width: 30.w,
              height: 30.w,
              child: Icon(
                Icons.notifications_outlined,
                size: 28.sp,
                color: context.primary300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
