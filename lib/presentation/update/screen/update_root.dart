// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/presentation/update/update_view_model.dart';

import 'package:push_test_app/presentation/update/screen/update_screen.dart';

class UpdateRoot extends StatelessWidget {
  final String scheduleId;
  final PushSchedule schedule;
  const UpdateRoot({
    super.key,
    required this.scheduleId,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<UpdateViewModel>(
        param1: scheduleId,
        param2: schedule,
      ),
      builder: (context, child) => const UpdateScreen(),
    );
  }
}
