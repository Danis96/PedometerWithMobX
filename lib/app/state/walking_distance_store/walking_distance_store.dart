import 'package:mobx/mobx.dart';

part 'walking_distance_store.g.dart';

class WalkingDistanceStore = WalkingDistanceBase with _$WalkingDistanceStore;

abstract class WalkingDistanceBase with Store {

  @observable
  bool confirmTest = false;

  @action
  void setConfirmTest(bool value) {
    confirmTest = value;
  }

}