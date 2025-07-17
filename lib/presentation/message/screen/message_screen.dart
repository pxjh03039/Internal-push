import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('푸시발송'),
      ),
      body: Center(
        child: Column(
          children: [
            TextInputFiled(
              placeHolder: "제목",
              controller: viewModel.pushTitleController,
              // onSubmitted: viewModel.,
            ),
            TextInputFiled(
              placeHolder: "내용",
              controller: viewModel.pushMessageController,
              // onSubmitted: viewModel.,
            ),
            ElevatedButton(
                onPressed: () {
                  viewModel.onClickPushSend();
                },
                child: const Text('푸시 보내기')),
          ],
        ),
      ),
    );
  }
}
