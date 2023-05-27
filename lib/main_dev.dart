import 'package:flutter/cupertino.dart';

import 'app/config/flavor_config.dart';
import 'main_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues(baseUrl: 'https://fosmobileapi.azurewebsites.net/', appName: 'PedometerMobX'));
  mainCommon();
}
