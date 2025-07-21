import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }

  Future<void> requestNotificationPermissions() async {
    // Firebase 메시지 권한 요청
    await FirebaseMessaging.instance.requestPermission(
      badge: true,
      alert: true,
      sound: true,
    );

    // 추가로 permission_handler 패키지 사용 시:
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
