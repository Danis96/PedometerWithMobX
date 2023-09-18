import 'package:flutter/cupertino.dart';
import 'package:ljubljana/main_dev.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User login successfully', (WidgetTester widgetTester) async {
    SharedPreferences.setMockInitialValues({});
    app.main();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 1500));
    final Finder welcomeStartButton = find.byKey(const Key('danis_test'));
    // await widgetTester.tap(welcomeStartButton);
    // await widgetTester.pumpAndSettle();
    // expect(find.byKey(const Key('login_page_body_key')), findsOneWidget);
    expect(welcomeStartButton, findsOneWidget);
  });
}
