import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
                  onPressed: () async {
                    final userId = await getUserId();
                    // if (userId != null) {
                    //   context.push(Routes.profile, extra: userId);
                    // }
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
  final supabase = Supabase.instance.client;

  final authId = supabase.auth.currentUser?.id;

  if (authId == null) return null;

  final data = await supabase
      .from('users')
      .select('id')
      .eq('auth_id', authId)
      .maybeSingle();

  return data?['id'];
}
