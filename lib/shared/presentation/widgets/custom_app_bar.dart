import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/profile_photo.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String? imageUrl;
  final VoidCallback? onProfileTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.imageUrl,
    this.onProfileTap,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? _imageUrl;
  String _initials = 'U';

  @override
  void initState() {
    super.initState();
    _applyFromCache();
    _refreshIfNeeded();
  }

  @override
  void didUpdateWidget(covariant CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _applyFromCache();
    }
  }

  Map<String, dynamic>? get _cachedProfile {
    final userId = AuthHelper.getUserId();
    if (userId == null) return null;
    final snapshot = UserDataStore.read(userId);
    if (snapshot == null) return null;
    return UserDataStore.profileOf(snapshot);
  }

  String _initialsFrom(String? name) {
    final trimmed = name?.trim() ?? '';
    if (trimmed.isEmpty) return 'U';
    final parts = trimmed.split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final letters = parts.take(2).map((p) => p[0].toUpperCase()).join();
    return letters.isEmpty ? 'U' : letters;
  }

  void _applyFromCache() {
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      _imageUrl = widget.imageUrl;
      _initials = _initialsFrom(_cachedProfile?['full_name'] as String?);
      return;
    }

    final profile = _cachedProfile;
    _imageUrl = profile?['image_url'] as String?;
    _initials = _initialsFrom(profile?['full_name'] as String?);
  }

  Future<void> _refreshIfNeeded() async {
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) return;
    if (AuthHelper.isGuestUser()) return;
    final userId = AuthHelper.getUserId();
    if (userId == null) return;
    if (_imageUrl != null && _imageUrl!.isNotEmpty) return;

    try {
      final snapshot = await UserDataStore.fetchAndCache(
        Supabase.instance.client,
        userId,
      );
      if (!mounted) return;
      final profile = UserDataStore.profileOf(snapshot);
      setState(() {
        _imageUrl = profile['image_url'] as String?;
        _initials = _initialsFrom(profile['full_name'] as String?);
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.leftIcon ??
                GestureDetector(
                  onTap:
                      widget.onProfileTap ??
                      () => context.pushRoute(const AccountRoute()),
                  child: ProfilePhoto(
                    diameter: 45.w,
                    imageUrl: _imageUrl,
                    backgroundColor: context.primary100,
                    fallback: Center(
                      child: Text(
                        _initials,
                        style: context.body1.copyWith(
                          color: context.primary300,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: context.primary300,
              ),
            ),
            widget.rightIcon ??
                Icon(
                  Icons.notifications_outlined,
                  color: context.primary300,
                  size: 28.sp,
                ),
          ],
        ),
      ),
    );
  }
}
