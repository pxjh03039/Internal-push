import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
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
                return const MessageRoot();
              },
            ),
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
