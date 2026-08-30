import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart' show Barcode;
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
  final doc = pw.Document();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(28),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                l10n.booking_receiptTitle,
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 18),
              pw.Text(
                hotel.name,
                style: pw.TextStyle(
                  fontSize: 15,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                hotel.locationText,
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 18),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        l10n.common_date,
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        DateFormat('EEE, d MMM yyyy').format(booking.createdAt),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        l10n.booking_status,
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        _titleCase(booking.bookingStatus),
                        style: const pw.TextStyle(color: PdfColors.teal700),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 18),
              pw.Divider(),
              pw.SizedBox(height: 6),
              _priceRow(l10n, l10n.booking_roomPrice, booking.roomPriceTotal),
              _priceRow(
                l10n,
                l10n.booking_addonServices,
                booking.addonPriceTotal,
              ),
              _priceRow(
                l10n,
                l10n.booking_totalBeforeFees,
                booking.roomPriceTotal + booking.addonPriceTotal,
              ),
              _priceRow(
                l10n,
                l10n.booking_appServiceFee,
                booking.appServiceFee,
              ),
              pw.SizedBox(height: 6),
              pw.Divider(),
              pw.SizedBox(height: 6),
              _priceRow(
                l10n,
                l10n.booking_totalPrice,
                booking.totalPrice,
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
                    pw.Text(booking.bookingReference),
                  ],
                ),
              ),
            ],
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
  double value, {
  bool bold = false,
}) {
  final style = pw.TextStyle(
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
