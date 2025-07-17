import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/router/router.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  diSetup();
  await Hive.initFlutter();
  log("FCM Token: $fcmToken");

  runApp(const MyApp());
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
