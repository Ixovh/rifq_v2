import 'package:equatable/equatable.dart';
import 'package:rifq_v2/features/booking/domain/entities/booking_draft_entity.dart';

class HotelBookingEntity extends Equatable {
  final String id;
  final String hotelId;
  final String petOwnerId;
  final int numberOfPets;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final DateTime dropOffTime;
  final DateTime pickUpTime;
  final double roomPriceTotal;
  final double addonPriceTotal;
  final double appServiceFee;
  final double totalPrice;
  final String paymentStatus;
  final String paymentMethod;
  final String bookingReference;
  final String bookingStatus;
  final DateTime createdAt;

  const HotelBookingEntity({
    required this.id,
    required this.hotelId,
    required this.petOwnerId,
    required this.numberOfPets,
    required this.checkInDate,
    required this.checkOutDate,
    required this.dropOffTime,
    required this.pickUpTime,
    required this.roomPriceTotal,
    required this.addonPriceTotal,
    required this.appServiceFee,
    required this.totalPrice,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.bookingReference,
    required this.bookingStatus,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    hotelId,
    petOwnerId,
    numberOfPets,
    checkInDate,
    checkOutDate,
    dropOffTime,
    pickUpTime,
    roomPriceTotal,
    addonPriceTotal,
    appServiceFee,
    totalPrice,
    paymentStatus,
    paymentMethod,
    bookingReference,
    bookingStatus,
    createdAt,
  ];
}

class BookingConfirmationEntity extends Equatable {
  final BookingDraftEntity draft;
  final HotelBookingEntity booking;

  const BookingConfirmationEntity({required this.draft, required this.booking});

  @override
  List<Object?> get props => [draft, booking];
}
