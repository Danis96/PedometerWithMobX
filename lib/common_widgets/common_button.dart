import 'package:flutter/material.dart';
import 'package:ljubljana/theme/color_helper.dart';

enum BtnType { orange, grey, blue, green }

class FOSButton extends StatelessWidget {
  const FOSButton({Key? key, this.widgetKey = const Key('placeholder'), this.buttonTitle = '', this.disabled = false, @required this.onPressed, this.style, this.btnType = BtnType.orange})
      : super(key: key);


  final String buttonTitle;
  final bool disabled;
  final Key widgetKey;
  final Function? onPressed;
  final ButtonStyle? style;
  final BtnType btnType;

  Color? btnTypeColor(BtnType buttonType) {
    if (buttonType == BtnType.orange) {
      return ColorHelper.orange.color;
    } else if (buttonType == BtnType.grey) {
      return ColorHelper.darkGrey.color;
    } else if (buttonType == BtnType.blue) {
      return ColorHelper.blue.color;
    } else {
      return ColorHelper.green.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 60,
      child: ElevatedButton(
        key: widgetKey,
        onPressed: disabled ? null : () => onPressed!(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(btnTypeColor(btnType)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.white.color, fontSize: 16),
        ),
      ),
    );
  }
}
