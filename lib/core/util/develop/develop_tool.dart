import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:push_test_app/data/clipboard/clipboard_service_impl.dart';
import 'package:push_test_app/router/router.dart';
import 'package:push_test_app/ui/color_style.dart';

final _clipboard = ClipboardServiceImpl();

Future<void> saveRegisterInfo(
    {required String key, required dynamic value}) async {
  var box = await Hive.openBox('registerBox');

  if (value == null) throw Exception('value is null');

  if (value is Map<String, dynamic>) {
    // Map은 JSON 문자열로 저장
    await box.put(key, jsonEncode(value));
  } else if (value is String) {
    await box.put(key, value);
  } else {
    throw Exception(
        'Unsupported type: Only Map<String, dynamic> or String allowed.');
  }
}

Future<dynamic> loadRegisterInfo(String key) async {
  var box = await Hive.openBox('registerBox');
  final value = box.get(key);

  if (value == null) return null;

  if (value is String) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {
      // JSON 파싱 실패 → 그냥 문자열 반환
    }
    return value;
  }

  return value;
}

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

void showCustomPopup(String title, String body) {
  final context = navigatorKey.currentContext;
  if (context == null) return; // 전역 context 유효성 검사
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
                onPressed: () {
                  _clipboard.copyText(body);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('저장 되었습니다.'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: ColorStyle.primary100,
                    duration: Duration(seconds: 1),
                  ));
                },
                icon: const Icon(Icons.copy_rounded))
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _clipboard.copyText(body);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('저장 되었습니다.'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: ColorStyle.primary100,
              duration: Duration(seconds: 1),
            ));
          },
          child: const Text("복사"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("확인"),
        ),
      ],
    ),
  );
}
