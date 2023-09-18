import 'package:flutter/material.dart';
import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class AuthRepository {
  Future<void> createPassword(String email, String password) async {
    final dynamic object = <String, String>{'Email': email, 'Password': password};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.createPassword), header, body: object);
  }

  Future<void> checkEmail(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.checkEmail, concatValue: email), header);
  }

  Future<void> deleteToken(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    await HTTPClient.instance.deleteData(ApiPathHelper.getValue(ApiPath.deleteToken, concatValue: email), header);
  }

  Future<String> loginUser(String email, String password) async {
    final dynamic object = <String, String>{'email': email, 'password': password};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.loginUser), header, body: object);
    String tokenReturn = '';
    if (response != null) {
      tokenReturn = response['success']['token'];
    }
    return tokenReturn;
  }

  Future<void> generateResetCode(String email) async {
    final dynamic object = <String, String>{'Email': email};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.resetCode), header, body: object);
  }

  Future<void> resetPassword(String email, String code, String newPassword) async {
    final dynamic object = <String, String>{'Email': email, "Code": code, "NewPassword": newPassword};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.resetPassword), header, body: object);
  }

  Future<void> changePassword(String email, String oldPassword, String newPassword) async {
    final dynamic object = <String, String>{'Email': email, "OldPassword": oldPassword, "NewPassword": newPassword};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.changePassword), header, body: object);
  }

  Future<void> deleteAccount(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.deleteData(ApiPathHelper.getValue(ApiPath.deleteProfile, concatValue: email), header);
  }
}
