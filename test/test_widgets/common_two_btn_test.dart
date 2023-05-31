import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/common_widgets/common_button.dart';
import 'package:ljubljana/common_widgets/common_two_buttons.dart';

import 'widget_test_helper.dart';

void main() {
  const Key key = Key('fos_two_btn_test');
  Widget fosTwoButtons = FOSTwoButtons(
    leftBtnFunction: () {},
    rightBtnFunction: () {},
    leftBtnText: 'Left',
    rightBtnText: 'Right',
    leftBtnTextColor: Colors.white,
    rightBtnType: BtnType.green,
    widgetKey: key,
  );

  final Finder findFosTwoBtn = find.byKey(key);

  testWidgets('Is FOSTwoButtons visible on the ui', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(materialApp(fosTwoButtons));
    await widgetTester.pump();
    expect(findFosTwoBtn, findsOneWidget);
  });
}
