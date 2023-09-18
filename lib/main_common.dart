import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'app/locator.dart';
import 'app/utils/storage_prefs_manager.dart';

void mainCommon() {
  setupLocator();
  Future.wait<void>([
    EasyLocalization.ensureInitialized(),
    storagePrefs.init(),
  ]).then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('si', 'SI')],
        path: 'assets/translations',
        startLocale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    );
  });
}
