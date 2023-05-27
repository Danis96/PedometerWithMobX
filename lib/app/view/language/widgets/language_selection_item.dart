import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';

import '../../../utils/language_helper.dart';
import 'language_change_dialog.dart';

class LanguageSelectionItem extends StatelessWidget {
  final AppLanguages language;

  LanguageSelectionItem({Key? key, required this.language}) : super(key: key);

  final LanguageStore langStore = locator<LanguageStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (langStore.appLanguage == language) {
          return;
        }
        showDialog(
            context: context,
            builder: (BuildContext ctx) => LanguageChangeDialog(
                languageName: language.languageName,
                onChange: () async {
                  Navigator.of(context).pop();
                  await Future.delayed(const Duration(milliseconds: 500));
                  await context.setLocale(Locale(language.languageCode, language.countryCode));
                  await langStore.setLanguage(language);
                }));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(24)), color: Colors.grey[200]),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Text(
              language.languageName,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (langStore.appLanguage == language)
              Stack(
                children: [
                  Positioned(child: ClipOval(child: Container(height: 24, width: 24, color: Colors.grey[400]))),
                  Positioned(top: 7, left: 7, child: ClipOval(child: Container(height: 10, width: 10, color: Colors.blue)))
                ],
              )
            else
              ClipOval(child: Container(width: 24, height: 24, color: Colors.grey[400]))
          ],
        ),
      ),
    );
  }
}
