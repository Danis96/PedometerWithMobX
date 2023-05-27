import 'package:flutter/material.dart';
import 'package:ljubljana/common_widgets/common_button.dart';
import 'package:ljubljana/theme/color_helper.dart';

class FOSTwoButtons extends StatelessWidget {
  const FOSTwoButtons({
    this.leftBtnText = '',
    this.rightBtnText = '',
    this.rightBtnType = BtnType.green,
    required this.leftBtnFunction,
    required this.rightBtnFunction,
    this.leftBtnTextColor = const Color.fromRGBO(245, 1, 1, 1),
  });

  final String leftBtnText;
  final Color leftBtnTextColor;
  final String rightBtnText;
  final Function? leftBtnFunction;
  final Function? rightBtnFunction;
  final BtnType rightBtnType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: TextButton(onPressed: () => leftBtnFunction!(), child: Text(leftBtnText, style: TextStyle(color: leftBtnTextColor), textAlign: TextAlign.left,))),
          Expanded(child: FOSButton(onPressed: () => rightBtnFunction!(), buttonTitle: rightBtnText, btnType: rightBtnType)),
        ],
      ),
    );
  }
}
