import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/repositories/navigation_repo.dart';

import '../routing/route_generator.dart';
import '../routing/routes.dart';
import '../theme/custom_theme.dart';
import '../theme/theme_config.dart';
import 'locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: buildApp(context)
    );
  }
}

Widget buildApp(BuildContext ctx) {
  return MaterialApp(
    navigatorKey: locator<NavigationRepo>().navigationKey,
    builder: (BuildContext context, Widget? child) {
      final MediaQueryData data = MediaQuery.of(context);
      return MediaQuery(data: data.copyWith(textScaleFactor: 1.0), child: child!);
    },
    initialRoute: splash,
    supportedLocales: ctx.supportedLocales,
    localizationsDelegates: ctx.localizationDelegates,
    locale: ctx.locale,
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
    title: 'Pedometer with Mobx',
    theme: CustomTheme.lightTheme,
    themeMode: currentTheme.currentTheme,
  );
}
