import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';
import 'package:ljubljana/app/utils/language_helper.dart';

import '../test_helper.dart';

void main() {
  late LanguageStore languageStore;
  bool setupCalled = false;

  setUp(() async {
    if (!setupCalled) {
      setupLocatorForTests();
    }
    languageStore = locatorTest<LanguageStore>();
    setupCalled = true;
  });

  group('test setters', () {
     test('setAppLanguage, should set [appLanguage] var to AppLanguage value that we set', (){
         const AppLanguages testLang = AppLanguages.en;
         languageStore.setAppLanguage(testLang);
         expect(languageStore.appLanguage, testLang);
     });
  });
}