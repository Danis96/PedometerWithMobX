import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/municipality_repository.dart';
import '../../repositories/onboarding_repository.dart';
import '../../utils/storage_prefs_manager.dart';

part 'onboarding_store.g.dart';

class OnBoardingStore = OnBoardingBase with _$OnBoardingStore;

abstract class OnBoardingBase with Store {
  OnBoardingBase() {
    _boardingRepository = OnBoardingRepository();
    _municipalityRepository = MunicipalityRepository();
  }

  OnBoardingRepository? _boardingRepository;
  MunicipalityRepository? _municipalityRepository;

  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController municipalityController = TextEditingController();

  String male = 'gender_items.male'.tr();
  String female = 'gender_items.female'.tr();

  int gender = 0;
  int age = 0;
  int height = 0;
  int weight = 0;
  String email = '';
  List<String> genderItems = ['gender_items.male'.tr(), 'gender_items.female'.tr()];

  bool areControllersNotEmpty() =>
      fNameController.text.isNotEmpty &&
      lNameController.text.isNotEmpty &&
      genderController.text.isNotEmpty &&
      ageController.text.isNotEmpty &&
      heightController.text.isNotEmpty &&
      weightController.text.isNotEmpty &&
      municipalityController.text.isNotEmpty;

  @action
  Future<String?> onBoarding() async {
    if (areControllersNotEmpty()) {
      await setAndConvertValues();
      try {
        await _boardingRepository!.createUserDetails(
            fNameController.text, lNameController.text, email, gender, age, height, weight, infoController.text, municipalityController.text, true);
        return null;
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'registration_password.empty'.tr();
    }
  }

  @action
  Future<void> setAndConvertValues({bool shouldCallStorage = true}) async {
    if(shouldCallStorage) {
      email = await storagePrefs.readEmailFromShared();
    }
    convertGenderToInt(genderController.text);
    age = ageController.text.isNotEmpty
        ? isOnlyNumbers(ageController.text)
            ? int.parse(ageController.text)
            : 0
        : 0;
    height = heightController.text.isNotEmpty
        ? isOnlyNumbers(heightController.text)
            ? int.parse(heightController.text)
            : 0
        : 0;
    weight = weightController.text.isNotEmpty
        ? isOnlyNumbers(weightController.text)
            ? int.parse(weightController.text)
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
}
