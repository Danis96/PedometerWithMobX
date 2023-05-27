import 'package:json_annotation/json_annotation.dart';

part 'distance_model.g.dart';

@JsonSerializable()
class DistanceModel {
  DistanceModel({
    this.id = 0,
    this.email = '',
    this.distance = 0,
    this.createdDate = '',
  });

  factory DistanceModel.fromJson(dynamic json) => _$DistanceModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$DistanceModelToJson(this);

  @JsonKey(name: 'Id', defaultValue: 0)
  int id;

  @JsonKey(name: 'Email', defaultValue: '')
  String email;
  @JsonKey(name: 'CreatedDate', defaultValue: '')
  String createdDate;
  @JsonKey(name: 'Distance', defaultValue: 0)
  int distance;
}
