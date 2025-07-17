import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
import 'package:push_test_app/presentation/message/screen/message_screen.dart';

class MessageRoot extends StatelessWidget {
  const MessageRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt.call<MessageViewModel>(),
      child: const MessageScreen(),
    );
  }
}
