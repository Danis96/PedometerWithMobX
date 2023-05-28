// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileStore on UserProfileBase, Store {
  late final _$imageFileAtom =
      Atom(name: 'UserProfileBase.imageFile', context: context);

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  late final _$userPhotoAtom =
      Atom(name: 'UserProfileBase.userPhoto', context: context);

  @override
  String? get userPhoto {
    _$userPhotoAtom.reportRead();
    return super.userPhoto;
  }

  @override
  set userPhoto(String? value) {
    _$userPhotoAtom.reportWrite(value, super.userPhoto, () {
      super.userPhoto = value;
    });
  }

  late final _$distancesAtom =
      Atom(name: 'UserProfileBase.distances', context: context);

  @override
  List<DistanceModel> get distances {
    _$distancesAtom.reportRead();
    return super.distances;
  }

  @override
  set distances(List<DistanceModel> value) {
    _$distancesAtom.reportWrite(value, super.distances, () {
      super.distances = value;
    });
  }

  late final _$topDistancesAtom =
      Atom(name: 'UserProfileBase.topDistances', context: context);

  @override
  List<DistanceModel> get topDistances {
    _$topDistancesAtom.reportRead();
    return super.topDistances;
  }

  @override
  set topDistances(List<DistanceModel> value) {
    _$topDistancesAtom.reportWrite(value, super.topDistances, () {
      super.topDistances = value;
    });
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('UserProfileBase.getUserData', context: context);

  @override
  Future<String?> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$uploadImageAsyncAction =
      AsyncAction('UserProfileBase.uploadImage', context: context);

  @override
  Future<String?> uploadImage(BuildContext context) {
    return _$uploadImageAsyncAction.run(() => super.uploadImage(context));
  }

  late final _$getPhotoAsyncAction =
      AsyncAction('UserProfileBase.getPhoto', context: context);

  @override
  Future<String?> getPhoto() {
    return _$getPhotoAsyncAction.run(() => super.getPhoto());
  }

  late final _$deletePhotoAsyncAction =
      AsyncAction('UserProfileBase.deletePhoto', context: context);

  @override
  Future<String?> deletePhoto(BuildContext context) {
    return _$deletePhotoAsyncAction.run(() => super.deletePhoto(context));
  }

  late final _$getTopDistancesAsyncAction =
      AsyncAction('UserProfileBase.getTopDistances', context: context);

  @override
  Future<String?> getTopDistances(String email) {
    return _$getTopDistancesAsyncAction.run(() => super.getTopDistances(email));
  }

  late final _$fetchDBTopDistanceAsyncAction =
      AsyncAction('UserProfileBase.fetchDBTopDistance', context: context);

  @override
  Future<String?> fetchDBTopDistance(String email) {
    return _$fetchDBTopDistanceAsyncAction
        .run(() => super.fetchDBTopDistance(email));
  }

  late final _$insertTopDistanceIntoDBAsyncAction =
      AsyncAction('UserProfileBase.insertTopDistanceIntoDB', context: context);

  @override
  Future<void> insertTopDistanceIntoDB(List<DistanceModel> models) {
    return _$insertTopDistanceIntoDBAsyncAction
        .run(() => super.insertTopDistanceIntoDB(models));
  }

  late final _$getDistancesAsyncAction =
      AsyncAction('UserProfileBase.getDistances', context: context);

  @override
  Future<String?> getDistances(String email) {
    return _$getDistancesAsyncAction.run(() => super.getDistances(email));
  }

  late final _$fetchDBDistanceAsyncAction =
      AsyncAction('UserProfileBase.fetchDBDistance', context: context);

  @override
  Future<String?> fetchDBDistance(String email) {
    return _$fetchDBDistanceAsyncAction.run(() => super.fetchDBDistance(email));
  }

  late final _$insertDistanceIntoDBAsyncAction =
      AsyncAction('UserProfileBase.insertDistanceIntoDB', context: context);

  @override
  Future<void> insertDistanceIntoDB(List<DistanceModel> models) {
    return _$insertDistanceIntoDBAsyncAction
        .run(() => super.insertDistanceIntoDB(models));
  }

  @override
  String toString() {
    return '''
imageFile: ${imageFile},
userPhoto: ${userPhoto},
distances: ${distances},
topDistances: ${topDistances}
    ''';
  }
}
