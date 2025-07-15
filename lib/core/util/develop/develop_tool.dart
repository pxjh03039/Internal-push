import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

void debugLog(dynamic value) {
  if (kIsWeb) {
    // ignore: avoid_print
    print(value);
  } else {
    log(value.toString());
  }
}

String isPlatform() {
  String platform = "Unknown";
  if (kIsWeb) {
    platform = "WEB";
  } else if (Platform.isAndroid) {
    platform = "AOS";
  } else if (Platform.isIOS) {
    platform = "iOS";
  } else {
    platform = "Unknown";
  }
  // debugLog("Platform: $platform");
  return platform;
}

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  final String platform = isPlatform();

  if (platform == "WEB") {
    final webInfo = await deviceInfo.webBrowserInfo;
    final raw = "${webInfo.userAgent}_${webInfo.platform}_${webInfo.vendor}";
    return "web_${raw.hashCode}";
  } else if (platform == "AOS") {
    final androidInfo = await deviceInfo.androidInfo;

    // ✅ 여러 필드 조합해서 해시값으로 고유 ID 흉내
    final raw =
        "${androidInfo.device}_${androidInfo.id}_${androidInfo.model}_${androidInfo.product}";
    return "aos_${raw.hashCode}";
  } else if (platform == "iOS") {
    final iosInfo = await deviceInfo.iosInfo;
    return "ios_${iosInfo.identifierForVendor}";
  } else {
    return "unknown_platform";
  }
}
