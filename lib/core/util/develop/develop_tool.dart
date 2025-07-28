import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:push_test_app/data/clipboard/clipboard_service_impl.dart';
import 'package:push_test_app/router/router.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:uuid/uuid.dart';

final _clipboard = ClipboardServiceImpl();

String formatToMMDD(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true)
      .toLocal(); // 한국 시간 변환

  // final month = date.month.toString().padLeft(2, '0');
  // final day = date.day.toString().padLeft(2, '0');
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$hour:$minute';
}

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
  final String platform = isPlatform();
  String? deviceId = await loadRegisterInfo('deviceId');

  try {
    if (deviceId == null) {
      final rawUuid = const Uuid().v4();

      if (platform == "WEB") {
        deviceId = "web_$rawUuid";
      } else if (platform == "AOS") {
        deviceId = "aos_$rawUuid";
      } else if (platform == "iOS") {
        deviceId = "ios_$rawUuid";
      } else {
        return "unknown_platform";
      }
    }

    return deviceId;
  } catch (e) {
    debugLog("getDeviceId 얻기 실패: $e");
    rethrow;
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
