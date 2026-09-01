// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'boarding_request_model.dart';

class BoardingRequestModelMapper extends ClassMapperBase<BoardingRequestModel> {
  BoardingRequestModelMapper._();

  static BoardingRequestModelMapper? _instance;
  static BoardingRequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardingRequestModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BoardingRequestModel';

  static String _$id(BoardingRequestModel v) => v.id;
  static const Field<BoardingRequestModel, String> _f$id = Field('id', _$id);
  static String _$sitterId(BoardingRequestModel v) => v.sitterId;
  static const Field<BoardingRequestModel, String> _f$sitterId = Field(
    'sitterId',
    _$sitterId,
    key: r'sitter_id',
  );
  static String _$requesterId(BoardingRequestModel v) => v.requesterId;
  static const Field<BoardingRequestModel, String> _f$requesterId = Field(
    'requesterId',
    _$requesterId,
    key: r'requester_id',
  );
  static String _$status(BoardingRequestModel v) => v.status;
  static const Field<BoardingRequestModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static String? _$message(BoardingRequestModel v) => v.message;
  static const Field<BoardingRequestModel, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static DateTime _$createdAt(BoardingRequestModel v) => v.createdAt;
  static const Field<BoardingRequestModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );
  static DateTime _$updatedAt(BoardingRequestModel v) => v.updatedAt;
  static const Field<BoardingRequestModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    key: r'updated_at',
  );

  @override
  final MappableFields<BoardingRequestModel> fields = const {
    #id: _f$id,
    #sitterId: _f$sitterId,
    #requesterId: _f$requesterId,
    #status: _f$status,
    #message: _f$message,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static BoardingRequestModel _instantiate(DecodingData data) {
    return BoardingRequestModel(
      id: data.dec(_f$id),
      sitterId: data.dec(_f$sitterId),
      requesterId: data.dec(_f$requesterId),
      status: data.dec(_f$status),
      message: data.dec(_f$message),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BoardingRequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardingRequestModel>(map);
  }

  static BoardingRequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<BoardingRequestModel>(json);
  }
}

mixin BoardingRequestModelMappable {
  String toJson() {
    return BoardingRequestModelMapper.ensureInitialized()
        .encodeJson<BoardingRequestModel>(this as BoardingRequestModel);
  }

  Map<String, dynamic> toMap() {
    return BoardingRequestModelMapper.ensureInitialized()
        .encodeMap<BoardingRequestModel>(this as BoardingRequestModel);
  }

  BoardingRequestModelCopyWith<
    BoardingRequestModel,
    BoardingRequestModel,
    BoardingRequestModel
  >
  get copyWith =>
      _BoardingRequestModelCopyWithImpl<
        BoardingRequestModel,
        BoardingRequestModel
      >(this as BoardingRequestModel, $identity, $identity);
  @override
  String toString() {
    return BoardingRequestModelMapper.ensureInitialized().stringifyValue(
      this as BoardingRequestModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardingRequestModelMapper.ensureInitialized().equalsValue(
      this as BoardingRequestModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardingRequestModelMapper.ensureInitialized().hashValue(
      this as BoardingRequestModel,
    );
  }
}

extension BoardingRequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardingRequestModel, $Out> {
  BoardingRequestModelCopyWith<$R, BoardingRequestModel, $Out>
  get $asBoardingRequestModel => $base.as(
    (v, t, t2) => _BoardingRequestModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BoardingRequestModelCopyWith<
  $R,
  $In extends BoardingRequestModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? sitterId,
    String? requesterId,
    String? status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  BoardingRequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BoardingRequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardingRequestModel, $Out>
    implements BoardingRequestModelCopyWith<$R, BoardingRequestModel, $Out> {
  _BoardingRequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardingRequestModel> $mapper =
      BoardingRequestModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? sitterId,
    String? requesterId,
    String? status,
    Object? message = $none,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (sitterId != null) #sitterId: sitterId,
      if (requesterId != null) #requesterId: requesterId,
      if (status != null) #status: status,
      if (message != $none) #message: message,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  BoardingRequestModel $make(CopyWithData data) => BoardingRequestModel(
    id: data.get(#id, or: $value.id),
    sitterId: data.get(#sitterId, or: $value.sitterId),
    requesterId: data.get(#requesterId, or: $value.requesterId),
    status: data.get(#status, or: $value.status),
    message: data.get(#message, or: $value.message),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  BoardingRequestModelCopyWith<$R2, BoardingRequestModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BoardingRequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

