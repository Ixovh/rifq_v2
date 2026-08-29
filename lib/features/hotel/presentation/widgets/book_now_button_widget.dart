import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Shared full-width pill CTA for the Hotel booking and Home Boarding
/// request flows. Passing no [onPressed] keeps it permanently disabled.
class BookNowButton extends StatelessWidget {
  const BookNowButton({
    super.key,
    this.label = 'Book Now',
    this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary300,
          disabledBackgroundColor: context.primary200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: isLoading
            ? Lottie.asset(
                'assets/lottie/Lovely cats.json',
                width: 36.w,
                height: 36.w,
                fit: BoxFit.contain,
              )
            : Text(
                label,
                style: context.body1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
