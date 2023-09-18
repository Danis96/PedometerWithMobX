import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ljubljana/app/config/flavor_config.dart';
import 'package:ljubljana/app/models/question_model.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';
import 'package:ljubljana/app/state/location_store/location_store.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';
import 'package:ljubljana/app/state/questions_store/questions_store.dart';
import 'package:ljubljana/app/state/splash_store/splash_store.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/app/state/walking_distance_store/walking_distance_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupConfigsForTest() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues(baseUrl: 'https://fosmobileapi.azurewebsites.net/', appName: 'PedometerMobX'));
  SharedPreferences.setMockInitialValues({});
}

Widget materialApp(Widget child, {PreferredSizeWidget? appBar}) {
  return MaterialApp(home: Scaffold(appBar: appBar ?? AppBar(), body: Container(child: child)));
}

GetIt locatorTest = GetIt.instance;

void setupLocatorForTests() {
  // register stores
  locatorTest.registerFactory(() => AuthenticationStore());
  locatorTest.registerFactory(() => OnBoardingStore());
  locatorTest.registerFactory(() => QuestionsStore());
  locatorTest.registerFactory(() => UserProfileStore());
  locatorTest.registerFactory(() => WalkingDistanceStore());
  locatorTest.registerFactory(() => LanguageStore());
  locatorTest.registerFactory(() => LocationStore());
  locatorTest.registerFactory(() => PedometerStore());
  locatorTest.registerFactory(() => SplashStore());

}

const String testBaseUrl = 'https://fosmobileapi.azurewebsites.net/';

// question_store_test list
List<Question> questionsTest = <Question>[
  Question(description: 'questions.question_desc_1'.tr()),
  Question(description: 'questions.question_desc_2'.tr()),
  Question(description: 'questions.question_desc_3'.tr()),
  Question(description: 'questions.question_desc_4'.tr()),
  Question(description: 'questions.question_desc_5'.tr()),
  Question(description: 'questions.question_desc_6'.tr()),
  Question(description: 'questions.question_desc_7'.tr()),
];