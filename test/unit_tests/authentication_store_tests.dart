import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/network_module/api_header.dart';
import 'package:ljubljana/network_module/api_path.dart';
import 'package:nock/nock.dart';

import '../test_helper.dart';

void main() {
  late AuthenticationStore authStore;
  bool setupCalled = false;

  setUpAll(() {
    nock.init();
    nock.defaultBase = testBaseUrl;
  });

  setUp(() async {
    nock.cleanAll();
    if (!setupCalled) {
      setupLocatorForTests();
    }
    authStore = locatorTest<AuthenticationStore>();
    setupCalled = true;
  });

  group('Group test for passMinCarValidation fn, it should validate password for >= 4 characters', () {
    test('passMinCarValidation, for 4 or more characters it will return null', () async {
      const String password = 'Danis';
      String? result = authStore.passMinCarValidation(password);
      expect(result, null);
    });
    test('passMinCarValidation, for less than 4 characters it will return error text', () async {
      const String password = 'Dan';
      String? result = authStore.passMinCarValidation(password);
      expect(result, 'modal_helper.pass_length_valid'.tr());
    });
  });

  group('Group test for emailValid fn, it should validate email by regex', () {
    test('emailValid, for correct regex email it will return null', () async {
      const String password = 'danis.preldzic@gmail.com';
      String? result = authStore.emailValid(password);
      expect(result, null);
    });
    test('emailValid, for incorrect regex email it will return  error text', () async {
      const String password = 'danis.m';
      String? result = authStore.emailValid(password);
      expect(result, 'modal_helper.email_valid'.tr());
    });
  });

  group('Group test for passConfirmValidation fn, it should compare controllers text', () {
    test('passConfirmValidation, for same text it should return null', () async {
      TextEditingController t1 = TextEditingController();
      TextEditingController t2 = TextEditingController();
      t1.text = 'Danis';
      t2.text = 'Danis';
      String? result = authStore.passConfirmValidation(t1, t2);
      expect(result, null);
    });
    test('passConfirmValidation, for different text it should return error text', () async {
      TextEditingController t1 = TextEditingController();
      TextEditingController t2 = TextEditingController();
      t1.text = 'Danis';
      t2.text = 'Dan';
      String? result = authStore.passConfirmValidation(t1, t2);
      expect(result, 'modal_helper.pass_confirm_valid'.tr());
    });
  });

  group('Group test for convertGenderToInt fn, it should convert text value to corresponding int value', () {
    test('convertGenderToInt, for value male it should set gender to 0', () async {
      authStore.gender = -1;
      authStore.convertGenderToInt('gender_items.male'.tr());
      expect(authStore.gender, 0);
    });
    test('convertGenderToInt, for value female it should set gender to 1', () async {
      authStore.gender = -1;
      authStore.convertGenderToInt('gender_items.female'.tr());
      expect(authStore.gender, 1);
    });
  });

  group('Group test for isOnlyNumbers fn, it should check is string data made of only numbers', () {
    test('isOnlyNumbers, for value which contains "-" return false', () async {
      const String num = '12-32';
      final bool result = authStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains "." return false', () async {
      const String num = '12.32';
      final bool result = authStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains "," return false', () async {
      const String num = '12,32';
      final bool result = authStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains only numbers return true', () async {
      const String num = '1232';
      final bool result = authStore.isOnlyNumbers(num);
      expect(result, true);
    });
  });

  test('loginUser, log user calling api, nock used for mocking data and api call', () async {
    final dynamic object = <String, String>{'email': 'test@test.com', 'password': 'password'};
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.loginUser), object)..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('checkEmail calling api, nock used for mocking data and api call', () async {
    const String email = 'test@test.com';
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.checkEmail, concatValue: email))..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('deleteToken calling api, nock used for mocking data and api call', () async {
    const String email = 'test@test.com';
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.delete(ApiPathHelper.getValue(ApiPath.deleteToken, concatValue: email))..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('generateResetCode, nock used for mocking data and api call', () async {
    final dynamic object = <String, String>{'Email': 'test@test.com'};
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.resetCode), object)..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('resetPassword, nock used for mocking data and api call', () async {
    final dynamic object = <String, String>{'Email': 'test@test.com', "Code": '123456', "NewPassword": 'newPassword'};
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.resetPassword), object)..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('changePassword, nock used for mocking data and api call', () async {
    final dynamic object = <String, String>{'Email': 'test@test.com', "OldPassword": 'oldPassword', "NewPassword": 'newPassword'};
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.changePassword), object)..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });

  test('deleteAccount, nock used for mocking data and api call', () async {
    const String email = 'test@test.com';
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.delete(ApiPathHelper.getValue(ApiPath.deleteProfile, concatValue: email))..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });
}
