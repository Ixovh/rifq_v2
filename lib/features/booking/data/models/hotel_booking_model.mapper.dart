// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_booking_model.dart';

class HotelBookingModelMapper extends ClassMapperBase<HotelBookingModel> {
  HotelBookingModelMapper._();

  static HotelBookingModelMapper? _instance;
  static HotelBookingModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelBookingModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelBookingModel';

  static String _$id(HotelBookingModel v) => v.id;
  static const Field<HotelBookingModel, String> _f$id = Field('id', _$id);
  static String _$hotelId(HotelBookingModel v) => v.hotelId;
  static const Field<HotelBookingModel, String> _f$hotelId = Field(
    'hotelId',
    _$hotelId,
    key: r'hotel_id',
  );
  static String _$petOwnerId(HotelBookingModel v) => v.petOwnerId;
  static const Field<HotelBookingModel, String> _f$petOwnerId = Field(
    'petOwnerId',
    _$petOwnerId,
    key: r'pet_owner_id',
  );
  static int _$numberOfPets(HotelBookingModel v) => v.numberOfPets;
  static const Field<HotelBookingModel, int> _f$numberOfPets = Field(
    'numberOfPets',
    _$numberOfPets,
    key: r'number_of_pets',
  );
  static String _$checkInDate(HotelBookingModel v) => v.checkInDate;
  static const Field<HotelBookingModel, String> _f$checkInDate = Field(
    'checkInDate',
    _$checkInDate,
    key: r'check_in_date',
  );
  static String _$checkOutDate(HotelBookingModel v) => v.checkOutDate;
  static const Field<HotelBookingModel, String> _f$checkOutDate = Field(
    'checkOutDate',
    _$checkOutDate,
    key: r'check_out_date',
  );
  static String _$dropOffTime(HotelBookingModel v) => v.dropOffTime;
  static const Field<HotelBookingModel, String> _f$dropOffTime = Field(
    'dropOffTime',
    _$dropOffTime,
    key: r'drop_off_time',
  );
  static String _$pickUpTime(HotelBookingModel v) => v.pickUpTime;
  static const Field<HotelBookingModel, String> _f$pickUpTime = Field(
    'pickUpTime',
    _$pickUpTime,
    key: r'pick_up_time',
  );
  static double _$roomPriceTotal(HotelBookingModel v) => v.roomPriceTotal;
  static const Field<HotelBookingModel, double> _f$roomPriceTotal = Field(
    'roomPriceTotal',
    _$roomPriceTotal,
    key: r'room_price_total',
  );
  static double _$addonPriceTotal(HotelBookingModel v) => v.addonPriceTotal;
  static const Field<HotelBookingModel, double> _f$addonPriceTotal = Field(
    'addonPriceTotal',
    _$addonPriceTotal,
    key: r'addon_price_total',
  );
  static double _$appServiceFee(HotelBookingModel v) => v.appServiceFee;
  static const Field<HotelBookingModel, double> _f$appServiceFee = Field(
    'appServiceFee',
    _$appServiceFee,
    key: r'app_service_fee',
  );
  static double _$totalPrice(HotelBookingModel v) => v.totalPrice;
  static const Field<HotelBookingModel, double> _f$totalPrice = Field(
    'totalPrice',
    _$totalPrice,
    key: r'total_price',
  );
  static String _$paymentStatus(HotelBookingModel v) => v.paymentStatus;
  static const Field<HotelBookingModel, String> _f$paymentStatus = Field(
    'paymentStatus',
    _$paymentStatus,
    key: r'payment_status',
  );
  static String _$paymentMethod(HotelBookingModel v) => v.paymentMethod;
  static const Field<HotelBookingModel, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
    key: r'payment_method',
  );
  static String _$bookingReference(HotelBookingModel v) => v.bookingReference;
  static const Field<HotelBookingModel, String> _f$bookingReference = Field(
    'bookingReference',
    _$bookingReference,
    key: r'booking_reference',
  );
  static String _$bookingStatus(HotelBookingModel v) => v.bookingStatus;
  static const Field<HotelBookingModel, String> _f$bookingStatus = Field(
    'bookingStatus',
    _$bookingStatus,
    key: r'booking_status',
  );
  static String _$createdAt(HotelBookingModel v) => v.createdAt;
  static const Field<HotelBookingModel, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<HotelBookingModel> fields = const {
    #id: _f$id,
    #hotelId: _f$hotelId,
    #petOwnerId: _f$petOwnerId,
    #numberOfPets: _f$numberOfPets,
    #checkInDate: _f$checkInDate,
    #checkOutDate: _f$checkOutDate,
    #dropOffTime: _f$dropOffTime,
    #pickUpTime: _f$pickUpTime,
    #roomPriceTotal: _f$roomPriceTotal,
    #addonPriceTotal: _f$addonPriceTotal,
    #appServiceFee: _f$appServiceFee,
    #totalPrice: _f$totalPrice,
    #paymentStatus: _f$paymentStatus,
    #paymentMethod: _f$paymentMethod,
    #bookingReference: _f$bookingReference,
    #bookingStatus: _f$bookingStatus,
    #createdAt: _f$createdAt,
  };

  static HotelBookingModel _instantiate(DecodingData data) {
    return HotelBookingModel(
      id: data.dec(_f$id),
      hotelId: data.dec(_f$hotelId),
      petOwnerId: data.dec(_f$petOwnerId),
      numberOfPets: data.dec(_f$numberOfPets),
      checkInDate: data.dec(_f$checkInDate),
      checkOutDate: data.dec(_f$checkOutDate),
      dropOffTime: data.dec(_f$dropOffTime),
      pickUpTime: data.dec(_f$pickUpTime),
      roomPriceTotal: data.dec(_f$roomPriceTotal),
      addonPriceTotal: data.dec(_f$addonPriceTotal),
      appServiceFee: data.dec(_f$appServiceFee),
      totalPrice: data.dec(_f$totalPrice),
      paymentStatus: data.dec(_f$paymentStatus),
      paymentMethod: data.dec(_f$paymentMethod),
      bookingReference: data.dec(_f$bookingReference),
      bookingStatus: data.dec(_f$bookingStatus),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelBookingModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelBookingModel>(map);
  }

  static HotelBookingModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelBookingModel>(json);
  }
}

