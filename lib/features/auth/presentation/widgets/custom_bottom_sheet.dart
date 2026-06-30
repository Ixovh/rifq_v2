import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_theme.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.content,
    this.controllers,
    this.formKeys,
    this.baseHeight = 570,
    this.keyboardHeightIncrease = 125,
    this.enableDrag = false,
  });

  final Widget content;
  final List<TextEditingController>? controllers;
  final List<GlobalKey>? formKeys;
  final double baseHeight;
  final double keyboardHeightIncrease;
  final bool enableDrag;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BottomSheet(
        enableDrag: widget.enableDrag,
        onClosing: () {},
        backgroundColor: context.neutral100,
        builder: (context) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 402.w,
            height: keyboardVisible
                ? (widget.baseHeight + widget.keyboardHeightIncrease).h
                : widget.baseHeight.h,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              border: Border.all(color: context.neutral400),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: widget.content,
          );
        },
      ),
    );
  }
}
