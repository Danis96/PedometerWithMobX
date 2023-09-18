// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnBoardingStore on OnBoardingBase, Store {
  late final _$municipalitiesAtom =
      Atom(name: 'OnBoardingBase.municipalities', context: context);

  @override
  List<String> get municipalities {
    _$municipalitiesAtom.reportRead();
    return super.municipalities;
  }

  @override
  set municipalities(List<String> value) {
    _$municipalitiesAtom.reportWrite(value, super.municipalities, () {
      super.municipalities = value;
    });
  }

  late final _$onBoardingAsyncAction =
      AsyncAction('OnBoardingBase.onBoarding', context: context);

  @override
  Future<String?> onBoarding() {
    return _$onBoardingAsyncAction.run(() => super.onBoarding());
  }

  late final _$setAndConvertValuesAsyncAction =
      AsyncAction('OnBoardingBase.setAndConvertValues', context: context);

  @override
  Future<void> setAndConvertValues({bool shouldCallStorage = true}) {
    return _$setAndConvertValuesAsyncAction.run(
        () => super.setAndConvertValues(shouldCallStorage: shouldCallStorage));
  }

  late final _$getMunicipalitiesAsyncAction =
      AsyncAction('OnBoardingBase.getMunicipalities', context: context);

  @override
  Future<String?> getMunicipalities() {
    return _$getMunicipalitiesAsyncAction.run(() => super.getMunicipalities());
  }

  late final _$filterMunicipalitiesAsyncAction =
      AsyncAction('OnBoardingBase.filterMunicipalities', context: context);

  @override
  Future<void> filterMunicipalities(String filter) {
    return _$filterMunicipalitiesAsyncAction
        .run(() => super.filterMunicipalities(filter));
  }

  late final _$OnBoardingBaseActionController =
      ActionController(name: 'OnBoardingBase', context: context);

  @override
  void convertGenderToInt(String value) {
    final _$actionInfo = _$OnBoardingBaseActionController.startAction(
        name: 'OnBoardingBase.convertGenderToInt');
    try {
      return super.convertGenderToInt(value);
    } finally {
      _$OnBoardingBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isOnlyNumbers(String data) {
    final _$actionInfo = _$OnBoardingBaseActionController.startAction(
        name: 'OnBoardingBase.isOnlyNumbers');
    try {
      return super.isOnlyNumbers(data);
    } finally {
      _$OnBoardingBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
municipalities: ${municipalities}
    ''';
  }
}
