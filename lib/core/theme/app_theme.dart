import 'package:flutter/material.dart';
import 'package:rifq_v2/core/theme/app_text_theme.dart';
import 'app_color.dart';

extension AppThemeX on BuildContext {
  // ---------- Colors ----------

  // Primary
  Color get primary50 => AppColors.primary50;
  Color get primary100 => AppColors.primary100;
  Color get primary200 => AppColors.primary200;
  Color get primary300 => AppColors.primary300;
  Color get primary400 => AppColors.primary400;
  Color get primary500 => AppColors.primary500;
  Color get primary => AppColors.primary300;

  // Secondary
  Color get secondary10 => AppColors.secondary10;
  Color get secondary100 => AppColors.secondary100;
  Color get secondary200 => AppColors.secondary200;
  Color get secondary300 => AppColors.secondary300;
  Color get secondary400 => AppColors.secondary400;
  Color get secondary500 => AppColors.secondary500;
  Color get secondary => AppColors.secondary300;

  // Neutral
  Color get neutral10 => AppColors.neutral10;
  Color get neutral100 => AppColors.neutral100;
  Color get neutral200 => AppColors.neutral200;
  Color get neutral300 => AppColors.neutral300;
  Color get neutral400 => AppColors.neutral400;
  Color get neutral500 => AppColors.neutral500;
  Color get neutral600 => AppColors.neutral600;
  Color get neutral700 => AppColors.neutral700;
  Color get neutral800 => AppColors.neutral800;
  Color get neutral900 => AppColors.neutral900;
  Color get neutral1000 => AppColors.neutral1000;

  // Feedback
  Color get red10 => AppColors.red10;
  Color get red100 => AppColors.red100;
  Color get red200 => AppColors.red200;
  Color get error => AppColors.error;

  Color get yellow10 => AppColors.yellow10;
  Color get yellow100 => AppColors.yellow100;
  Color get yellow200 => AppColors.yellow200;
  Color get warning => AppColors.warning;

  Color get green10 => AppColors.green10;
  Color get green100 => AppColors.green100;
  Color get green200 => AppColors.green200;
  Color get success => AppColors.success;

  // Semantic
  Color get background => AppColors.background;
  Color get surface => AppColors.surface;
  // Color get info => AppColors.info;

  // ---------- Typography ----------

  TextStyle get h1 => AppTextStyles.h1;
  TextStyle get h2 => AppTextStyles.h2;
  TextStyle get h3 => AppTextStyles.h3;
  TextStyle get h4 => AppTextStyles.h4;
  TextStyle get h5 => AppTextStyles.h5;

  TextStyle get body1 => AppTextStyles.body1;
  TextStyle get body2 => AppTextStyles.body2;
  TextStyle get body3 => AppTextStyles.body3;


   // عشان بسرعه نوصل اللى  بالغالب اللئ راح نستخذمها بكثره 
  TextStyle get headingLarge => h1;
  TextStyle get headingMedium => h3;
  TextStyle get headingSmall => h5;
  TextStyle get bodyLarge => body1;
  TextStyle get bodyMedium => body2;
  TextStyle get bodySmall => body3;  
}