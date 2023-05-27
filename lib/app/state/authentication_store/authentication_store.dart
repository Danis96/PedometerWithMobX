import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/municipality_repository.dart';
import '../../repositories/user_profile_repository.dart';
import '../../utils/storage_prefs_manager.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = AuthBase with _$AuthenticationStore;

abstract class AuthBase with Store {
  AuthBase() {
    _authRepository = AuthRepository();
    _profileRepository = UserProfileRepository();
    _municipalityRepository = MunicipalityRepository();
  }

  AuthRepository? _authRepository;
  UserProfileRepository? _profileRepository;
  MunicipalityRepository? _municipalityRepository;

  // registration controllers
  final TextEditingController emailRegistrationController = TextEditingController();
  final TextEditingController passwordRegistrationController = TextEditingController();
  final TextEditingController confirmPasswordRegistrationController = TextEditingController();

  // login controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // forgot password controllers
  final TextEditingController emailFPController = TextEditingController();
  final TextEditingController codeFPController = TextEditingController();
  final TextEditingController passwordFPController = TextEditingController();
  final TextEditingController confirmPasswordFPController = TextEditingController();

  // change password controllers
  final TextEditingController oldPasswordCPController = TextEditingController();
  final TextEditingController newPasswordCPController = TextEditingController();
  final TextEditingController confirmPasswordCPController = TextEditingController();

  // user profile controllers
  final TextEditingController profileGenderController = TextEditingController();
  final TextEditingController profileFNameController = TextEditingController();
  final TextEditingController profileLNameController = TextEditingController();
  final TextEditingController profileAgeController = TextEditingController();
  final TextEditingController profileHeightController = TextEditingController();
  final TextEditingController profileWeightController = TextEditingController();
  final TextEditingController profileInfoController = TextEditingController();
  final TextEditingController profileMunicipalityController = TextEditingController();

  @observable
  User _user = User();

  @computed
  User get user => _user;

