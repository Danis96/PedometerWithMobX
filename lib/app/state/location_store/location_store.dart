import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/distance_repo.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

part 'location_store.g.dart';

class LocationStore = LocationBase with _$LocationStore;

abstract class LocationBase with Store {
  LocationBase() {
    _distanceRepository = DistanceRepository();
  }

  DistanceRepository? _distanceRepository;

  @observable
  Location location = Location();
  @observable
  LocationData? lastLocation;

  @observable
  late StreamSubscription listener;
  @observable
  bool trackingInProgress = false;
  @observable
  double distanceTraveled = 0.0;

  @observable
  double? horizontalAccuracy;
  @observable
  double? verticalAccuracy;

  @observable
  List<LocationAccuracyModel> accuracyList = [];

  @action
  Future<void> checkPermission() async {
    final PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.granted) {
      startLocationListener();
    } else {
      final PermissionStatus newStatus = await location.requestPermission();
      if (newStatus == PermissionStatus.granted) {
        startLocationListener();
      }
    }
  }

  @action
  Future<String?> setUsersDistance(String email, int distance) async {
    try {
      await _distanceRepository!.setUserDistance(email, distance);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @observable
  int k = 1;

  @observable
  int interval = 1000;
  @observable
  double distanceFilter = 2;

  @action
  void setInterval(int value) {
    interval = value;
  }

  @action
  void setDistanceFilter(double value) {
    distanceFilter = value;
  }

  @action
  Future<void> startLocationListener() async {
    trackingInProgress = true;
    lastLocation = null;

    await location.changeSettings(accuracy: LocationAccuracy.high, interval: interval, distanceFilter: distanceFilter);

    listener = location.onLocationChanged.listen((LocationData locationData) {
      lastLocation ??= locationData;

      final double newDistance =
          geolocator.Geolocator.distanceBetween(locationData.latitude!, locationData.longitude!, lastLocation!.latitude!, lastLocation!.longitude!);
      accuracyList.add(
          LocationAccuracyModel(verticalAccuracy: locationData.verticalAccuracy, horizontalAccuracy: locationData.accuracy, distance: newDistance));

      if (k > 4 &&
          locationData.accuracy != null &&
          locationData.accuracy! <= 8 &&
          locationData.accuracy! >= 0 &&
          newDistance > 1.5 &&
          newDistance < 8) {
        distanceTraveled += newDistance;
        print(newDistance);
        print('acc ${locationData.accuracy}');
      }
      k++;
      lastLocation = locationData;
    });
  }

  @action
  void stopTracking() {
    trackingInProgress = false;
    listener.cancel();
  }

  @action
  void setTrackingInProgress(bool value) {
    trackingInProgress = value;
  }

  @action
  void setDistanceTraveled(double value) {
    distanceTraveled = value;
  }

  @action
  void setHorizontalAccuracy(double? value) {
    horizontalAccuracy = value;
  }

  @action
  void setVerticalAccuracy(double? value) {
    verticalAccuracy = value;
  }

  @action
  void incrementInterval() {
    interval += 1000;
  }

  @action
  void decrementInterval() {
    interval -= 1000;
  }

  @action
  void incrementDistanceFilter() {
    distanceFilter += 1;
  }

  @action
  void decrementDistanceFilter() {
    distanceFilter -= 1;
  }
}

@immutable
class LocationAccuracyModel {
  const LocationAccuracyModel({required this.verticalAccuracy, required this.horizontalAccuracy, required this.distance});

  final double? verticalAccuracy;
  final double? horizontalAccuracy;
  final double distance;

  String get verticalConvert {
    return verticalAccuracy == null ? "UNKNOWN" : verticalAccuracy!.toStringAsFixed(2);
  }

  String get horizontalConvert {
    return horizontalAccuracy == null ? "UNKNOWN" : horizontalAccuracy!.toStringAsFixed(2);
  }
}
