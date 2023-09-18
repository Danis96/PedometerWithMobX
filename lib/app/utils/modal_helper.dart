import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ljubljana/common_widgets/common_modal.dart';

class ModalHelper {
  void returnErrorModalOrFn(BuildContext context, String? error, {Function? function}) {
    if (error != null) {
      fOSSimpleDialog(context, content: error, title: 'modal_helper.error'.tr(), buttonText: 'modal_helper.btn_text'.tr());
    } else {
      if(function != null) {
        function();
      }
    }
  }
}
