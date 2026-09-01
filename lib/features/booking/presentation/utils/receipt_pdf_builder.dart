import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart' show Barcode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';

Future<Uint8List> buildReceiptPdf(
  BookingConfirmationEntity confirmation,
  AppLocalizations l10n,
) async {
  final hotel = confirmation.draft.hotelDetail;
  final booking = confirmation.booking;
  final isRtl = l10n.localeName.startsWith('ar');
  final locale = l10n.localeName;

  // Poppins (app UI font) has no Arabic glyphs — use bundled Cairo for PDF.
  final baseFont = pw.Font.ttf(
    await rootBundle.load('assets/fonts/Cairo-Regular.ttf'),
  );
  final boldFont = pw.Font.ttf(
    await rootBundle.load('assets/fonts/Cairo-Bold.ttf'),
  );

  final theme = pw.ThemeData.withFont(base: baseFont, bold: boldFont);
  final textDir = isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr;
  final crossStart = isRtl
      ? pw.CrossAxisAlignment.end
      : pw.CrossAxisAlignment.start;

  final doc = pw.Document(theme: theme);

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: theme,
      build: (context) {
        return pw.Directionality(
          textDirection: textDir,
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(28),
            child: pw.Column(
              crossAxisAlignment: crossStart,
              children: [
                pw.Text(
                  l10n.booking_receiptTitle,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontFallback: [baseFont],
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 18),
                pw.Text(
                  hotel.name,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontFallback: [baseFont],
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  hotel.locationText,
                  style: pw.TextStyle(
                    font: baseFont,
                    fontFallback: [boldFont],
                    fontSize: 11,
                  ),
                ),
                pw.SizedBox(height: 18),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        pw.Text(
                          l10n.common_date,
                          style: pw.TextStyle(
                            font: baseFont,
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          DateFormat(
                            'EEE, d MMM yyyy',
                            locale,
                          ).format(booking.createdAt),
                          style: pw.TextStyle(font: baseFont),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        pw.Text(
                          l10n.booking_status,
                          style: pw.TextStyle(
                            font: baseFont,
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          _titleCase(booking.bookingStatus),
                          style: pw.TextStyle(
                            font: baseFont,
                            color: PdfColors.teal700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 18),
                pw.Divider(),
                pw.SizedBox(height: 6),
                _priceRow(
                  l10n,
                  l10n.booking_roomPrice,
                  booking.roomPriceTotal,
                  baseFont,
                  boldFont,
                ),
                _priceRow(
                  l10n,
                  l10n.booking_addonServices,
                  booking.addonPriceTotal,
                  baseFont,
                  boldFont,
                ),
                _priceRow(
                  l10n,
                  l10n.booking_totalBeforeFees,
                  booking.roomPriceTotal + booking.addonPriceTotal,
                  baseFont,
                  boldFont,
                ),
                _priceRow(
                  l10n,
                  l10n.booking_appServiceFee,
                  booking.appServiceFee,
                  baseFont,
                  boldFont,
                ),
                pw.SizedBox(height: 6),
                pw.Divider(),
                pw.SizedBox(height: 6),
                _priceRow(
                  l10n,
                  l10n.booking_totalPrice,
                  booking.totalPrice,
                  baseFont,
                  boldFont,
                  bold: true,
                ),
                pw.SizedBox(height: 28),
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: booking.bookingReference,
                        width: 220,
                        height: 60,
                        drawText: false,
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        booking.bookingReference,
                        style: pw.TextStyle(font: baseFont),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return doc.save();
}

pw.Widget _priceRow(
  AppLocalizations l10n,
  String label,
  double value,
  pw.Font baseFont,
  pw.Font boldFont, {
  bool bold = false,
}) {
  final style = pw.TextStyle(
    font: bold ? boldFont : baseFont,
    fontFallback: [baseFont, boldFont],
    fontSize: bold ? 13 : 11,
    fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
  );
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: style),
        pw.Text(l10n.booking_amountSar(value.toStringAsFixed(0)), style: style),
      ],
    ),
  );
}

String _titleCase(String value) =>
    value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';
