import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle _poppins({
    required double fontSize,
    required FontWeight fontWeight,
    required double lineHeightPx,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,              
      fontWeight: fontWeight,
      height: lineHeightPx.h / fontSize.sp, 
      letterSpacing: 0,
    );
  }

  // Headings
  static TextStyle get h1 => _poppins(
        fontSize: 46,
        fontWeight: FontWeight.w700,
        lineHeightPx: 69,
      );

  static TextStyle get h2 => _poppins(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        lineHeightPx: 57,
      );

  static TextStyle get h3 => _poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        lineHeightPx: 48,
      );

  static TextStyle get h4 => _poppins(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        lineHeightPx: 39,
      );

  static TextStyle get h5 => _poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        lineHeightPx: 33,
      );

  // Body
  static TextStyle get body1 => _poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500, // Medium
        lineHeightPx: 27,
      );

  static TextStyle get body2 => _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        lineHeightPx: 24,
      );

  static TextStyle get body3 => _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        lineHeightPx: 21,
      );
}