  @action
  Future<String?> loginUser() async {
    if (emailLoginController.text.isNotEmpty && passwordLoginController.text.isNotEmpty) {
      try {
        final String response = await _authRepository!.loginUser(emailLoginController.text, passwordLoginController.text);
        await storagePrefs.setValue(StoragePrefsManager.ACCESS_TOKEN, response);
        await storagePrefs.setEmailInShared(emailLoginController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  Future<String?> getUserData() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      _user = await _profileRepository!.getUserDetails(emailLoginController.text.isNotEmpty ? emailLoginController.text : email);
      await storagePrefs.setValue(StoragePrefsManager.USER_DATA_KEY, json.encode(_user.toJson()));
      await setIsUserFinishedOnBoarding();
      setUserDataToControllers();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String?> createPassword() async {
    final String email = await storagePrefs.readEmailFromShared();
    if (passwordRegistrationController.text.isNotEmpty) {
      try {
        await _authRepository!.createPassword(
            emailRegistrationController.text.isNotEmpty ? emailRegistrationController.text : email, passwordRegistrationController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  Future setEmailInShared(String email) async => await storagePrefs.setEmailInShared(email);

  @action
  Future setIsUserFinishedOnBoarding() async {
    if (_user.isOnBoardingFinished) {
      await storagePrefs.setValue(StoragePrefsManager.FINISHED_ONBOARDING, 'true');
    } else {
      await storagePrefs.setValue(StoragePrefsManager.FINISHED_ONBOARDING, 'false');
    }
  }

  @computed
  bool get isOnBoardingFinished => _user.isOnBoardingFinished;

  @action
  void setUserDataToControllers() {
    checkAndSetGender();
    profileAgeController.text = _user.age.toString();
    profileHeightController.text = _user.height.toString();
    profileWeightController.text = _user.weight.toString();
    profileInfoController.text = _user.info;
    profileFNameController.text = _user.firstName;
    profileLNameController.text = _user.lastName;
    profileMunicipalityController.text = _user.municipality;
  }

  @action
  void checkAndSetGender() {
    if (_user.gender == 0) {
      profileGenderController.text = 'gender_items.male'.tr();
    } else {
      profileGenderController.text = 'gender_items.female'.tr();
    }
  }

  @action
  bool isProfileGenderControllerNotEmpty() => profileGenderController.text.isNotEmpty;

  @observable
  bool agreeTerms = false;

  @action
  void setAgreeTerms(bool value) {
    agreeTerms = value;
  }

  @action
  Future<String?> checkEmailExists() async {
    if (emailRegistrationController.text.isNotEmpty) {
      try {
        await _authRepository!.checkEmail(emailRegistrationController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  String? emailValid(String text) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(text)) {
      return null;
    } else {
      return 'modal_helper.email_valid'.tr();
    }
  }

  @action
  String? passMinCarValidation(String password) {
    if (password.length >= 4) {
      return null;
    } else {
      return 'modal_helper.pass_length_valid'.tr();
    }
  }

  @action
  String? passConfirmValidation(TextEditingController t1, TextEditingController t2) {
    if (t2.text == t1.text) {
      return null;
    } else {
      return 'modal_helper.pass_confirm_valid'.tr();
    }
  }

  @observable
  String userFInitials = '';
  @observable
  String userLInitials = '';

  @action
  void getUserInitials() {
    if (_user.firstName.isNotEmpty) {
      userFInitials = _user.firstName.substring(0, 1);
    } else {
      userFInitials = '';
    }
    if (_user.lastName.isNotEmpty) {
      userLInitials = _user.lastName.substring(0, 1);
    } else {
      userLInitials = '';
    }
  }

  @observable
  List<String> municipalities = <String>[];

  @action
  Future<String?> getMunicipalities() async {
    municipalities.clear();
    try {
      municipalities = await _municipalityRepository!.getMunicipalities();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<void> filterMunicipalities(String filter) async {
    await getMunicipalities();
    if (municipalities.isNotEmpty) {
      if (filter.isNotEmpty) {
        final List<String> s = municipalities.where((element) => element.toLowerCase().startsWith(filter) || element.startsWith(filter)).toList();
        municipalities.clear();
        municipalities.addAll(s);
      }
    }
  }

  @observable
  String male = 'gender_items.male'.tr();
  @observable
  String female = 'gender_items.female'.tr();

  @observable
  int gender = 0;
  @observable
  int age = 0;
  @observable
  int height = 0;
  @observable
  int weight = 0;
  @observable
  String email = '';
  @observable
  List<String> genderItems = ['gender_items.male'.tr(), 'gender_items.female'.tr()];

  @action
  Future<String?> editUserData() async {
    await setAndConvertValues();
    try {
      final String email = await storagePrefs.readEmailFromShared();
      await _profileRepository!.editUserDetails(
        profileFNameController.text,
        profileLNameController.text,
        email,
        gender,
        age,
        height,
        weight,
        profileInfoController.text,
        profileMunicipalityController.text,
        true,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<void> setAndConvertValues() async {
    email = await storagePrefs.readEmailFromShared();
    convertGenderToInt(profileGenderController.text);
    age = profileAgeController.text.isNotEmpty
        ? isOnlyNumbers(profileAgeController.text)
            ? int.parse(profileAgeController.text)
            : 0
        : 0;
    height = profileHeightController.text.isNotEmpty
        ? isOnlyNumbers(profileHeightController.text)
            ? int.parse(profileHeightController.text)
            : 0
        : 0;
    weight = profileWeightController.text.isNotEmpty
        ? isOnlyNumbers(profileWeightController.text)
            ? int.parse(profileWeightController.text)
            : 0
        : 0;
  }

  @action
  void convertGenderToInt(String value) {
    if (value == male) {
      gender = 0;
    } else {
      gender = 1;
    }
  }

  @action
  bool isOnlyNumbers(String data) {
    if (data.contains('-')) {
      return false;
    } else if (data.contains('.')) {
      return false;
    } else if (data.contains(',')) {
      return false;
    } else {
      return true;
    }
  }

  @action
  Future<String?> changePassword() async {
    if (oldPasswordCPController.text.isNotEmpty && newPasswordCPController.text.isNotEmpty && confirmPasswordCPController.text.isNotEmpty) {
      try {
        final String email = await storagePrefs.readEmailFromShared();
        await _authRepository!.changePassword(email, oldPasswordCPController.text, newPasswordCPController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  Future<String?> logout() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      await _authRepository!.deleteToken(email);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await storagePrefs.deleteAll();
      await prefs.clear();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String?> deleteProfile() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      await _authRepository!.deleteAccount(email);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await storagePrefs.deleteAll();
      await prefs.clear();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String?> generateResetCode() async {
    if (emailFPController.text.isNotEmpty) {
      try {
        await _authRepository!.generateResetCode(emailFPController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  Future<String?> resetPassword() async {
    if (emailFPController.text.isNotEmpty && codeFPController.text.isNotEmpty && confirmPasswordFPController.text.isNotEmpty) {
      try {
        await _authRepository!.resetPassword(emailFPController.text, codeFPController.text, confirmPasswordFPController.text);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }
}
