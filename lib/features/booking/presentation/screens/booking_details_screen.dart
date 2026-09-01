import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/widgets/phone_number_field.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';
import 'package:rifq_v2/features/booking/presentation/cubit/booking_details_cubit.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/quantity_stepper_widget.dart';
import 'package:rifq_v2/features/booking/presentation/widgets/room_service_quantity_row_widget.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/user_data_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_back_icon.dart';

@RoutePage()
class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.hotel});

  final HotelDetailEntity hotel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<BookingDetailsCubit>(),
      child: _BookingDetailsView(hotel: hotel),
    );
  }
}

class _BookingDetailsView extends StatefulWidget {
  const _BookingDetailsView({required this.hotel});

  final HotelDetailEntity hotel;

  @override
  State<_BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<_BookingDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _phoneDigits = '';
  String _phoneCountryCode = '+966';
  String? _initialPhoneDigits;

  int _numberOfPets = 1;
  int _ownedPetCount = 1;
  late final Map<String, int> _roomQuantities;
  late final Map<String, int> _serviceQuantities;

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  DateTime? _dropOffTime;
  DateTime? _pickUpTime;

  @override
  void initState() {
    super.initState();
    _roomQuantities = {for (final r in widget.hotel.rooms) r.id: 0};
    _serviceQuantities = {for (final s in widget.hotel.services) s.id: 0};
    _prefillFromProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  int get _totalRoomQuantity =>
      _roomQuantities.values.fold<int>(0, (sum, q) => sum + q);

  int _maxForRoom(String roomId) {
    final current = _roomQuantities[roomId] ?? 0;
    return _numberOfPets - (_totalRoomQuantity - current);
  }

  void _setNumberOfPets(int value) {
    final capped = value.clamp(1, _ownedPetCount);
    setState(() {
      _numberOfPets = capped;
      // Keep reserved rooms within the new pet count.
      if (_totalRoomQuantity > _numberOfPets) {
        var overflow = _totalRoomQuantity - _numberOfPets;
        for (final id in _roomQuantities.keys.toList().reversed) {
          if (overflow <= 0) break;
          final q = _roomQuantities[id]!;
          if (q <= 0) continue;
          final reduce = q < overflow ? q : overflow;
          _roomQuantities[id] = q - reduce;
          overflow -= reduce;
        }
      }
    });
  }

  void _setRoomQuantity(String roomId, int value) {
    final maxAllowed = _maxForRoom(roomId);
    final next = value.clamp(0, maxAllowed);
    if (value > maxAllowed) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_roomsExceedPets,
      );
    }
    setState(() => _roomQuantities[roomId] = next);
  }

  Future<void> _prefillFromProfile() async {
    final userId =
        AuthHelper.getUserId() ?? Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    var snapshot = UserDataStore.read(userId);
    if (snapshot == null) {
      try {
        snapshot = await UserDataStore.fetchAndCache(
          Supabase.instance.client,
          userId,
        );
      } catch (_) {
        return;
      }
    }
    if (!mounted) return;

    final profile = UserDataStore.profileOf(snapshot);
    final fullName = (profile['full_name'] as String?)?.trim() ?? '';
    final phoneNumber = (profile['phone_number'] as String?)?.trim() ?? '';
    final ownedPets = UserDataStore.petsOf(snapshot).length;

    setState(() {
      if (_nameController.text.trim().isEmpty && fullName.isNotEmpty) {
        _nameController.text = fullName;
      }
      if (_initialPhoneDigits == null && phoneNumber.isNotEmpty) {
        _initialPhoneDigits = phoneNumber;
      }
      // Cap pets at how many the user actually has registered.
      _ownedPetCount = ownedPets > 0 ? ownedPets : 1;
      if (_numberOfPets > _ownedPetCount) {
        _numberOfPets = _ownedPetCount;
      }
    });
  }

  bool get _hasSelectedRooms => _roomQuantities.values.any((q) => q > 0);

  void _onContinue() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_hasSelectedRooms) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_selectRoom,
      );
      return;
    }
    if (_totalRoomQuantity > _numberOfPets) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_roomsExceedPets,
      );
      return;
    }
    if (_numberOfPets > _ownedPetCount) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_petsExceedOwned,
      );
      return;
    }
    if (_checkInDate == null || _checkOutDate == null) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_chooseDates,
      );
      return;
    }
    if (_dropOffTime == null || _pickUpTime == null) {
      context.showWarningToast(
        AppLocalizations.of(context)!.booking_chooseTimes,
      );
      return;
    }

    final selectedRooms = [
      for (final room in widget.hotel.rooms)
        if ((_roomQuantities[room.id] ?? 0) > 0)
          BookingRoomSelectionEntity(
            roomId: room.id,
            roomName: room.name,
            pricePerNight: room.pricePerNight,
            quantity: _roomQuantities[room.id]!,
          ),
    ];

    final selectedServices = [
      for (final service in widget.hotel.services)
        if ((_serviceQuantities[service.id] ?? 0) > 0)
          BookingServiceSelectionEntity(
            serviceId: service.id,
            serviceName: service.name,
            price: service.price ?? 0,
            priceUnit: service.priceUnit,
            quantity: _serviceQuantities[service.id]!,
          ),
    ];

    final candidate = BookingDraftEntity(
      hotelDetail: widget.hotel,
      customerName: _nameController.text.trim(),
      customerPhone: '$_phoneCountryCode$_phoneDigits',
      numberOfPets: _numberOfPets,
      selectedRooms: selectedRooms,
      selectedServices: selectedServices,
      checkInDate: _checkInDate!,
      checkOutDate: _checkOutDate!,
      dropOffTime: _dropOffTime!,
      pickUpTime: _pickUpTime!,
    );

    context.read<BookingDetailsCubit>().checkAvailabilityAndBuildDraft(
      candidate: candidate,
      catalogRooms: widget.hotel.rooms,
    );
  }

  Future<void> _pickDateRange() async {
    final picked = await showAppDateRangePicker(
      context: context,
      initialStart: _checkInDate,
      initialEnd: _checkOutDate,
      title: AppLocalizations.of(context)!.booking_chooseDatesTitle,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _checkInDate = picked.start;
      _checkOutDate = picked.end;
    });
  }

  Future<void> _pickDropOffTime() async {
    final picked = await showAppTimePicker(
      context: context,
      initial: _dropOffTime,
      title: AppLocalizations.of(context)!.booking_dropOffTime,
    );
    if (picked == null || !mounted) return;
    setState(() => _dropOffTime = picked);
  }

  Future<void> _pickPickUpTime() async {
    final picked = await showAppTimePicker(
      context: context,
      initial: _pickUpTime,
      title: AppLocalizations.of(context)!.booking_pickUpTime,
    );
    if (picked == null || !mounted) return;
    setState(() => _pickUpTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDetailsCubit, BookingDetailsState>(
      listener: (context, state) {
        if (state is BookingDetailsReady) {
          context.router.push(ConfirmAndPayRoute(draft: state.draft));
        } else if (state is BookingDetailsBlocked) {
          final issue = state.issues.first;
          context.showWarningToast(
            AppLocalizations.of(
              context,
            )!.booking_roomsLeft(issue.availableQuantity, issue.roomName),
          );
        } else if (state is BookingDetailsError) {
          context.showErrorToast(
            AppLocalizations.of(context)!.booking_errorAvailability,
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.background,
        appBar: AppBar(
          backgroundColor: context.background,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.router.maybePop(),
            icon: AppBackIcon(color: context.neutral1000),
          ),
          title: Text(
            AppLocalizations.of(context)!.booking_detailsTitle,
            style: context.body1.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 24.h),
                    children: [
                      _FieldLabel(AppLocalizations.of(context)!.common_name),
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration(context),
                        validator: (value) => (value?.trim().isEmpty ?? true)
                            ? AppLocalizations.of(context)!.common_nameRequired
                            : null,
                      ),
                      SizedBox(height: 16.h),
                      _FieldLabel(
                        AppLocalizations.of(context)!.common_phoneNumber,
                      ),
                      PhoneNumberField(
                        key: ValueKey(_initialPhoneDigits),
                        initialValue: _initialPhoneDigits,
                        isRequired: true,
                        onChanged: (phone) {
                          _phoneDigits = phone.number;
                          _phoneCountryCode = phone.countryCode;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _FieldLabel(
                            AppLocalizations.of(context)!.booking_numberOfPets,
                            bottomPadding: 0,
                          ),
                          QuantityStepper(
                            value: _numberOfPets,
                            min: 1,
                            max: _ownedPetCount,
                            onChanged: _setNumberOfPets,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _FieldLabel(
                        AppLocalizations.of(context)!.booking_servicesLabel,
                      ),
                      for (final room in widget.hotel.rooms)
                        RoomServiceQuantityRow(
                          label: room.name,
                          priceCaption: AppLocalizations.of(context)!
                              .common_pricePerNightSar(
                                room.pricePerNight.toStringAsFixed(0),
                              ),
                          value: _roomQuantities[room.id] ?? 0,
                          max: _maxForRoom(room.id),
                          onChanged: (v) => _setRoomQuantity(room.id, v),
                        ),
                      for (final service in widget.hotel.services)
                        RoomServiceQuantityRow(
                          label: service.name,
                          priceCaption: service.price == null
                              ? AppLocalizations.of(
                                  context,
                                )!.booking_priceOnRequest
                              : AppLocalizations.of(context)!.booking_priceSar(
                                      service.price!.toStringAsFixed(0),
                                    ) +
                                    (service.priceUnit != null
                                        ? ' / ${service.priceUnit}'
                                        : ''),
                          value: _serviceQuantities[service.id] ?? 0,
                          onChanged: (v) => setState(
                            () => _serviceQuantities[service.id] = v,
                          ),
                        ),
                      SizedBox(height: 16.h),
                      _FieldLabel(AppLocalizations.of(context)!.common_date),
                      InkWell(
                        onTap: _pickDateRange,
                        borderRadius: BorderRadius.circular(18.r),
                        child: InputDecorator(
                          decoration: _inputDecoration(context),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18.sp,
                                color: context.neutral600,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                _checkInDate == null || _checkOutDate == null
                                    ? AppLocalizations.of(
                                        context,
                                      )!.booking_chooseADate
                                    : '${DateFormat('d MMM').format(_checkInDate!)} - '
                                          '${DateFormat('d MMM yyyy').format(_checkOutDate!)}',
                                style: context.body2.copyWith(
                                  color: _checkInDate == null
                                      ? context.neutral500
                                      : context.neutral1000,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _FieldLabel(
                        AppLocalizations.of(
                          context,
                        )!.booking_dropOffPickUpLabel,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _TimeTile(
                              label: AppLocalizations.of(
                                context,
                              )!.booking_dropOff,
                              time: _dropOffTime,
                              onTap: _pickDropOffTime,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _TimeTile(
                              label: AppLocalizations.of(
                                context,
                              )!.booking_pickUp,
                              time: _pickUpTime,
                              onTap: _pickPickUpTime,
                            ),
                          ),
                        ],
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
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primary300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.common_continue,
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
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: context.neutral100,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: context.neutral200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: context.neutral200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: context.primary300, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: context.error),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text, {this.bottomPadding = 8});

  final String text;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding.h),
      child: Text(
        text,
        style: context.body2.copyWith(
          color: context.neutral1000,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final DateTime? time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: context.neutral200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.body3.copyWith(color: context.neutral600),
            ),
            SizedBox(height: 2.h),
            Text(
              time == null ? '--:--' : DateFormat('h:mm a').format(time!),
              style: context.body2.copyWith(
                color: context.neutral1000,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
