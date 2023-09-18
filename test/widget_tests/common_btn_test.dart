import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/common_widgets/common_button.dart';

import '../test_helper.dart';

void main() {
  Widget fosBtn = FOSButton(
    onPressed: () {},
    widgetKey: const Key('fos_btn_test_key'),
    disabled: false,
    buttonTitle: 'Fos test button',
    btnType: BtnType.green,
  );

  final Finder findFosBtn = find.byKey(const Key('fos_btn_test_key'));

  testWidgets('Is FOSButton visible on the ui', (WidgetTester tester) async {
    await tester.pumpWidget(materialApp(fosBtn));
    await tester.pump();
    expect(findFosBtn, findsOneWidget);
  });
}
