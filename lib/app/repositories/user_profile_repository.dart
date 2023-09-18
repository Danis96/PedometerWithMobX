import 'dart:io';
import 'dart:typed_data';

import 'package:ljubljana/app/models/user_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class UserProfileRepository {


  Future<User> getUserDetails(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.userDetails, concatValue: email), header);
    User user = User();
    if (response != null) {
      user = User.fromJson(response['success']['details']);
    }
    return user;
  }

  Future<void> editUserDetails(String fName, String lName, String email, int gender, int age, int height, int weight, String info,
      String municipality, bool onBoardingFinished) async {
    final dynamic object = <String, dynamic>{
      'FirstName': fName,
      'LastName': lName,
      'Email': email,
      'Gender': gender,
      'Age': age,
      'Height': height,
      'Weight': weight,
      'Info': info,
      'Municipality': municipality,
      'IsOnboardingFinished': onBoardingFinished
    };
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.editProfile), header, body: object);
  }

  Future<String> getPhoto(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.getPhoto, concatValue: email), header);
    final String photoUrl = response['success']['image'];
    print('object');
    return photoUrl;
  }

  Future<void> deletePhoto(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.deleteData(ApiPathHelper.getValue(ApiPath.deletePhoto, concatValue: email), header);
    print('object');
  }

  Future<void> uploadPhoto(File file, String email) async {
    final dynamic object = <String, String>{
      'email': email,
    };
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postMultipartData(ApiPathHelper.getValue(ApiPath.uploadPhoto), object, header, file);
    print('object');
  }
}