mixin HotelBookingModelMappable {
  String toJson() {
    return HotelBookingModelMapper.ensureInitialized()
        .encodeJson<HotelBookingModel>(this as HotelBookingModel);
  }

  Map<String, dynamic> toMap() {
    return HotelBookingModelMapper.ensureInitialized()
        .encodeMap<HotelBookingModel>(this as HotelBookingModel);
  }

  HotelBookingModelCopyWith<
    HotelBookingModel,
    HotelBookingModel,
    HotelBookingModel
  >
  get copyWith =>
      _HotelBookingModelCopyWithImpl<HotelBookingModel, HotelBookingModel>(
        this as HotelBookingModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelBookingModelMapper.ensureInitialized().stringifyValue(
      this as HotelBookingModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelBookingModelMapper.ensureInitialized().equalsValue(
      this as HotelBookingModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelBookingModelMapper.ensureInitialized().hashValue(
      this as HotelBookingModel,
    );
  }
}

extension HotelBookingModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelBookingModel, $Out> {
  HotelBookingModelCopyWith<$R, HotelBookingModel, $Out>
  get $asHotelBookingModel => $base.as(
    (v, t, t2) => _HotelBookingModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HotelBookingModelCopyWith<
  $R,
  $In extends HotelBookingModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? hotelId,
    String? petOwnerId,
    int? numberOfPets,
    String? checkInDate,
    String? checkOutDate,
    String? dropOffTime,
    String? pickUpTime,
    double? roomPriceTotal,
    double? addonPriceTotal,
    double? appServiceFee,
    double? totalPrice,
    String? paymentStatus,
    String? paymentMethod,
    String? bookingReference,
    String? bookingStatus,
    String? createdAt,
  });
  HotelBookingModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HotelBookingModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelBookingModel, $Out>
    implements HotelBookingModelCopyWith<$R, HotelBookingModel, $Out> {
  _HotelBookingModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelBookingModel> $mapper =
      HotelBookingModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? hotelId,
    String? petOwnerId,
    int? numberOfPets,
    String? checkInDate,
    String? checkOutDate,
    String? dropOffTime,
    String? pickUpTime,
    double? roomPriceTotal,
    double? addonPriceTotal,
    double? appServiceFee,
    double? totalPrice,
    String? paymentStatus,
    String? paymentMethod,
    String? bookingReference,
    String? bookingStatus,
    String? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (hotelId != null) #hotelId: hotelId,
      if (petOwnerId != null) #petOwnerId: petOwnerId,
      if (numberOfPets != null) #numberOfPets: numberOfPets,
      if (checkInDate != null) #checkInDate: checkInDate,
      if (checkOutDate != null) #checkOutDate: checkOutDate,
      if (dropOffTime != null) #dropOffTime: dropOffTime,
      if (pickUpTime != null) #pickUpTime: pickUpTime,
      if (roomPriceTotal != null) #roomPriceTotal: roomPriceTotal,
      if (addonPriceTotal != null) #addonPriceTotal: addonPriceTotal,
      if (appServiceFee != null) #appServiceFee: appServiceFee,
      if (totalPrice != null) #totalPrice: totalPrice,
      if (paymentStatus != null) #paymentStatus: paymentStatus,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
      if (bookingReference != null) #bookingReference: bookingReference,
      if (bookingStatus != null) #bookingStatus: bookingStatus,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  HotelBookingModel $make(CopyWithData data) => HotelBookingModel(
    id: data.get(#id, or: $value.id),
    hotelId: data.get(#hotelId, or: $value.hotelId),
    petOwnerId: data.get(#petOwnerId, or: $value.petOwnerId),
    numberOfPets: data.get(#numberOfPets, or: $value.numberOfPets),
    checkInDate: data.get(#checkInDate, or: $value.checkInDate),
    checkOutDate: data.get(#checkOutDate, or: $value.checkOutDate),
    dropOffTime: data.get(#dropOffTime, or: $value.dropOffTime),
    pickUpTime: data.get(#pickUpTime, or: $value.pickUpTime),
    roomPriceTotal: data.get(#roomPriceTotal, or: $value.roomPriceTotal),
    addonPriceTotal: data.get(#addonPriceTotal, or: $value.addonPriceTotal),
    appServiceFee: data.get(#appServiceFee, or: $value.appServiceFee),
    totalPrice: data.get(#totalPrice, or: $value.totalPrice),
    paymentStatus: data.get(#paymentStatus, or: $value.paymentStatus),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
    bookingReference: data.get(#bookingReference, or: $value.bookingReference),
    bookingStatus: data.get(#bookingStatus, or: $value.bookingStatus),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  HotelBookingModelCopyWith<$R2, HotelBookingModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelBookingModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

