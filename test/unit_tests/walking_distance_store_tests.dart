import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/walking_distance_store/walking_distance_store.dart';

import '../test_helper.dart';

void main() {
  late WalkingDistanceStore walkingDistanceStore;
  bool setupCalled = false;

  setUp(() async {
    if (!setupCalled) {
      setupLocatorForTests();
    }
    walkingDistanceStore = locatorTest<WalkingDistanceStore>();
    setupCalled = true;
  });

  group('Test confirm value fn & initial value', () {
    test('confirmTest, initial value should be false', () async {
      final bool initialValueForConfirmTest = walkingDistanceStore.confirmTest;
      expect(initialValueForConfirmTest, false);
    });
    test('setConfirmTest, test if value of [confirmTest] will change', () async {
      walkingDistanceStore.setConfirmTest(true);
      expect(walkingDistanceStore.confirmTest, true);
    });
  });
}