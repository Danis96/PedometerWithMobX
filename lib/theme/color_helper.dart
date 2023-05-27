import 'dart:ui';

import 'package:flutter/material.dart';

enum ColorHelper {
  black,
  orange,
  darkGrey,
  blue,
  green,
  red,
  white,
  lightBlue,
  lightGrey,
}

extension ColorExtension on ColorHelper {
  Color? get color {
    switch (this) {
      case ColorHelper.black:
        return const Color.fromRGBO(0, 0, 0, 1);
      case ColorHelper.orange:
        return const Color.fromRGBO(245, 103, 1, 1);
      case ColorHelper.darkGrey:
        return const Color.fromRGBO(102, 102, 102, 1);
      case ColorHelper.blue:
        return const Color.fromRGBO(0, 185, 242, 1.0);
      case ColorHelper.green:
        return const Color.fromRGBO(112, 167, 42, 1);
      case ColorHelper.red:
        return const Color.fromRGBO(245, 1, 1, 1);
      case ColorHelper.white:
        return const Color.fromRGBO(255, 255, 255, 1);
      case ColorHelper.lightBlue:
        return const Color.fromRGBO(204, 238, 255, 1);
      case ColorHelper.lightGrey:
        return const Color.fromRGBO(235, 235, 235, 1);
      default:
        return const Color.fromRGBO(0, 0, 0, 0);
    }
  }
}
