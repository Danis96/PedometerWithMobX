import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/network_module/api_header.dart';
import 'package:ljubljana/network_module/api_path.dart';
import 'package:nock/nock.dart';

import '../test_helper.dart';

void main() {
  late OnBoardingStore onBoardingStore;
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
    onBoardingStore = locatorTest<OnBoardingStore>();
    setupCalled = true;
  });

  group('check initial values of variables', () {
    test('initial String value for [male] should be "gender_items.male.tr()"', () {
      expect(onBoardingStore.male, 'gender_items.male'.tr());
    });
    test('initial String value for [female] should be "gender_items.female.tr()"', () {
      expect(onBoardingStore.female, 'gender_items.female'.tr());
    });
    test('initial int value for [gender] should be 0', () {
      expect(onBoardingStore.gender, 0);
    });
    test('initial int value for [age] should be 0', () {
      expect(onBoardingStore.age, 0);
    });
    test('initial int value for [height] should be 0', () {
      expect(onBoardingStore.height, 0);
    });
    test('initial int value for [weight] should be 0', () {
      expect(onBoardingStore.weight, 0);
    });
    test('initial String value for [email] should be empty', () {
      expect(onBoardingStore.email, '');
    });
    test('initial List<String> value for [municipalities] should be empty', () {
      expect(onBoardingStore.municipalities, <String>[]);
    });
  });

  group('test fn [areControllersNotEmpty]', () {
    test('if every controller have value should return true', () {
      onBoardingStore.ageController.text = '1';
      onBoardingStore.heightController.text = '1';
      onBoardingStore.weightController.text = '1';
      onBoardingStore.lNameController.text = '1';
      onBoardingStore.fNameController.text = '1';
      onBoardingStore.municipalityController.text = '1';
      onBoardingStore.infoController.text = '1';
      onBoardingStore.genderController.text = '1';

      expect(onBoardingStore.areControllersNotEmpty(), true);
    });
    test('if every controller does not have value should return false', () {
      onBoardingStore.ageController.text = '1';
      onBoardingStore.heightController.text = '1';
      onBoardingStore.weightController.text = '1';
      onBoardingStore.lNameController.text = '1';
      onBoardingStore.fNameController.text = '';
      onBoardingStore.municipalityController.text = '1';
      onBoardingStore.infoController.text = '1';
      onBoardingStore.genderController.text = '1';

      expect(onBoardingStore.areControllersNotEmpty(), false);
    });
  });

  group('Group test for isOnlyNumbers fn, it should check is string data made of only numbers', () {
    test('isOnlyNumbers, for value which contains "-" return false', () async {
      const String num = '12-32';
      final bool result = onBoardingStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains "." return false', () async {
      const String num = '12.32';
      final bool result = onBoardingStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains "," return false', () async {
      const String num = '12,32';
      final bool result = onBoardingStore.isOnlyNumbers(num);
      expect(result, false);
    });
    test('isOnlyNumbers, for value which contains only numbers return true', () async {
      const String num = '1232';
      final bool result = onBoardingStore.isOnlyNumbers(num);
      expect(result, true);
    });
  });

  group('Group test for API calls in onboarding store', () {
    test('onBoarding [createUserDetails], calling api, nock used for mocking data and api call', () async {
      final dynamic object = <String, dynamic>{
        'FirstName': 'fName',
        'LastName': 'lName',
        'Email': 'email',
        'Gender': 'gender',
        'Age': 'age',
        'Height': 'height',
        'Weight': 'weight',
        'Info': 'info',
        'Municipality': 'municipality',
        'IsOnboardingFinished': 'onBoardingFinished',
      };
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.createUserDetails), object)..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
    test('getMunicipalities , calling api, nock used for mocking data and api call', () async {
      final dynamic response = <String, String>{'success': 'success'};
      final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
      final interceptor = nock.get(ApiPathHelper.getValue(ApiPath.getMunicipalities))..reply(200, response, headers: header);
      expect(interceptor.isDone, false);
      expect(interceptor.body, response);
      expect(interceptor.statusCode, 200);
    });
  });

  group('Group test for convertGenderToInt fn, it should convert text value to corresponding int value', () {
    test('convertGenderToInt, for value male it should set gender to 0', () async {
      onBoardingStore.gender = -1;
      onBoardingStore.convertGenderToInt('gender_items.male'.tr());
      expect(onBoardingStore.gender, 0);
    });
    test('convertGenderToInt, for value female it should set gender to 1', () async {
      onBoardingStore.gender = -1;
      onBoardingStore.convertGenderToInt('gender_items.female'.tr());
      expect(onBoardingStore.gender, 1);
    });
  });

  test('test [setAndConvertValues] from controllers to corresponding data', () {
      onBoardingStore.genderController.text = 'Female';
      onBoardingStore.ageController.text = '27';
      onBoardingStore.heightController.text = '187';
      onBoardingStore.weightController.text = '82';
      onBoardingStore.setAndConvertValues(shouldCallStorage: false);
      expect(onBoardingStore.gender, 1);
      expect(onBoardingStore.age, 27);
      expect(onBoardingStore.height, 187);
      expect(onBoardingStore.weight, 82);
  });

}
