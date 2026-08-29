import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq_v2/features/booking/domain/entities/hotel_booking_entity.dart';

part 'hotel_booking_model.mapper.dart';

@MappableClass()
class HotelBookingModel with HotelBookingModelMappable {
  final String id;

  @MappableField(key: 'hotel_id')
  final String hotelId;

  @MappableField(key: 'pet_owner_id')
  final String petOwnerId;

  @MappableField(key: 'number_of_pets')
  final int numberOfPets;

  @MappableField(key: 'check_in_date')
  final String checkInDate;

  @MappableField(key: 'check_out_date')
  final String checkOutDate;

  @MappableField(key: 'drop_off_time')
  final String dropOffTime;

  @MappableField(key: 'pick_up_time')
  final String pickUpTime;

  @MappableField(key: 'room_price_total')
  final double roomPriceTotal;

  @MappableField(key: 'addon_price_total')
  final double addonPriceTotal;

  @MappableField(key: 'app_service_fee')
  final double appServiceFee;

  @MappableField(key: 'total_price')
  final double totalPrice;

  @MappableField(key: 'payment_status')
  final String paymentStatus;

  @MappableField(key: 'payment_method')
  final String paymentMethod;

  @MappableField(key: 'booking_reference')
  final String bookingReference;

  @MappableField(key: 'booking_status')
  final String bookingStatus;

  @MappableField(key: 'created_at')
  final String createdAt;

  const HotelBookingModel({
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

  factory HotelBookingModel.fromJson(Map<String, dynamic> json) =>
      HotelBookingModelMapper.fromMap(json);

  // Postgres `time` columns come back as "17:00:00" — not ISO datetimes, so
  // DateTime.parse would throw. Anchored on an arbitrary fixed date since
  // only the hour/minute are ever read.
  static DateTime _parseTimeOfDay(String raw) {
    final parts = raw.split(':');
    return DateTime(2000, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }

  HotelBookingEntity toEntity() {
    return HotelBookingEntity(
      id: id,
      hotelId: hotelId,
      petOwnerId: petOwnerId,
      numberOfPets: numberOfPets,
      checkInDate: DateTime.parse(checkInDate),
      checkOutDate: DateTime.parse(checkOutDate),
      dropOffTime: _parseTimeOfDay(dropOffTime),
      pickUpTime: _parseTimeOfDay(pickUpTime),
      roomPriceTotal: roomPriceTotal,
      addonPriceTotal: addonPriceTotal,
      appServiceFee: appServiceFee,
      totalPrice: totalPrice,
      paymentStatus: paymentStatus,
      paymentMethod: paymentMethod,
      bookingReference: bookingReference,
      bookingStatus: bookingStatus,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
