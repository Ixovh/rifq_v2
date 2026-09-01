import 'package:equatable/equatable.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/shared/constants/booking_constants.dart';

class BookingRoomSelectionEntity extends Equatable {
  final String roomId;
  final String roomName;
  final double pricePerNight;
  final int quantity;

  const BookingRoomSelectionEntity({
    required this.roomId,
    required this.roomName,
    required this.pricePerNight,
    required this.quantity,
  });

  @override
  List<Object?> get props => [roomId, roomName, pricePerNight, quantity];
}

class BookingServiceSelectionEntity extends Equatable {
  final String serviceId;
  final String serviceName;
  final double price;
  final String? priceUnit;
  final int quantity;

  const BookingServiceSelectionEntity({
    required this.serviceId,
    required this.serviceName,
    required this.price,
    this.priceUnit,
    required this.quantity,
  });

  bool get isPerDay => priceUnit?.toLowerCase().contains('day') ?? false;

  @override
  List<Object?> get props => [
    serviceId,
    serviceName,
    price,
    priceUnit,
    quantity,
  ];
}

class BookingDraftEntity extends Equatable {
  final HotelDetailEntity hotelDetail;
  final String customerName;
  final String customerPhone;
  final int numberOfPets;
  final List<BookingRoomSelectionEntity> selectedRooms;
  final List<BookingServiceSelectionEntity> selectedServices;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final DateTime dropOffTime;
  final DateTime pickUpTime;

  const BookingDraftEntity({
    required this.hotelDetail,
    required this.customerName,
    required this.customerPhone,
    required this.numberOfPets,
    required this.selectedRooms,
    required this.selectedServices,
    required this.checkInDate,
    required this.checkOutDate,
    required this.dropOffTime,
    required this.pickUpTime,
  });

  int get nights => checkOutDate.difference(checkInDate).inDays;

  double get roomPriceTotal => selectedRooms.fold(
    0,
    (sum, room) => sum + (room.pricePerNight * room.quantity * nights),
  );

  double get addonPriceTotal => selectedServices.fold(
    0,
    (sum, service) =>
        sum +
        (service.price * service.quantity * (service.isPerDay ? nights : 1)),
  );

  double get appServiceFee => BookingConstants.appServiceFeeSar;

  double get totalPrice => roomPriceTotal + addonPriceTotal + appServiceFee;

  @override
  List<Object?> get props => [
    hotelDetail,
    customerName,
    customerPhone,
    numberOfPets,
    selectedRooms,
    selectedServices,
    checkInDate,
    checkOutDate,
    dropOffTime,
    pickUpTime,
  ];
}
