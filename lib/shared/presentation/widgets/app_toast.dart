import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/theme/app_color.dart';

enum AppToastType { success, error, info, warning }

/// Floating toast notifications styled with the Rifq design system.
extension AppToastX on BuildContext {
  void showToast(
    String message, {
    AppToastType type = AppToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.maybeOf(this);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: duration,
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
          padding: EdgeInsets.zero,
          content: _AppToastCard(message: message, type: type),
        ),
      );
  }

  void showSuccessToast(String message) =>
      showToast(message, type: AppToastType.success);

  void showErrorToast(String message) =>
      showToast(message, type: AppToastType.error);

  void showInfoToast(String message) =>
      showToast(message, type: AppToastType.info);

  void showWarningToast(String message) =>
      showToast(message, type: AppToastType.warning);
}

class _AppToastCard extends StatelessWidget {
  const _AppToastCard({required this.message, required this.type});

  final String message;
  final AppToastType type;

  @override
  Widget build(BuildContext context) {
    final style = _ToastStyle.of(type);

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: style.background,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: style.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral1000.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: style.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(style.icon, size: 18.sp, color: style.iconColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: context.body2.copyWith(
                  color: style.textColor,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.background,
    required this.border,
    required this.iconBackground,
    required this.iconColor,
    required this.icon,
    required this.textColor,
  });

  final Color background;
  final Color border;
  final Color iconBackground;
  final Color iconColor;
  final IconData icon;
  final Color textColor;

  static _ToastStyle of(AppToastType type) {
    return switch (type) {
      AppToastType.success => const _ToastStyle(
        background: Color(0xFFF0FBF5),
        border: AppColors.green100,
        iconBackground: AppColors.green100,
        iconColor: AppColors.green200,
        icon: Icons.check_circle_rounded,
        textColor: AppColors.neutral1000,
      ),
      AppToastType.error => const _ToastStyle(
        background: Color(0xFFFFF1F2),
        border: Color(0xFFFFC9CE),
        iconBackground: Color(0xFFFFC9CE),
        iconColor: AppColors.red200,
        icon: Icons.error_rounded,
        textColor: AppColors.neutral1000,
      ),
      AppToastType.warning => const _ToastStyle(
        background: Color(0xFFFFFBEA),
        border: AppColors.yellow100,
        iconBackground: AppColors.yellow100,
        iconColor: AppColors.yellow200,
        icon: Icons.warning_rounded,
        textColor: AppColors.neutral1000,
      ),
      AppToastType.info => const _ToastStyle(
        background: Color(0xFFF0FBFA),
        border: AppColors.primary100,
        iconBackground: AppColors.primary100,
        iconColor: AppColors.primary400,
        icon: Icons.info_rounded,
        textColor: AppColors.neutral1000,
      ),
    };
  }
}
