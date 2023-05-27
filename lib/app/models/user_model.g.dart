// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      height: json['Height'] as int? ?? 0,
      gender: json['Gender'] as int? ?? 0,
      email: json['Email'] as String? ?? '',
      info: json['Info'] as String? ?? '',
      weight: json['Weight'] as int? ?? 0,
      age: json['Age'] as int? ?? 0,
      firstName: json['FirstName'] as String? ?? '',
      municipality: json['Municipality'] as String? ?? '',
      isOnBoardingFinished: json['IsOnboardingFinished'] as bool? ?? false,
      lastName: json['LastName'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'Email': instance.email,
      'Municipality': instance.municipality,
      'Info': instance.info,
      'Gender': instance.gender,
      'Age': instance.age,
      'Weight': instance.weight,
      'Height': instance.height,
      'IsOnboardingFinished': instance.isOnBoardingFinished,
    };
