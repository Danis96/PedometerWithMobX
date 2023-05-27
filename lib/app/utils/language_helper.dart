import 'package:easy_localization/easy_localization.dart';

enum AppLanguages { si, en }

extension CountryName on AppLanguages {
  String get languageName {
    switch (this) {
      case AppLanguages.en:
        return "supported_languages.english".tr();
      case AppLanguages.si:
        return "supported_languages.slovenian".tr();
    }
  }

  String get languageCode {
    switch (this) {
      case AppLanguages.en:
        return "en";
      case AppLanguages.si:
        return "si";
    }
  }

  String get countryCode {
    switch (this) {
      case AppLanguages.en:
        return "US";
      case AppLanguages.si:
        return "SI";
    }
  }
}

extension SupportedAppLanguage on String {
  AppLanguages getSupportedLanguageFromLocale() {
    if (compareTo('en') == 0) {
      return AppLanguages.en;
    }
    return AppLanguages.si;
  }

  String getCountryCode() {
    if (compareTo('si') == 0) {
      return "SI";
    }
    return "US";
  }
}
