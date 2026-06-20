// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdoptionModel _$AdoptionModelFromJson(Map<String, dynamic> json) =>
    _AdoptionModel(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$AdoptionModelToJson(_AdoptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
