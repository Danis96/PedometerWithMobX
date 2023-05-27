// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistanceModel _$DistanceModelFromJson(Map<String, dynamic> json) =>
    DistanceModel(
      id: json['Id'] as int? ?? 0,
      email: json['Email'] as String? ?? '',
      distance: json['Distance'] as int? ?? 0,
      createdDate: json['CreatedDate'] as String? ?? '',
    );

Map<String, dynamic> _$DistanceModelToJson(DistanceModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Email': instance.email,
      'CreatedDate': instance.createdDate,
      'Distance': instance.distance,
    };
