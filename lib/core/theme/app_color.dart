import 'package:flutter/material.dart';

/// App color palette based on the design system
abstract class AppColors {
  // Primary Colors
  static const Color primary50 = Color(0xFF3AB7A5);
  static const Color primary100 = Color(0xFFBBE9E3);
  static const Color primary200 = Color(0xFF77D4C6);
  static const Color primary300 = Color(0xFF3AB7A5);
  static const Color primary400 = Color(0xFF2D8E80);
  static const Color primary500 = Color(0xFF20655B);

  // Secondary Colors
  static const Color secondary100 = Color(0xFF8C6AFF);
  static const Color secondary200 = Color(0xFF6840E0);
  static const Color secondary300 = Color(0xFF5030B8);
  static const Color secondary400 = Color(0xFF3C1C8E);
  static const Color secondary500 = Color(0xFF2A0C68);
  static const Color secondary10 = Color(0xFFBCA9FF);

  // Neutral Colors
  static Color neutral10 = Color(0xFF333333).withValues(alpha: 0.9);
  static const Color neutral100 = Color(0xFFFFFFFF);
  static const Color neutral200 = Color(0xFFE8E8E8);
  static const Color neutral300 = Color(0xFFD2D2D2);
  static const Color neutral400 = Color(0xFFBBBBBB);
  static const Color neutral500 = Color(0xFFA4A4A4);
  static const Color neutral600 = Color(0xFF8E8E8E);
  static const Color neutral700 = Color(0xFF777777);
  static const Color neutral800 = Color(0xFF606060);
  static const Color neutral900 = Color(0xFF4A4A4A);
  static const Color neutral1000 = Color(0xFF333333);

  // Feedback Colors - Red
  static const Color red10 = Color(0xFFFB3748);
  static const Color red100 = Color(0xFFFB3748);
  static const Color red200 = Color(0xFFD00416);

  // Feedback Colors - Yellow
  static const Color yellow10 = Color(0xFFFFDB43);
  static const Color yellow100 = Color(0xFFFFDB43);
  static const Color yellow200 = Color(0xFFDFB400);

  // Feedback Colors - Green
  static const Color green10 = Color(0xFF84EBB4);
  static const Color green100 = Color(0xFF84EBB4);
  static const Color green200 = Color(0xFF1FC16B);

  // Semantic color aliases for easier usage
  static const Color background = neutral100;
  static const Color surface = neutral100;
  static const Color error = red200;
  static const Color success = green200;
  static const Color warning = yellow200;
  // static const Color info = ;
}
