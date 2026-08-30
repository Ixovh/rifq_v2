import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/presentation/cubit/booking_create_cubit.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/apple_pay_confirm_sheet_widget.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/hotel_summary_card_widget.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/price_details_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/book_now_button_widget.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';

String paymentMethodLabel(BuildContext context, PaymentMethodOption method) {
  final l10n = AppLocalizations.of(context)!;
  return switch (method) {
    PaymentMethodOption.applePay => l10n.paymentMethod_applePay,
    PaymentMethodOption.visa => l10n.paymentMethod_visa,
    PaymentMethodOption.mastercard => l10n.paymentMethod_mastercard,
  };
}

@RoutePage()
class ConfirmAndPayScreen extends StatefulWidget {
  const ConfirmAndPayScreen({super.key, required this.draft});

  final BookingDraftEntity draft;

  @override
  State<ConfirmAndPayScreen> createState() => _ConfirmAndPayScreenState();
}

class _ConfirmAndPayScreenState extends State<ConfirmAndPayScreen> {
  PaymentMethodOption _selectedMethod = PaymentMethodOption.applePay;

  Future<void> _onConfirmAndPay(BuildContext context) async {
    final confirmed = await showApplePayConfirmSheet(
      context: context,
      priceLabel: AppLocalizations.of(
        context,
      )!.booking_amountSar(widget.draft.totalPrice.toStringAsFixed(0)),
    );
    if (confirmed == true && context.mounted) {
      context.read<BookingCreateCubit>().confirmAndPay(
        draft: widget.draft,
        paymentMethod: _selectedMethod,
      );
    }
  }

  String _dateRangeLabel(AppLocalizations l10n) {
    final draft = widget.draft;
    if (draft.nights <= 1) {
      return DateFormat('EEE, d MMM yyyy').format(draft.checkInDate);
    }
    final start = DateFormat('EEE d MMM').format(draft.checkInDate);
    final end = DateFormat('EEE d MMM').format(draft.checkOutDate);
    final year = DateFormat('yyyy').format(draft.checkOutDate);
    return '$start - $end, $year · ${l10n.booking_nightsCount(draft.nights)}';
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => GetIt.I<BookingCreateCubit>(),
      child: BlocConsumer<BookingCreateCubit, BookingCreateState>(
        listener: (context, state) {
          if (state is BookingCreateCreated) {
            context.router.replace(
              PaymentSuccessRoute(confirmation: state.confirmation),
            );
          } else if (state is BookingCreateError) {
            context.showErrorToast(
              AppLocalizations.of(context)!.booking_errorCreating,
            );
          }
        },
        builder: (context, state) {
          final isCreating = state is BookingCreateCreating;

          return Scaffold(
            backgroundColor: context.background,
            appBar: AppBar(
              backgroundColor: context.background,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.router.maybePop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.neutral1000,
                ),
              ),
              title: Text(
                l10n.booking_confirmPayTitle,
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
                      padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
                      children: [
                        HotelSummaryCard(hotel: draft.hotelDetail),
                        SizedBox(height: 18.h),
                        _SectionTitle(l10n.booking_yourOrder),
                        _OrderRow(
                          label: l10n.booking_roomType,
                          value: draft.selectedRooms.isEmpty
                              ? '-'
                              : draft.selectedRooms
                                    .map((r) => '${r.quantity} × ${r.roomName}')
                                    .join(', '),
                        ),
                        if (draft.selectedServices.isNotEmpty)
                          _OrderRow(
                            label: l10n.booking_servicesSelected,
                            value: draft.selectedServices
                                .map((s) => '${s.quantity} × ${s.serviceName}')
                                .join(', '),
                          ),
                        _OrderRow(
                          label: l10n.booking_numberOfPetsOrder,
                          value: l10n.booking_petsCount(draft.numberOfPets),
                        ),
                        SizedBox(height: 18.h),
                        _SectionTitle(l10n.booking_stayDuration),
                        Text(
                          _dateRangeLabel(l10n),
                          style: context.body2.copyWith(
                            color: context.neutral1000,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          l10n.booking_dropOffTimeValue(
                            DateFormat('h:mm a').format(draft.dropOffTime),
                          ),
                          style: context.body3.copyWith(
                            color: context.neutral600,
                          ),
                        ),
                        Text(
                          '${l10n.booking_pickUpTimeValue(DateFormat('h:mm a').format(draft.pickUpTime))}'
                          '${draft.nights <= 1 ? l10n.booking_nextDaySuffix : ''}',
                          style: context.body3.copyWith(
                            color: context.neutral600,
                          ),
                        ),
                        SizedBox(height: 18.h),
                        PriceDetailsWidget(
                          roomPriceTotal: draft.roomPriceTotal,
                          addonPriceTotal: draft.addonPriceTotal,
                          appServiceFee: draft.appServiceFee,
                          totalPrice: draft.totalPrice,
                        ),
                        SizedBox(height: 18.h),
                        _SectionTitle(l10n.booking_paymentMethod),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            for (final method in PaymentMethodOption.values)
                              Padding(
                                padding: EdgeInsetsDirectional.only(end: 12.w),
                                child: _PaymentMethodIcon(
                                  method: method,
                                  selected: _selectedMethod == method,
                                  onTap: () =>
                                      setState(() => _selectedMethod = method),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.w),
                    child: BookNowButton(
                      label: l10n.booking_confirmPayTitle,
                      isLoading: isCreating,
                      onPressed: () => _onConfirmAndPay(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.body1.copyWith(
        color: context.neutral1000,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Text(
              label,
              style: context.body3.copyWith(color: context.neutral600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.body2.copyWith(color: context.neutral1000),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodIcon extends StatelessWidget {
  const _PaymentMethodIcon({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethodOption method;
  final bool selected;
  final VoidCallback onTap;

  IconData get _icon => switch (method) {
    PaymentMethodOption.applePay => Icons.apple,
    PaymentMethodOption.visa => Icons.credit_card,
    PaymentMethodOption.mastercard => Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? context.primary300 : context.neutral200,
            width: selected ? 1.5 : 1,
          ),
          color: selected
              ? context.primary100.withValues(alpha: 0.3)
              : context.neutral100,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              size: 18.sp,
              color: selected ? context.primary400 : context.neutral600,
            ),
            SizedBox(width: 6.w),
            Text(
              paymentMethodLabel(context, method),
              style: context.body3.copyWith(
                color: selected ? context.primary400 : context.neutral700,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
