import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:ljubljana/app/utils/storage_prefs_manager.dart';

enum ApiHeader {
  appJson,
  authAppJson,
}

class ApiHeaderHelper {
  static Future<Map<String, String>> getValue(ApiHeader path) async {
    String deviceBrand = '';
    String deviceManufacturer = '';
    String deviceModel = '';
    String deviceOS = '';
    String deviceOSVersion = '';
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceBrand = androidInfo.brand;
        deviceManufacturer = androidInfo.manufacturer;
        deviceModel = androidInfo.model;
        deviceOS = 'Android';
        deviceOSVersion = '${androidInfo.version.sdkInt}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceBrand = 'Apple';
        deviceManufacturer = '';
        deviceModel = iosInfo.model;
        deviceOS = 'iOS';
        deviceOSVersion = iosInfo.systemVersion;
      }
    } on PlatformException {
      print('Failed to get platform info');
    }

    switch (path) {
      case ApiHeader.appJson:
        return <String, String>{HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
      case ApiHeader.authAppJson:
        final String token = await storagePrefs.getValue(StoragePrefsManager.ACCESS_TOKEN);
        print('TOKENN: $token');
        return <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'X-AppInfo-Implementation': 'Native',
          'X-DeviceInfo-Brand': deviceBrand,
          'X-DeviceInfo-Manufacturer': deviceManufacturer,
          'X-DeviceInfo-Model': deviceModel,
          'X-DeviceInfo-OS': deviceOS,
          'X-DeviceInfo-OS-Version': deviceOSVersion,
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        };
      default:
        return <String, String>{'': ''};
    }
  }
}
