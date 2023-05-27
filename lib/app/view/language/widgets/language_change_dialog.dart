import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageChangeDialog extends StatelessWidget {

  final String languageName;
  final VoidCallback onChange;



  const LanguageChangeDialog({
    Key? key,
    required this.languageName,
    required this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    AlertDialog(
      title: Text(
        'language_selection.alert_title'.tr(),
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Text(
        'language_selection.alert_content'.tr() + " " + languageName,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16),
      ),
      actions: [
        TextButton(
            onPressed: onChange,
            child: Text('common.yes'.tr())
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('common.no'.tr())
        )
      ],
    ) :
    CupertinoAlertDialog(
      title: Text(
        'language_selection.alert_title'.tr(),
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Text(
        'language_selection.alert_content'.tr() + " " + languageName,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16),
      ),
      actions: [
        TextButton(
            onPressed: onChange,
            child: Text('common.yes'.tr())
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('common.no'.tr())
        )
      ],
    );
  }
}
