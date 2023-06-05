import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ljubljana/app/config/flavor_config.dart';
import 'package:ljubljana/app/utils/storage_prefs_manager.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';
import 'package:ljubljana/app/state/location_store/location_store.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';
import 'package:ljubljana/app/state/questions_store/questions_store.dart';
import 'package:ljubljana/app/state/splash_store/splash_store.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/app/state/walking_distance_store/walking_distance_store.dart';

Future<void> setupConfigsForTest() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues(baseUrl: 'https://fosmobileapi.azurewebsites.net/', appName: 'PedometerMobX'));
  // await storagePrefs.init();
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