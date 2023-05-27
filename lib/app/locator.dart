import 'package:get_it/get_it.dart';
import 'package:ljubljana/app/repositories/navigation_repo.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';
import 'package:ljubljana/app/state/location_store/location_store.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';
import 'package:ljubljana/app/state/questions_store/questions_store.dart';
import 'package:ljubljana/app/state/splash_store/splash_store.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/app/state/walking_distance_store/walking_distance_store.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationRepo());
  // register stores
  locator.registerFactory(() => AuthenticationStore());
  locator.registerFactory(() => OnBoardingStore());
  locator.registerFactory(() => QuestionsStore());
  locator.registerFactory(() => UserProfileStore());
  locator.registerFactory(() => WalkingDistanceStore());
  locator.registerFactory(() => LanguageStore());
  locator.registerFactory(() => LocationStore());
  locator.registerFactory(() => PedometerStore());
  locator.registerFactory(() => SplashStore());
}
