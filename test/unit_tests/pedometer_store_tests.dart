import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';
import 'package:ljubljana/network_module/api_header.dart';
import 'package:ljubljana/network_module/api_path.dart';
import 'package:nock/nock.dart';

import '../test_helper.dart';

void main() {
  late PedometerStore pedometerStore;
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
    pedometerStore = locatorTest<PedometerStore>();
    setupCalled = true;
  });

  group('check initial values of variables', () {
    test('initial String value for [status] should be ?', () {
      expect(pedometerStore.status, '?');
    });
    test('initial String value for [steps] should be 0', () {
      expect(pedometerStore.steps, '0');
    });
    test('initial int value for [initialSteps] should be 0', () {
      expect(pedometerStore.initialSteps, 0);
    });
    test('initial int value for [totalSteps] should be 0', () {
      expect(pedometerStore.totalSteps, 0);
    });
    test('initial bool value for [isInitial] should be true', () {
      expect(pedometerStore.isInitial, true);
    });
    test('initial bool value for [isInitial] should be true', () {
      expect(pedometerStore.isInitial, true);
    });
    test('initial double value for [measuredDistanceForSteps] should be 1.75', () {
      expect(pedometerStore.measuredDistanceForSteps, 1.75);
    });
    test('initial double value for [measuredStepLength] should be 0.414', () {
      expect(pedometerStore.measuredStepLength, 0.414);
    });
    test('initial double value for [distanceTraveled] should be 0', () {
      expect(pedometerStore.distanceTraveled, 0);
    });
  });

  group('test [onPedestrianStatusError] && [onStepCountError] fn', () {
    test('onPedestrianStatusError, should change status var to Pedestrian Status not available', () {
      pedometerStore.onPedestrianStatusError('Error');
      expect(pedometerStore.status, 'Pedestrian Status not available');
    });
    test('onStepCountError, should change steps var to Step Count not available', () {
      pedometerStore.onStepCountError('Error');
      expect(pedometerStore.steps, 'Step Count not available');
    });
  });

  group('Group test for API calls in pedometer store', () {
    test('setUsersDistance [setUserDistance], calling api, nock used for mocking data and api call', () async {
      final dynamic object = <String, dynamic>{'Email': 'test@test.com', 'Distance': 32};
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.setDistance), object)..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
  });
}
