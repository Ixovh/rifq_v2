import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Visually matches the Figma "Book Now" CTA but stays disabled — booking
/// flow (form, payment, availability hold) is explicitly out of scope for
/// this pass.
class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary300,
          disabledBackgroundColor: context.primary200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          'Book Now',
          style: context.body1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
