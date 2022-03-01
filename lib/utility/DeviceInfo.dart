import 'dart:io';

import 'package:vendor_app/utility/custom_log_printer.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:dart_ipify/dart_ipify.dart';

DeviceInfo deviceInfo =DeviceInfo();

DeviceInfo getDeviceInfo() {
  if (deviceInfo == null) {
    deviceInfo = DeviceInfo();
  }
  return deviceInfo;
}

class DeviceInfo {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceName='';
  String deviceVersion='';
  String udid='';
  String osplatform='';
  String deviceIp='';
  String imei='';

  String getDeviceIp() {
    if (this.deviceIp == null) {
      return "192.168.43.115";
    }
    return deviceIp;
  }


  String getOsPlatform() {
    return osplatform;
  }

  String getDeviceName() {
    return this.deviceName;
  }

  String getDeviceVersion() {
    return deviceVersion;
  }

  String getUdid() {
    return udid;
  }

  String getimei() {
    return imei;
  }

  Future getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        osplatform = 'android';
        deviceName = build.model;
        deviceVersion = build.version.release.toString();
        udid = build.androidId; //UUID for Android
        imei = build.androidId;
      } else if (Platform.isIOS) {
        osplatform = 'ios';
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        udid = data.identifierForVendor; //UUID for iOS
      }

      // deviceIp = await Ipify.ipv4();
    } on PlatformException {
      CustomLogPrinter.printExceptionLog('Failed to get platform version');
    }
  }
}
