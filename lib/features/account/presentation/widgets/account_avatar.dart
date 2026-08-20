import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    super.key,
    required this.initials,
    this.avatarUrl,
    this.size = 150,
    this.showEditBadge = false,
    this.onEditTap,
  });

  final String initials;
  final String? avatarUrl;
  final double size;
  final bool showEditBadge;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final hasImage = avatarUrl != null && avatarUrl!.isNotEmpty;

    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.primary100,
              border: Border.all(color: context.primary300, width: 1),
              image: hasImage
                  ? DecorationImage(
                      image: NetworkImage(avatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Center(
                    child: Text(
                      initials.isNotEmpty ? initials[0].toUpperCase() : 'U',
                      style: context.h1.copyWith(
                        color: context.primary300,
                        fontSize: (size * 0.55).sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
          if (showEditBadge)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  width: 38.w,
                  height: 33.h,
                  decoration: BoxDecoration(
                    color: context.primary300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
