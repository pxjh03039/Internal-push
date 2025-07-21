import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessageViewModel>();
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: const Text('푸시발송'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: viewModel.messageState.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: TextInputFiled(
                            isFocuse: true,
                            placeHolder: "메시지 입력",
                            controller: viewModel.pushMessageController,
                            onSubmitted: (_) {
                              if (viewModel.validatePushContents()) {
                                // ScaffoldMessenger.of(context)
                                //     .clearSnackBars(); // 기존 스낵바 제거
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(const SnackBar(
                                //   content: Text('메시지가 비었습니다.'),
                                //   behavior: SnackBarBehavior.floating,
                                //   backgroundColor: ColorStyle.primary100,
                                //   duration: Duration(seconds: 1),
                                // ));
                              } else {
                                viewModel.onClickPushSend();
                              }
                              focusNode.requestFocus();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: viewModel.validatePushContents()
                                  ? ColorStyle.primary40
                                  : ColorStyle.primary80,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: const Alignment(0.4, 0),
                              child: IconButton(
                                onPressed: () {
                                  if (viewModel.validatePushContents()) {
                                    // ScaffoldMessenger.of(context)
                                    //     .clearSnackBars(); // 기존 스낵바 제거
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(const SnackBar(
                                    //   content: Text('메시지가 비었습니다.'),
                                    //   behavior: SnackBarBehavior.floating,
                                    //   backgroundColor: ColorStyle.primary100,
                                    //   duration: Duration(seconds: 1),
                                    // ));
                                  } else {
                                    viewModel.onClickPushSend();
                                  }
                                },
                                icon: const Icon(
                                  Icons.send_sharp,
                                  size: 25,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
