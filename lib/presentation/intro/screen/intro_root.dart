import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/presentation/intro/intro_view_model.dart';
import 'package:push_test_app/presentation/intro/screen/intro_screen.dart';
import 'package:push_test_app/router/route_path.dart';

class IntroRoot extends StatelessWidget {
  const IntroRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<IntroViewModel>();
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: FutureBuilder(
        future: viewModel.isUserTokenRegistered(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.introState.isRegistered) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              String? newUserId = await viewModel.updateUserToken();
              debugLog('newUserId: $newUserId');
              saveRegisterInfo(key: 'id', value: newUserId);

              if (context.mounted) {
                context.go(RoutePath.profile);
              }
            });
            return const SizedBox();
          }

          return const IntroScreen();
        },
      ),
    );
  }
}
