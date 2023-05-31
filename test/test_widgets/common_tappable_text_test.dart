import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/common_widgets/common_tappable_text.dart';

import 'widget_test_helper.dart';

void main() {
  const Key key = Key('fos_tappable_text_key');
  Widget fosTappableText = FOSTappableText(
    text: 'test',
    links: 'test',
    widgetKey: key,
    onPressed: (int i) {},
  );

  final Finder findFosTappableText = find.byKey(key);

  testWidgets('Is FOSTappableText visible on the ui', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(materialApp(fosTappableText));
    await widgetTester.pump();
    expect(findFosTappableText, findsOneWidget);
  });
}
