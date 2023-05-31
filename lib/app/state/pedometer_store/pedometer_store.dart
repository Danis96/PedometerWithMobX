import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../repositories/distance_repo.dart';

part 'pedometer_store.g.dart';

class PedometerStore = PedometerBase with _$PedometerStore;

abstract class PedometerBase with Store {
  PedometerBase() {
    _distanceRepository = DistanceRepository();
  }

  DistanceRepository? _distanceRepository;

  @observable
  Stream<StepCount>? stepCountStream;
  @observable
  Stream<PedestrianStatus>? pedestrianStatusStream;
  @observable
  StreamSubscription? listener;
  @observable
  StreamSubscription? pedestrianListener;

  @observable
  String status = '?', steps = '0';
  @observable
  int initialSteps = 0;
  @observable
  int totalSteps = 0;
  @observable
  bool isInitial = true;
  @observable
  double measuredDistanceForSteps = 1.75;
  @observable
  double measuredStepLength = 0.414;
  @observable
  double distanceTraveled = 0.0;

  @action
  void onStepCount(StepCount event) {
    debugPrint(event.toString());
    if (isInitial) {
      initialSteps = event.steps;
      steps = '0';
      isInitial = false;
    } else {
      totalSteps = event.steps - initialSteps;
      double distance = (measuredDistanceForSteps / measuredStepLength + 0.05) * totalSteps;
      distanceTraveled = distance;
      print(distance);
      print(distance.toStringAsFixed(1));
      steps = distance.toStringAsFixed(1);
    }
  }

  @action
  void onPedestrianStatusChanged(PedestrianStatus event) {
    debugPrint(event.toString());
    status = event.status;
  }

  @action
  void onPedestrianStatusError(error) {
    debugPrint('onPedestrianStatusError: $error');
    status = 'Pedestrian Status not available';
  }

  @action
  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    steps = 'Step Count not available';
  }

  @action
  void initPlatformState() {
    pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    pedestrianListener = pedestrianStatusStream!.listen(onPedestrianStatusChanged);
    pedestrianListener!.onError(onPedestrianStatusError);
    stepCountStream = Pedometer.stepCountStream;
    listener = stepCountStream!.listen(onStepCount);
    listener!.onError(onStepCountError);
  }

  @action
  Future<void> startTracking() async {
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.isDenied) {
        final PermissionStatus status = await Permission.activityRecognition.request();
        if (status == PermissionStatus.granted) {
          initPlatformState();
        }
      } else {
        initPlatformState();
      }
    } else {
      if (await Permission.sensors.isDenied) {
        final PermissionStatus status = await Permission.sensors.request();
        if (status == PermissionStatus.granted) {
          initPlatformState();
        }
      } else {
        initPlatformState();
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

  @action
  void stopTracking() {
    listener!.cancel();
    pedestrianListener!.cancel();
  }
}
