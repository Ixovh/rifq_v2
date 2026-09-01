import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class BookingBarcode extends StatelessWidget {
  const BookingBarcode({super.key, required this.reference});

  final String reference;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 240.w,
          height: 70.h,
          child: BarcodeWidget(
            barcode: Barcode.code128(),
            data: reference,
            drawText: false,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          reference,
          style: context.body2.copyWith(
            color: context.neutral700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
