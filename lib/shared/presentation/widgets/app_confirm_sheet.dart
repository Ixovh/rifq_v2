import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';

Future<bool> showAppConfirmSheet({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  IconData icon = Icons.logout_rounded,
  bool isDestructive = false,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AppConfirmSheet(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      icon: icon,
      isDestructive: isDestructive,
    ),
  );
  return result ?? false;
}

class _AppConfirmSheet extends StatelessWidget {
  const _AppConfirmSheet({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.icon,
    required this.isDestructive,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final accent = isDestructive ? context.red10 : context.primary300;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h + bottomInset),
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.neutral300,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28.sp, color: accent),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: context.h5.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: context.neutral1000,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: context.body2.copyWith(color: context.neutral800),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28.h),
          ContainerButton(
            label: confirmLabel,
            containerColor: isDestructive ? context.red10 : context.primary300,
            borderColor: isDestructive ? context.red10 : context.primary300,
            textColor: context.neutral100,
            fontSize: 20,
            onTap: () => Navigator.of(context).pop(true),
          ),
          SizedBox(height: 12.h),
          ContainerButton(
            label: cancelLabel,
            containerColor: context.neutral100,
            borderColor: context.primary300,
            textColor: context.primary300,
            fontSize: 20,
            onTap: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
