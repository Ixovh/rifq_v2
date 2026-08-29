import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/success_check_icon_widget.dart';

// No back affordance — this is a point-of-no-return screen once payment
// has been simulated as paid.
@RoutePage()
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.confirmation});

  final BookingConfirmationEntity confirmation;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SuccessCheckIcon(),
                        SizedBox(height: 24.h),
                        Text(
                          'Payment Successful',
                          style: context.h3.copyWith(
                            color: context.neutral1000,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () => context.router.replace(
                      ReceiptRoute(confirmation: confirmation),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'See Details',
                      style: context.body1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
