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
    return ChangeNotifierProvider(
      create: (_) => getIt<IntroViewModel>(),
      child: Builder(
        builder: (context) {
          final viewModel = context.watch<IntroViewModel>();

          if (viewModel.introState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          debugLog(
              'viewModel.introState.isRegistered ${viewModel.introState.isRegistered}');
          if (viewModel.introState.isRegistered) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              var id = await viewModel.updateUserToken(); // await 포함
              await saveRegisterInfo(key: 'id', value: id);
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
