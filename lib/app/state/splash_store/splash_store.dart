import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routing/routes.dart';
import '../../locator.dart';
import '../../models/user_model.dart';
import '../../repositories/navigation_repo.dart';
import '../../repositories/user_profile_repository.dart';
import '../../utils/storage_prefs_manager.dart';
import '../authentication_store/authentication_store.dart';

part 'splash_store.g.dart';

class SplashStore = SplashBase with _$SplashStore;

abstract class SplashBase with Store {
  SplashBase() {
    onInit();
    _profileRepository = UserProfileRepository();
  }

  UserProfileRepository? _profileRepository;
  final NavigationRepo _navigationService = locator<NavigationRepo>();

  Future<void> onInit() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storagePrefs.deleteAll();
      prefs.setBool('first_run', false);
    }
    String userData = '';
    try {
      userData = await storagePrefs.getValue(StoragePrefsManager.USER_DATA_KEY);
    } on PlatformException catch (e) {
      await storagePrefs.deleteAll();
    }
    final bool logged = isUserLoggedIn(userData);
    if (logged) {
      _navigationService.navigateAndRemove(await decideNextRoute(), arguments: locator<AuthenticationStore>());
    } else {
      _navigationService.navigateAndRemove(welcomeScreen);
    }
  }

  bool isUserLoggedIn(String userData) {
    return userData != '';
  }

  Future<String> decideNextRoute() async {
    final String email = await storagePrefs.readEmailFromShared();
    User _user = await _profileRepository!.getUserDetails(email);

    if (_user.isOnBoardingFinished) {
      return homeScreen;
    } else {
      return onBoardingScreen;
    }
  }
}
