import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField({
    super.key,
    required this.name,
    required this.label,
    required this.iconData,
    this.isPassword = false,
    this.controller,
    this.validators,
  });

  final String name;
  final String label;
  final IconData iconData;
  final bool isPassword;
  final TextEditingController? controller;
  final List<String? Function(String?)>? validators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      cursorColor: context.neutral1000,
      name: name,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
        prefixIcon: Icon(iconData, color: const Color(0xFF949494)),
        labelText: label,
        filled: true,
        fillColor: context.neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xFF949494)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(color: context.neutral700, width: 1),
        ),
      ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
    );
  }
}
