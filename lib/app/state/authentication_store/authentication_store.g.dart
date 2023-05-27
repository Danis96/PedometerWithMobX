// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenticationStore on AuthBase, Store {
  Computed<User>? _$userComputed;

  @override
  User get user => (_$userComputed ??=
          Computed<User>(() => super.user, name: 'AuthBase.user'))
      .value;
  Computed<bool>? _$isOnBoardingFinishedComputed;

  @override
  bool get isOnBoardingFinished => (_$isOnBoardingFinishedComputed ??=
          Computed<bool>(() => super.isOnBoardingFinished,
              name: 'AuthBase.isOnBoardingFinished'))
      .value;

  late final _$_userAtom = Atom(name: 'AuthBase._user', context: context);

  @override
  User get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$agreeTermsAtom =
      Atom(name: 'AuthBase.agreeTerms', context: context);

  @override
  bool get agreeTerms {
    _$agreeTermsAtom.reportRead();
    return super.agreeTerms;
  }

  @override
  set agreeTerms(bool value) {
    _$agreeTermsAtom.reportWrite(value, super.agreeTerms, () {
      super.agreeTerms = value;
    });
  }

  late final _$userFInitialsAtom =
      Atom(name: 'AuthBase.userFInitials', context: context);

  @override
  String get userFInitials {
    _$userFInitialsAtom.reportRead();
    return super.userFInitials;
  }

  @override
  set userFInitials(String value) {
    _$userFInitialsAtom.reportWrite(value, super.userFInitials, () {
      super.userFInitials = value;
    });
  }

  late final _$userLInitialsAtom =
      Atom(name: 'AuthBase.userLInitials', context: context);

  @override
  String get userLInitials {
    _$userLInitialsAtom.reportRead();
    return super.userLInitials;
  }

  @override
  set userLInitials(String value) {
    _$userLInitialsAtom.reportWrite(value, super.userLInitials, () {
      super.userLInitials = value;
    });
  }

  late final _$municipalitiesAtom =
      Atom(name: 'AuthBase.municipalities', context: context);

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

  late final _$maleAtom = Atom(name: 'AuthBase.male', context: context);

  @override
  String get male {
    _$maleAtom.reportRead();
    return super.male;
  }

  @override
  set male(String value) {
    _$maleAtom.reportWrite(value, super.male, () {
      super.male = value;
    });
  }

  late final _$femaleAtom = Atom(name: 'AuthBase.female', context: context);

  @override
  String get female {
    _$femaleAtom.reportRead();
    return super.female;
  }

  @override
  set female(String value) {
    _$femaleAtom.reportWrite(value, super.female, () {
      super.female = value;
    });
  }

  late final _$genderAtom = Atom(name: 'AuthBase.gender', context: context);

  @override
  int get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(int value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$ageAtom = Atom(name: 'AuthBase.age', context: context);

  @override
  int get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(int value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$heightAtom = Atom(name: 'AuthBase.height', context: context);

  @override
  int get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(int value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$weightAtom = Atom(name: 'AuthBase.weight', context: context);

  @override
  int get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(int value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  late final _$emailAtom = Atom(name: 'AuthBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$genderItemsAtom =
      Atom(name: 'AuthBase.genderItems', context: context);

  @override
  List<String> get genderItems {
    _$genderItemsAtom.reportRead();
    return super.genderItems;
  }

  @override
  set genderItems(List<String> value) {
    _$genderItemsAtom.reportWrite(value, super.genderItems, () {
      super.genderItems = value;
    });
  }

  late final _$loginUserAsyncAction =
      AsyncAction('AuthBase.loginUser', context: context);

  @override
  Future<String?> loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('AuthBase.getUserData', context: context);

  @override
  Future<String?> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$createPasswordAsyncAction =
      AsyncAction('AuthBase.createPassword', context: context);

  @override
  Future<String?> createPassword() {
    return _$createPasswordAsyncAction.run(() => super.createPassword());
  }

  late final _$setEmailInSharedAsyncAction =
      AsyncAction('AuthBase.setEmailInShared', context: context);

  @override
  Future<dynamic> setEmailInShared(String email) {
    return _$setEmailInSharedAsyncAction
        .run(() => super.setEmailInShared(email));
  }

  late final _$setIsUserFinishedOnBoardingAsyncAction =
      AsyncAction('AuthBase.setIsUserFinishedOnBoarding', context: context);

  @override
  Future<dynamic> setIsUserFinishedOnBoarding() {
    return _$setIsUserFinishedOnBoardingAsyncAction
        .run(() => super.setIsUserFinishedOnBoarding());
  }

  late final _$checkEmailExistsAsyncAction =
      AsyncAction('AuthBase.checkEmailExists', context: context);

  @override
  Future<String?> checkEmailExists() {
    return _$checkEmailExistsAsyncAction.run(() => super.checkEmailExists());
  }

  late final _$getMunicipalitiesAsyncAction =
      AsyncAction('AuthBase.getMunicipalities', context: context);

  @override
  Future<String?> getMunicipalities() {
    return _$getMunicipalitiesAsyncAction.run(() => super.getMunicipalities());
  }

  late final _$filterMunicipalitiesAsyncAction =
      AsyncAction('AuthBase.filterMunicipalities', context: context);

  @override
  Future<void> filterMunicipalities(String filter) {
    return _$filterMunicipalitiesAsyncAction
        .run(() => super.filterMunicipalities(filter));
  }

  late final _$editUserDataAsyncAction =
      AsyncAction('AuthBase.editUserData', context: context);

  @override
  Future<String?> editUserData() {
    return _$editUserDataAsyncAction.run(() => super.editUserData());
  }

  late final _$setAndConvertValuesAsyncAction =
      AsyncAction('AuthBase.setAndConvertValues', context: context);

  @override
  Future<void> setAndConvertValues() {
    return _$setAndConvertValuesAsyncAction
        .run(() => super.setAndConvertValues());
  }

  late final _$changePasswordAsyncAction =
      AsyncAction('AuthBase.changePassword', context: context);

  @override
  Future<String?> changePassword() {
    return _$changePasswordAsyncAction.run(() => super.changePassword());
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthBase.logout', context: context);

  @override
  Future<String?> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$deleteProfileAsyncAction =
      AsyncAction('AuthBase.deleteProfile', context: context);

  @override
  Future<String?> deleteProfile() {
    return _$deleteProfileAsyncAction.run(() => super.deleteProfile());
  }

  late final _$generateResetCodeAsyncAction =
      AsyncAction('AuthBase.generateResetCode', context: context);

  @override
  Future<String?> generateResetCode() {
    return _$generateResetCodeAsyncAction.run(() => super.generateResetCode());
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('AuthBase.resetPassword', context: context);

  @override
  Future<String?> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  late final _$AuthBaseActionController =
      ActionController(name: 'AuthBase', context: context);

  @override
  void setUserDataToControllers() {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.setUserDataToControllers');
    try {
      return super.setUserDataToControllers();
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkAndSetGender() {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.checkAndSetGender');
    try {
      return super.checkAndSetGender();
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isProfileGenderControllerNotEmpty() {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.isProfileGenderControllerNotEmpty');
    try {
      return super.isProfileGenderControllerNotEmpty();
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgreeTerms(bool value) {
    final _$actionInfo =
        _$AuthBaseActionController.startAction(name: 'AuthBase.setAgreeTerms');
    try {
      return super.setAgreeTerms(value);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? emailValid(String text) {
    final _$actionInfo =
        _$AuthBaseActionController.startAction(name: 'AuthBase.emailValid');
    try {
      return super.emailValid(text);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? passMinCarValidation(String password) {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.passMinCarValidation');
    try {
      return super.passMinCarValidation(password);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? passConfirmValidation(
      TextEditingController t1, TextEditingController t2) {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.passConfirmValidation');
    try {
      return super.passConfirmValidation(t1, t2);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getUserInitials() {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.getUserInitials');
    try {
      return super.getUserInitials();
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void convertGenderToInt(String value) {
    final _$actionInfo = _$AuthBaseActionController.startAction(
        name: 'AuthBase.convertGenderToInt');
    try {
      return super.convertGenderToInt(value);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isOnlyNumbers(String data) {
    final _$actionInfo =
        _$AuthBaseActionController.startAction(name: 'AuthBase.isOnlyNumbers');
    try {
      return super.isOnlyNumbers(data);
    } finally {
      _$AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agreeTerms: ${agreeTerms},
userFInitials: ${userFInitials},
userLInitials: ${userLInitials},
municipalities: ${municipalities},
male: ${male},
female: ${female},
gender: ${gender},
age: ${age},
height: ${height},
weight: ${weight},
email: ${email},
genderItems: ${genderItems},
user: ${user},
isOnBoardingFinished: ${isOnBoardingFinished}
    ''';
  }
}
