import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Push extends StatefulWidget {
  // final void Function() pushEvent;
  const Push({super.key});

  @override
  State<Push> createState() => _PushState();
}

class _PushState extends State<Push> {
  String? _token;
  String? _message;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 알림 권한 요청 (Web에서는 필수)
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ 알림 권한 승인됨');
      log('❌ 알림 권한 거부됨');
      return;
    }

    // VAPID 키는 Firebase 콘솔 > 프로젝트 설정 > 클라우드 메시징 > Web Push 인증서에서 확인
    _token = await messaging.getToken(
      vapidKey:
          'BNThCgsJjPAeXOO7bikdWrP7ZDtitpf-KnXn5G2iGCf-fJoPwxhBHCmtEOyyLBXJhnok_zO1cGejSdqwNkz6ogU',
    );
    log('📨 FCM Token: $_token');

    // 포그라운드 메시지 수신
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📩 포그라운드 메시지 수신: ${message.data['title']}');
      setState(() {
        _message = message.data['title'] ?? '알림 수신';
      });
    });

    // 알림 클릭 시 앱 열릴 때
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🔔 클릭된 메시지: ${message.data['title']}');
    });

    // 종료 상태에서 시작 시 메시지 수신
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('🚀 초기 메시지 수신: ${initialMessage.data['title']}');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📨 FCM 토큰:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SelectableText(_token ?? '토큰 로딩 중...'),
          const SizedBox(height: 20),
          const Text(
            '📩 마지막 메시지:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(_message ?? '없음'),
        ],
      ),
    );
  }
}
