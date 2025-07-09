// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';

import 'package:push_test_app/presentation/push/screen/push_screen.dart';
import 'package:push_test_app/ui/color_style.dart';

class PushRoot extends StatefulWidget {
  const PushRoot({
    super.key,
  });

  @override
  State<PushRoot> createState() => _PushRootState();
}

class _PushRootState extends State<PushRoot> {
  late PushViewModel viewModel;
  late StreamSubscription<PushAction> _subScription;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<PushViewModel>();
    _subScription = viewModel.eventStream.listen(
      (event) {
        switch (event) {
          case SetField(field: PushField.selectRepeat):
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).clearSnackBars(); // 기존 스낵바 제거
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(event.value),
                behavior: SnackBarBehavior.floating,
                backgroundColor: ColorStyle.primary100,
                duration: const Duration(seconds: 1),
              ));
            });

          case SetField(field: PushField.textChange):
          // case (_):
          //   debugLog(event);
        }
      },
    );
  }

  @override
  void dispose() {
    _subScription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => viewModel, child: PushScreen());
  }
}
