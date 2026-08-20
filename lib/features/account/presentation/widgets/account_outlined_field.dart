import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AccountOutlinedField extends StatelessWidget {
  const AccountOutlinedField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 56.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.neutral100,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: field.hasError
                          ? context.error
                          : context.neutral200,
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    keyboardType: keyboardType,
                    onChanged: field.didChange,
                    style: context.body2.copyWith(
                      color: readOnly
                          ? context.neutral400
                          : context.neutral1000,
                      fontWeight: FontWeight.w500,
                      fontSize: readOnly ? 16.sp : 18.sp,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Positioned(
                  left: 22.w,
                  top: -10.h,
                  child: Container(
                    color: context.neutral100,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      label,
                      style: context.body2.copyWith(
                        color: context.neutral700,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 6.h, left: 8.w),
                child: Text(
                  field.errorText!,
                  style: context.body3.copyWith(color: context.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
