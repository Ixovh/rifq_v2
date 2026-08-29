import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomeButtonWidgets extends StatelessWidget {
  final String titel;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonhight;
  final bool isLoading;

  const CustomeButtonWidgets({
    super.key,
    required this.titel,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonhight,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonWidth, buttonhight),
        backgroundColor: const Color(0xFF3AB7A5),
        disabledBackgroundColor: const Color(0xFF3AB7A5),
      ),
      child: isLoading
          ? Lottie.asset(
              'assets/lottie/Lovely cats.json',
              height: buttonhight - 12,
              fit: BoxFit.contain,
            )
          : Text(
              titel,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
    );
  }
}
