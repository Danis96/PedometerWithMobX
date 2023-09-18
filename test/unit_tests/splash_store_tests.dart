import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/splash_store/splash_store.dart';

import '../test_helper.dart';

void main() {
  late SplashStore splashStore;
  bool setupCalled = false;

  setUp(() async {
    if (!setupCalled) {
      setupLocatorForTests();
    }
    splashStore = locatorTest<SplashStore>();
    setupCalled = true;
  });

  group('test bool fn [isUserLoggedIn]', () {
     test('if we pass "" it should return false', () async {
        final bool testBool = splashStore.isUserLoggedIn('');
        expect(testBool, false);
     });
  });
}