import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:printing/printing.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/features/booking/presentation/utils/receipt_pdf_builder.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/booking_barcode_widget.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/hotel_summary_card_widget.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/price_details_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';

@RoutePage()
class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key, required this.confirmation});

  final BookingConfirmationEntity confirmation;

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final bytes = await buildReceiptPdf(
        confirmation,
        AppLocalizations.of(context)!,
      );
      await Printing.sharePdf(
        bytes: bytes,
        filename: '${confirmation.booking.bookingReference}.pdf',
      );
    } catch (e) {
      debugPrint('ReceiptScreen._downloadPdf failed: $e');
      if (context.mounted) {
        context.showErrorToast(
          AppLocalizations.of(context)!.booking_receiptError,
        );
      }
    }
  }

  String _titleCase(String value) =>
      value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';

  @override
  Widget build(BuildContext context) {
    final booking = confirmation.booking;
    final locale = Localizations.localeOf(context).toLanguageTag();

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
          AppLocalizations.of(context)!.booking_receiptTitle,
          style: context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsetsDirectional.fromSTEB(18.w, 8.h, 18.w, 24.h),
                children: [
                  HotelSummaryCard(hotel: confirmation.draft.hotelDetail),
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.common_date,
                            style: context.body3.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'EEE, d MMM yyyy',
                              locale,
                            ).format(booking.createdAt),
                            style: context.body2.copyWith(
                              color: context.neutral1000,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.booking_status,
                            style: context.body3.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                          Text(
                            _titleCase(booking.bookingStatus),
                            style: context.body2.copyWith(
                              color: context.primary300,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  PriceDetailsWidget(
                    title: AppLocalizations.of(context)!.booking_priceTitle,
                    roomPriceTotal: booking.roomPriceTotal,
                    addonPriceTotal: booking.addonPriceTotal,
                    appServiceFee: booking.appServiceFee,
                    totalPrice: booking.totalPrice,
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: BookingBarcode(reference: booking.bookingReference),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.w),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () => _downloadPdf(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.booking_downloadPdf,
                    style: context.body1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
