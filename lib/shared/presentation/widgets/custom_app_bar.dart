import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Icon
            leftIcon ??
                IconButton(
                  icon: Icon(Icons.person, color: Colors.teal, size: 28.sp),
                  onPressed: () {
                    context.pushRoute(const AccountRoute());
                  },
                ),

            // CircleAvatar(
            //   radius: 24.r,
            //   backgroundColor: Colors.white,
            //   child: Icon(Icons.settings, color: Colors.teal),
            // ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),

            // Right Icon
            rightIcon ??
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.notifications_none, color: Colors.teal),
                ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

Future<String?> getUserId() async {
  // profiles.id matches auth.users.id
  return Supabase.instance.client.auth.currentUser?.id;
}
