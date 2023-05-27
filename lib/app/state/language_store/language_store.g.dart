// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageStore on LanguageBase, Store {
  late final _$appLanguageAtom =
      Atom(name: 'LanguageBase.appLanguage', context: context);

  @override
  AppLanguages get appLanguage {
    _$appLanguageAtom.reportRead();
    return super.appLanguage;
  }

  @override
  set appLanguage(AppLanguages value) {
    _$appLanguageAtom.reportWrite(value, super.appLanguage, () {
      super.appLanguage = value;
    });
  }

  late final _$currentLocaleAtom =
      Atom(name: 'LanguageBase.currentLocale', context: context);

  @override
  Locale get currentLocale {
    _$currentLocaleAtom.reportRead();
    return super.currentLocale;
  }

  @override
  set currentLocale(Locale value) {
    _$currentLocaleAtom.reportWrite(value, super.currentLocale, () {
      super.currentLocale = value;
    });
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('LanguageBase.setLanguage', context: context);

  @override
  Future<void> setLanguage(AppLanguages language) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(language));
  }

  late final _$LanguageBaseActionController =
      ActionController(name: 'LanguageBase', context: context);

  @override
  void initializeCurrentLanguage(String languageCode) {
    final _$actionInfo = _$LanguageBaseActionController.startAction(
        name: 'LanguageBase.initializeCurrentLanguage');
    try {
      return super.initializeCurrentLanguage(languageCode);
    } finally {
      _$LanguageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAppLanguage(AppLanguages value) {
    final _$actionInfo = _$LanguageBaseActionController.startAction(
        name: 'LanguageBase.setAppLanguage');
    try {
      return super.setAppLanguage(value);
    } finally {
      _$LanguageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentLocale(Locale value) {
    final _$actionInfo = _$LanguageBaseActionController.startAction(
        name: 'LanguageBase.setCurrentLocale');
    try {
      return super.setCurrentLocale(value);
    } finally {
      _$LanguageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appLanguage: ${appLanguage},
currentLocale: ${currentLocale}
    ''';
  }
}
