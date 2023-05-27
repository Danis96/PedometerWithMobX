import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  User({
    this.height = 0,
    this.gender = 0,
    this.email = '',
    this.info = '',
    this.weight = 0,
    this.age = 0,
    this.firstName = '',
    this.municipality = '',
    this.isOnBoardingFinished = false,
    this.lastName = '',
  });

  factory User.fromJson(dynamic json) => _$UserFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: 'FirstName', defaultValue: '')
  String firstName;
  @JsonKey(name: 'LastName', defaultValue: '')
  String lastName;
  @JsonKey(name: 'Email', defaultValue: '')
  String email;
  @JsonKey(name: 'Municipality', defaultValue: '')
  String municipality;
  @JsonKey(name: 'Info', defaultValue: '')
  String info;
  @JsonKey(name: 'Gender', defaultValue: 0)
  int gender;
  @JsonKey(name: 'Age', defaultValue: 0)
  int age;
  @JsonKey(name: 'Weight', defaultValue: 0)
  int weight;
  @JsonKey(name: 'Height', defaultValue: 0)
  int height;
  @JsonKey(name: 'IsOnboardingFinished', defaultValue: false)
  bool isOnBoardingFinished;
}
