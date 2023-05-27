// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on LocationBase, Store {
  late final _$locationAtom =
      Atom(name: 'LocationBase.location', context: context);

  @override
  Location get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Location value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  late final _$lastLocationAtom =
      Atom(name: 'LocationBase.lastLocation', context: context);

  @override
  LocationData? get lastLocation {
    _$lastLocationAtom.reportRead();
    return super.lastLocation;
  }

  @override
  set lastLocation(LocationData? value) {
    _$lastLocationAtom.reportWrite(value, super.lastLocation, () {
      super.lastLocation = value;
    });
  }

  late final _$listenerAtom =
      Atom(name: 'LocationBase.listener', context: context);

  @override
  StreamSubscription<dynamic> get listener {
    _$listenerAtom.reportRead();
    return super.listener;
  }

  @override
  set listener(StreamSubscription<dynamic> value) {
    _$listenerAtom.reportWrite(value, super.listener, () {
      super.listener = value;
    });
  }

  late final _$trackingInProgressAtom =
      Atom(name: 'LocationBase.trackingInProgress', context: context);

  @override
  bool get trackingInProgress {
    _$trackingInProgressAtom.reportRead();
    return super.trackingInProgress;
  }

  @override
  set trackingInProgress(bool value) {
    _$trackingInProgressAtom.reportWrite(value, super.trackingInProgress, () {
      super.trackingInProgress = value;
    });
  }

  late final _$distanceTraveledAtom =
      Atom(name: 'LocationBase.distanceTraveled', context: context);

  @override
  double get distanceTraveled {
    _$distanceTraveledAtom.reportRead();
    return super.distanceTraveled;
  }

  @override
  set distanceTraveled(double value) {
    _$distanceTraveledAtom.reportWrite(value, super.distanceTraveled, () {
      super.distanceTraveled = value;
    });
  }

  late final _$horizontalAccuracyAtom =
      Atom(name: 'LocationBase.horizontalAccuracy', context: context);

  @override
  double? get horizontalAccuracy {
    _$horizontalAccuracyAtom.reportRead();
    return super.horizontalAccuracy;
  }

  @override
  set horizontalAccuracy(double? value) {
    _$horizontalAccuracyAtom.reportWrite(value, super.horizontalAccuracy, () {
      super.horizontalAccuracy = value;
    });
  }

  late final _$verticalAccuracyAtom =
      Atom(name: 'LocationBase.verticalAccuracy', context: context);

  @override
  double? get verticalAccuracy {
    _$verticalAccuracyAtom.reportRead();
    return super.verticalAccuracy;
  }

  @override
  set verticalAccuracy(double? value) {
    _$verticalAccuracyAtom.reportWrite(value, super.verticalAccuracy, () {
      super.verticalAccuracy = value;
    });
  }

  late final _$accuracyListAtom =
      Atom(name: 'LocationBase.accuracyList', context: context);

  @override
  List<LocationAccuracyModel> get accuracyList {
    _$accuracyListAtom.reportRead();
    return super.accuracyList;
  }

  @override
  set accuracyList(List<LocationAccuracyModel> value) {
    _$accuracyListAtom.reportWrite(value, super.accuracyList, () {
      super.accuracyList = value;
    });
  }

  late final _$kAtom = Atom(name: 'LocationBase.k', context: context);

  @override
  int get k {
    _$kAtom.reportRead();
    return super.k;
  }

  @override
  set k(int value) {
    _$kAtom.reportWrite(value, super.k, () {
      super.k = value;
    });
  }

  late final _$intervalAtom =
      Atom(name: 'LocationBase.interval', context: context);

  @override
  int get interval {
    _$intervalAtom.reportRead();
    return super.interval;
  }

  @override
  set interval(int value) {
    _$intervalAtom.reportWrite(value, super.interval, () {
      super.interval = value;
    });
  }

  late final _$distanceFilterAtom =
      Atom(name: 'LocationBase.distanceFilter', context: context);

  @override
  double get distanceFilter {
    _$distanceFilterAtom.reportRead();
    return super.distanceFilter;
  }

  @override
  set distanceFilter(double value) {
    _$distanceFilterAtom.reportWrite(value, super.distanceFilter, () {
      super.distanceFilter = value;
    });
  }

  late final _$checkPermissionAsyncAction =
      AsyncAction('LocationBase.checkPermission', context: context);

  @override
  Future<void> checkPermission() {
    return _$checkPermissionAsyncAction.run(() => super.checkPermission());
  }

  late final _$setUsersDistanceAsyncAction =
      AsyncAction('LocationBase.setUsersDistance', context: context);

  @override
  Future<String?> setUsersDistance(String email, int distance) {
    return _$setUsersDistanceAsyncAction
        .run(() => super.setUsersDistance(email, distance));
  }

  late final _$startLocationListenerAsyncAction =
      AsyncAction('LocationBase.startLocationListener', context: context);

  @override
  Future<void> startLocationListener() {
    return _$startLocationListenerAsyncAction
        .run(() => super.startLocationListener());
  }

  late final _$LocationBaseActionController =
      ActionController(name: 'LocationBase', context: context);

  @override
  void setInterval(int value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setInterval');
    try {
      return super.setInterval(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceFilter(double value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setDistanceFilter');
    try {
      return super.setDistanceFilter(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTracking() {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.stopTracking');
    try {
      return super.stopTracking();
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTrackingInProgress(bool value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setTrackingInProgress');
    try {
      return super.setTrackingInProgress(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceTraveled(double value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setDistanceTraveled');
    try {
      return super.setDistanceTraveled(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHorizontalAccuracy(double? value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setHorizontalAccuracy');
    try {
      return super.setHorizontalAccuracy(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVerticalAccuracy(double? value) {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.setVerticalAccuracy');
    try {
      return super.setVerticalAccuracy(value);
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementInterval() {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.incrementInterval');
    try {
      return super.incrementInterval();
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementInterval() {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.decrementInterval');
    try {
      return super.decrementInterval();
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementDistanceFilter() {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.incrementDistanceFilter');
    try {
      return super.incrementDistanceFilter();
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementDistanceFilter() {
    final _$actionInfo = _$LocationBaseActionController.startAction(
        name: 'LocationBase.decrementDistanceFilter');
    try {
      return super.decrementDistanceFilter();
    } finally {
      _$LocationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
location: ${location},
lastLocation: ${lastLocation},
listener: ${listener},
trackingInProgress: ${trackingInProgress},
distanceTraveled: ${distanceTraveled},
horizontalAccuracy: ${horizontalAccuracy},
verticalAccuracy: ${verticalAccuracy},
accuracyList: ${accuracyList},
k: ${k},
interval: ${interval},
distanceFilter: ${distanceFilter}
    ''';
  }
}
