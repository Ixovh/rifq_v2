import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

// Placeholder shell so BookingDetailsScreen has somewhere to navigate to.
// The full price breakdown, payment-method selection, cosmetic Apple Pay
// sheet, and booking INSERT land in the next pass.
@RoutePage()
class ConfirmAndPayScreen extends StatelessWidget {
  const ConfirmAndPayScreen({super.key, required this.draft});

  final BookingDraftEntity draft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.router.maybePop(),
          icon: Icon(Icons.arrow_back_ios_new, color: context.neutral1000),
        ),
        title: Text(
          'Confirm and Pay',
          style: context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              draft.hotelDetail.name,
              style: context.h4.copyWith(color: context.neutral1000),
            ),
            SizedBox(height: 8.h),
            Text(
              'Total: SAR ${draft.totalPrice.toStringAsFixed(0)}',
              style: context.body1.copyWith(color: context.neutral700),
            ),
          ],
        ),
      ),
    );
  }
}
