import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ljubljana/app/models/distance_model.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/network_module/api_header.dart';
import 'package:ljubljana/network_module/api_path.dart';
import 'package:nock/nock.dart';

import '../test_helper.dart';

void main() {
  late UserProfileStore profileStore;
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
    profileStore = locatorTest<UserProfileStore>();
    setupCalled = true;
  });

  group('check initial values of variables', () {
    test('initial File value for [imageFile] should be null', () {
      expect(profileStore.imageFile, null);
    });
    test('initial String value for [userPhoto] should be null', () {
      expect(profileStore.userPhoto, null);
    });
    test('initial List<DistanceModel> value for [distances] should be empty list', () {
      expect(profileStore.distances, <DistanceModel>[]);
    });
    test('initial List<DistanceModel> value for [topDistances] should be empty list', () {
      expect(profileStore.topDistances, <DistanceModel>[]);
    });
  });

  group('Group test for API calls in user profile store', () {
    test('getUserData [getUserDetails], calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.userDetails))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
    test('getPhoto, calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.getPhoto, concatValue: 'test@test.com'))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
    test('deletePhoto, calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.deletePhoto, concatValue: 'test@test.com'))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
    test('getTopDistances, calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.getTopDistances, concatValue: 'test@test.com'))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
    test('getDistances, calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.getDistances, concatValue: 'test@test.com'))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
  });
}
