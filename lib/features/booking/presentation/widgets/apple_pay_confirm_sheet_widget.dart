import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Cosmetic-only bottom sheet styled after the native Apple Pay confirm UI.
/// Not PassKit/`pay`-package integration — no Apple Developer Merchant ID
/// is configured. Resolves `true` when "Confirm with Side Button" is
/// tapped, `false`/`null` otherwise; the caller decides what happens next.
Future<bool?> showApplePayConfirmSheet({
  required BuildContext context,
  required String priceLabel,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    builder: (_) => _ApplePayConfirmSheet(priceLabel: priceLabel),
  );
}

class _ApplePayConfirmSheet extends StatelessWidget {
  const _ApplePayConfirmSheet({required this.priceLabel});

  final String priceLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(Icons.close, color: Colors.black45),
                  ),
                  Row(
                    children: [
                      Icon(Icons.apple, size: 20.sp, color: Colors.black),
                      SizedBox(width: 2.w),
                      Text(
                        l10n.applePay_payWordmark,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Column(
                  children: [
                    _SheetInfoRow(
                      leading: const Icon(
                        Icons.credit_card,
                        color: Colors.black87,
                      ),
                      title: l10n.applePay_cardName,
                    ),
                    Divider(height: 1, color: context.neutral200),
                    _SheetInfoRow(
                      title: l10n.booking_priceTitle,
                      trailingText: priceLabel,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              InkWell(
                onTap: () => Navigator.pop(context, true),
                borderRadius: BorderRadius.circular(100.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.applePay_confirmSideButton,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetInfoRow extends StatelessWidget {
  const _SheetInfoRow({this.leading, required this.title, this.trailingText});

  final Widget? leading;
  final String title;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F7),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: 10.w)],
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.black87)),
          ),
          if (trailingText != null)
            Flexible(
              child: Text(
                trailingText!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SizedBox(width: 4.w),
          const Icon(Icons.chevron_right, color: Colors.black38),
        ],
      ),
    );
  }
}
