// Arwa

import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class deviceType {
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  String deviceInfo = '';

  Future<void> deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;

        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    print(deviceName);
    print(deviceVersion);
    print(identifier);
    deviceInfo = deviceName + " " + deviceVersion + " " + identifier;
    print("device Info :" + deviceInfo);
  }
}
