import 'package:flutter/material.dart';
import 'package:ljubljana/common_widgets/common_button.dart';

void FOSSimpleDialog(
  BuildContext context, {
  String title = '',
  String content = '',
  String buttonText = '',
  String buttonTwoText = '',
  Color titleColor = Colors.black,
  Color contentColor = Colors.black,
  Color buttonColor = Colors.black,
  String key = '',
  Widget? contentWidget,
  Widget? titleWidget,
  Function? onButtonPressed,
  Function? onButtonTwoPressed,
  bool dismiss = true,
  bool twoButtons = false,
  bool canPop = true,
}) {
  showDialog(
    barrierDismissible: dismiss,
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () async => canPop,
      child: AlertDialog(
        key: Key(key),
        title: titleWidget ?? (Text(title, style: TextStyle(fontSize: 16.0, color: titleColor, fontWeight: FontWeight.bold))),
        content: contentWidget ?? Text(content, style: TextStyle(fontSize: 15.0, color: titleColor)),
        actions: <Widget>[
          SizedBox(
              height: 40,
              child: buttonTwoText.isEmpty
                  ? _buildOneButton(context, onPressed: onButtonPressed, title: buttonText)
                  : _buildTwoButtons(context,
                      buttonText: buttonText, buttonTwoText: buttonTwoText, onPressed: onButtonPressed, onButtonTwoPressed: onButtonTwoPressed)),
        ],
      ),
    ),
  );
}

Widget _buildOneButton(BuildContext context, {Function? onPressed, String title = ''}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FOSButton(
            btnType: BtnType.orange,
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              } else {
                Navigator.of(context).pop();
              }
            },
            buttonTitle: title,
          ),
        ),
      )
    ],
  );
}

Widget _buildTwoButtons(
  BuildContext context, {
  Function? onPressed,
  String buttonText = '',
  Function? onButtonTwoPressed,
  String buttonTwoText = '',
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Expanded(
        child: FOSButton(
          btnType: BtnType.orange,
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            } else {
              Navigator.of(context).pop();
            }
          },
          buttonTitle: buttonText,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: FOSButton(
          btnType: BtnType.orange,
          onPressed: () {
            if (onButtonTwoPressed != null) {
              onButtonTwoPressed();
            } else {
              Navigator.of(context).pop();
            }
          },
          buttonTitle: buttonTwoText,
        ),
      ),
    ],
  );
}
