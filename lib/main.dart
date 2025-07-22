import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/router/router.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  diSetup();
  await Hive.initFlutter();
  log("FCM Token: $fcmToken");
  // 포그라운드 메시지 수신 리스너 등록
  setupFCMListener();
  await requestNotificationPermissions();
  runApp(const MyApp());
}

void setupFCMListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      showCustomPopup(notification.title ?? "알림", notification.body ?? "내용 없음");
    }
  });
}

Future<void> requestNotificationPermissions() async {
  try {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  } on PlatformException catch (e) {
    if (e.code == 'permission-blocked' ||
        e.message?.contains('permission-blocked') == true) {
      // 권한이 차단되어 팝업이 안 뜸
      // 사용자에게 설정 화면 안내
      openAppSettings();
    } else {
      // 다른 에러 처리
      debugLog('FirebaseMessaging permission error: $e');
    }
  } catch (e) {
    // 그 외 에러 처리
    debugLog('Unknown error on permission request: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 렌더링 완료 후 요청
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.mounted) {
        await requestNotificationPermissions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
