import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/splash_store/splash_store.dart';

import '../../../theme/color_helper.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late final SplashStore? store;

  @override
  void initState() {
    store = locator<SplashStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorHelper.white.color,
            child: Container(
                color: ColorHelper.white.color, child: const Center(child: SpinKitDoubleBounce(size: 80.0, color: Colors.deepOrangeAccent)))),
      ),
    );
  }
}
