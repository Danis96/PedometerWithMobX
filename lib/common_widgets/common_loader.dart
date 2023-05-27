import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ljubljana/theme/color_helper.dart';
import 'common_modal.dart';

Future<void> showMyDialog({
  BuildContext? context,
  String title = '',
  String msg = '',
  Color color = Colors.white,
  Widget? mainWidget,
  Widget? action,
  double elevation = 0,
  bool barrier = false,
}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: barrier,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: color,
        title: Text(title),
        content: SingleChildScrollView(child: ListBody(children: <Widget>[Container(child: mainWidget ?? const SizedBox())])),
        actions: <Widget>[action ?? const SizedBox()],
      );
    },
  );
}

Future<void> FOSLoaderCircleWhite({@required BuildContext? context}) {
  return showMyDialog(
    msg: '',
    action: const SizedBox(),
    context: context,
    barrier: false,
    title: '',
    mainWidget: SpinKitDoubleBounce(size: 80.0, color: ColorHelper.white.color),
    color: Colors.transparent,
    elevation: 0,
  );
}

void openLogoutPopup(BuildContext context, Function function) {
  FOSSimpleDialog(
    context,
    title: 'logout.title'.tr(),
    content: 'logout.body'.tr(),
    twoButtons: true,
    buttonText: 'logout.btn_ok'.tr(),
    buttonTwoText: 'logout.btn_cancel'.tr(),
    onButtonPressed: () => function(),
    onButtonTwoPressed: () => Navigator.of(context).pop(),
  );
}
