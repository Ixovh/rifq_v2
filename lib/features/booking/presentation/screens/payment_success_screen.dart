import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

// Placeholder shell — full success UI + Receipt navigation lands next pass.
@RoutePage()
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.confirmation});

  final BookingConfirmationEntity confirmation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            'Booking confirmed: ${confirmation.booking.bookingReference}',
            textAlign: TextAlign.center,
            style: context.h4.copyWith(color: context.neutral1000),
          ),
        ),
      ),
    );
  }
}
