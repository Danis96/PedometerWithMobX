import 'package:flutter/material.dart';

Widget materialApp(Widget child, {PreferredSizeWidget? appBar}) {
  return MaterialApp(home: Scaffold(appBar: appBar ?? AppBar(), body: Container(child: child)));
}
