import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/common_widgets/common_text_field.dart';

import 'widget_test_helper.dart';

void main() {
  const Key key = Key('fos_text_field_key');
  Widget fosTextField = FOSTextFormField(
    onChange: (String? s) {
      return null;
    },
    fKey: key,
    hintText: 'Hint text',
    keyboardType: TextInputType.text,
    fillColor: Colors.black,
    type: TextFieldType.textAreaType,
  );

  final Finder findFosTextField = find.byKey(key);

  testWidgets('Is FOSTextFormField visible on the ui', (WidgetTester widgetTester) async {
     await widgetTester.pumpWidget(materialApp(fosTextField));
     await widgetTester.pump();
     expect(findFosTextField, findsOneWidget);
  });
}
