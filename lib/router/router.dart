import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/model/receive_push_data.dart';
import 'package:push_test_app/domain/send_push/receive_push_save_service.dart';
import 'package:push_test_app/presentation/create/screen/create_root.dart';
import 'package:push_test_app/presentation/message/screen/message_root.dart';
import 'package:push_test_app/presentation/update/screen/update_root.dart';
import 'package:push_test_app/presentation/intro/screen/intro_root.dart';
import 'package:push_test_app/presentation/main/main_screen.dart';
import 'package:push_test_app/presentation/profile/profile_screen.dart';
import 'package:push_test_app/presentation/profile/profile_view_model.dart';
import 'package:push_test_app/presentation/push/screen/push_root.dart';
import 'package:push_test_app/router/route_path.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePath.intro,
  routes: [
    GoRoute(
      path: RoutePath.intro,
      builder: (context, state) => const IntroRoot(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => MainScreen(
        currentSelected: 0,
        onDestinationSelected: (index) {},
        child: const Center(child: Text('mainScreen')),
      ),
    ),
    GoRoute(
      path: RoutePath.create,
      builder: (context, state) => const CreateRoot(),
    ),
    GoRoute(
      path: '/update',
      builder: (context, state) {
        final param = state.extra as PushSchedule;
        return UpdateRoot(scheduleId: param.id);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          currentSelected: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.push,
              builder: (context, state) {
                return const PushRoot();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.message,
              builder: (context, state) {
                debugLog('1??듫어왕?');
                final rawParams = state.uri.queryParameters;

                final id = Uri.decodeComponent(rawParams['id'] ?? '');
                final title = Uri.decodeComponent(rawParams['title'] ?? '');
                final body = Uri.decodeComponent(rawParams['body'] ?? '');
                final dataRaw = rawParams['data'];

                Map<String, dynamic> data = {};
                if (dataRaw != null && dataRaw.isNotEmpty) {
                  try {
                    data = jsonDecode(Uri.decodeComponent(dataRaw));
                  } catch (e) {
                    debugPrint('🔥 Failed to decode data param: $e');
                  }
                }

                final receivePush = getIt<ReceivePushSaveService>();

                final pushMessage = ReceivePushData.fromJson({
                  'messageId': id,
                  'title': title,
                  'body': body,
                  'data': data, // 🔥 전체 쿼리 파라미터를 data로 보관
                  'receivedAt': DateTime.now().toIso8601String(),
                });

                /// 이 방식은 프레임 렌더링이 끝난 후 실행됨
                // WidgetsBinding.instance.addPostFrameCallback((_) async {
                debugLog('pushMessage $pushMessage');
                if (id.isNotEmpty) {
                  debugLog('pushMessage2 $pushMessage');
                  receivePush.addPush(pushMessage);
                }
                // });

                return const MessageRoot();
              },
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.message,
              builder: (context, state) {
                return ChangeNotifierProvider(
                  create: (context) =>
                      ProfileViewModel(userRepository: getIt()),
                  child: const MessageRoot(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePath.profile,
              builder: (context, state) {
                return ChangeNotifierProvider(
                  create: (context) =>
                      ProfileViewModel(userRepository: getIt()),
                  child: const ProfileScreen(),
                );
              },
            ),
          ],
        )
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: RoutePath.create,
        //       builder: (context, state) {
        //         return const CreateRoot();
        //       },
        //     ),
        //   ],
        // ),
      ],
    ),
  ],
);
