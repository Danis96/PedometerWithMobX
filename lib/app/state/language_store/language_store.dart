import 'dart:ui';
import 'package:mobx/mobx.dart';
import '../../utils/language_helper.dart';
import '../../utils/storage_prefs_manager.dart';

part 'language_store.g.dart';

class LanguageStore = LanguageBase with _$LanguageStore;

abstract class LanguageBase with Store {

  LanguageBase() {
    storagePrefs.getLanguage().then((value) {
      currentLocale = Locale(value, value.getCountryCode());
    });
  }

  @observable
  AppLanguages appLanguage = AppLanguages.si;
  @observable
  Locale currentLocale = const Locale('si', 'SI');

  @action
  void initializeCurrentLanguage(String languageCode) {
    appLanguage = languageCode.getSupportedLanguageFromLocale();
  }

  @action
  Future<void> setLanguage(AppLanguages language) async {
    appLanguage = language;
    await storagePrefs.setLanguage(language.languageCode);
  }

  @action
  void setAppLanguage(AppLanguages value) {
    appLanguage = value;
  }

  @action
  void setCurrentLocale(Locale value) {
    currentLocale = value;
  }
}
