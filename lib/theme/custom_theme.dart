import 'package:flutter/material.dart';

import 'color_helper.dart';

class CustomTheme {
  ThemeMode get currentTheme => ThemeMode.light;

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(color: ColorHelper.black.color, elevation: 0, centerTitle: true),
      fontFamily: 'Roboto',
      textTheme: _textTheme,
      inputDecorationTheme: _decorationTheme,
      scaffoldBackgroundColor: Colors.transparent,
    );
  }
}

TextTheme _textTheme = TextTheme(
  caption: TextStyle(fontSize: 48, color: ColorHelper.orange.color, fontWeight: FontWeight.w600),
  bodyText1: TextStyle(fontSize: 24, color: ColorHelper.orange.color, fontWeight: FontWeight.w400),
  bodyText2: TextStyle(fontSize: 18, color: ColorHelper.darkGrey.color, fontWeight: FontWeight.w100),
  headline6: TextStyle(fontSize: 16, color: ColorHelper.darkGrey.color, fontWeight: FontWeight.bold),
);

InputDecorationTheme _decorationTheme = InputDecorationTheme(
  labelStyle: const TextStyle(color: Color.fromRGBO(125, 143, 161, 1), fontSize: 16.0, height: 1.7, fontWeight: FontWeight.w400),
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  alignLabelWithHint: true,
  fillColor: const Color.fromRGBO(102, 102, 102, 0.1),
  hintStyle: TextStyle(color: ColorHelper.darkGrey.color, fontSize: 18, fontWeight: FontWeight.w200),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorHelper.darkGrey.color!),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  ),
  isDense: true,
  contentPadding: const EdgeInsets.all(20),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorHelper.darkGrey.color!),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorHelper.darkGrey.color!),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorHelper.red.color!),
    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
  ),
);
