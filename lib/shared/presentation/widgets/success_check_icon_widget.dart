import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class SuccessCheckIcon extends StatelessWidget {
  const SuccessCheckIcon({super.key, this.size = 110});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: context.primary300,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check_rounded, color: Colors.white, size: (size * 0.55).sp),
    );
  }
}
