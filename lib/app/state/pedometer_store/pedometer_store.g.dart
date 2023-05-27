// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedometer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PedometerStore on PedometerBase, Store {
  late final _$stepCountStreamAtom =
      Atom(name: 'PedometerBase.stepCountStream', context: context);

  @override
  Stream<StepCount> get stepCountStream {
    _$stepCountStreamAtom.reportRead();
    return super.stepCountStream;
  }

  @override
  set stepCountStream(Stream<StepCount> value) {
    _$stepCountStreamAtom.reportWrite(value, super.stepCountStream, () {
      super.stepCountStream = value;
    });
  }

  late final _$pedestrianStatusStreamAtom =
      Atom(name: 'PedometerBase.pedestrianStatusStream', context: context);

  @override
  Stream<PedestrianStatus> get pedestrianStatusStream {
    _$pedestrianStatusStreamAtom.reportRead();
    return super.pedestrianStatusStream;
  }

  @override
  set pedestrianStatusStream(Stream<PedestrianStatus> value) {
    _$pedestrianStatusStreamAtom
        .reportWrite(value, super.pedestrianStatusStream, () {
      super.pedestrianStatusStream = value;
    });
  }

  late final _$listenerAtom =
      Atom(name: 'PedometerBase.listener', context: context);

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

  late final _$pedestrianListenerAtom =
      Atom(name: 'PedometerBase.pedestrianListener', context: context);

  @override
  StreamSubscription<dynamic> get pedestrianListener {
    _$pedestrianListenerAtom.reportRead();
    return super.pedestrianListener;
  }

  @override
  set pedestrianListener(StreamSubscription<dynamic> value) {
    _$pedestrianListenerAtom.reportWrite(value, super.pedestrianListener, () {
      super.pedestrianListener = value;
    });
  }

  late final _$statusAtom =
      Atom(name: 'PedometerBase.status', context: context);

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$stepsAtom = Atom(name: 'PedometerBase.steps', context: context);

  @override
  String get steps {
    _$stepsAtom.reportRead();
    return super.steps;
  }

  @override
  set steps(String value) {
    _$stepsAtom.reportWrite(value, super.steps, () {
      super.steps = value;
    });
  }

  late final _$initialStepsAtom =
      Atom(name: 'PedometerBase.initialSteps', context: context);

  @override
  int get initialSteps {
    _$initialStepsAtom.reportRead();
    return super.initialSteps;
  }

  @override
  set initialSteps(int value) {
    _$initialStepsAtom.reportWrite(value, super.initialSteps, () {
      super.initialSteps = value;
    });
  }

  late final _$totalStepsAtom =
      Atom(name: 'PedometerBase.totalSteps', context: context);

  @override
  int get totalSteps {
    _$totalStepsAtom.reportRead();
    return super.totalSteps;
  }

  @override
  set totalSteps(int value) {
    _$totalStepsAtom.reportWrite(value, super.totalSteps, () {
      super.totalSteps = value;
    });
  }

  late final _$isInitialAtom =
      Atom(name: 'PedometerBase.isInitial', context: context);

  @override
  bool get isInitial {
    _$isInitialAtom.reportRead();
    return super.isInitial;
  }

  @override
  set isInitial(bool value) {
    _$isInitialAtom.reportWrite(value, super.isInitial, () {
      super.isInitial = value;
    });
  }

  late final _$measuredDistanceForStepsAtom =
      Atom(name: 'PedometerBase.measuredDistanceForSteps', context: context);

  @override
  double get measuredDistanceForSteps {
    _$measuredDistanceForStepsAtom.reportRead();
    return super.measuredDistanceForSteps;
  }

  @override
  set measuredDistanceForSteps(double value) {
    _$measuredDistanceForStepsAtom
        .reportWrite(value, super.measuredDistanceForSteps, () {
      super.measuredDistanceForSteps = value;
    });
  }

  late final _$measuredStepLengthAtom =
      Atom(name: 'PedometerBase.measuredStepLength', context: context);

  @override
  double get measuredStepLength {
    _$measuredStepLengthAtom.reportRead();
    return super.measuredStepLength;
  }

  @override
  set measuredStepLength(double value) {
    _$measuredStepLengthAtom.reportWrite(value, super.measuredStepLength, () {
      super.measuredStepLength = value;
    });
  }

  late final _$distanceTraveledAtom =
      Atom(name: 'PedometerBase.distanceTraveled', context: context);

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

  late final _$startTrackingAsyncAction =
      AsyncAction('PedometerBase.startTracking', context: context);

  @override
  Future<void> startTracking() {
    return _$startTrackingAsyncAction.run(() => super.startTracking());
  }

  late final _$setUsersDistanceAsyncAction =
      AsyncAction('PedometerBase.setUsersDistance', context: context);

  @override
  Future<String?> setUsersDistance(String email, int distance) {
    return _$setUsersDistanceAsyncAction
        .run(() => super.setUsersDistance(email, distance));
  }

  late final _$PedometerBaseActionController =
      ActionController(name: 'PedometerBase', context: context);

  @override
  void onStepCount(StepCount event) {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.onStepCount');
    try {
      return super.onStepCount(event);
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPedestrianStatusChanged(PedestrianStatus event) {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.onPedestrianStatusChanged');
    try {
      return super.onPedestrianStatusChanged(event);
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPedestrianStatusError(dynamic error) {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.onPedestrianStatusError');
    try {
      return super.onPedestrianStatusError(error);
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onStepCountError(dynamic error) {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.onStepCountError');
    try {
      return super.onStepCountError(error);
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initPlatformState() {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.initPlatformState');
    try {
      return super.initPlatformState();
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTracking() {
    final _$actionInfo = _$PedometerBaseActionController.startAction(
        name: 'PedometerBase.stopTracking');
    try {
      return super.stopTracking();
    } finally {
      _$PedometerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stepCountStream: ${stepCountStream},
pedestrianStatusStream: ${pedestrianStatusStream},
listener: ${listener},
pedestrianListener: ${pedestrianListener},
status: ${status},
steps: ${steps},
initialSteps: ${initialSteps},
totalSteps: ${totalSteps},
isInitial: ${isInitial},
measuredDistanceForSteps: ${measuredDistanceForSteps},
measuredStepLength: ${measuredStepLength},
distanceTraveled: ${distanceTraveled}
    ''';
  }
}
