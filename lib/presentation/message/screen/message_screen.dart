import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:push_test_app/ui/text_styles.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessageViewModel>();
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '푸시발송',
          style: TextStyles.mediumTextBold,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: viewModel.messageState.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    DropdownSearch<String>.multiSelection(
                      items: (f, cs) => viewModel.messageState.userNames,
                      selectedItems: viewModel
                          .messageState.selectedUsers, // 초기 선택값 (List<String>)
                      onChanged: (List<String> selected) {
                        // 선택된 항목이 변경될 때마다 호출
                        viewModel.setSelectedUsers(selected);
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: "사용자를 선택해주세요",
                          hintStyle: TextStyles.smallTextRegular
                              .copyWith(color: ColorStyle.gray3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      dropdownBuilder: (context, selectedItems) {
                        return Wrap(
                          spacing: 6.0,
                          runSpacing: -8.0,
                          children: selectedItems.map((item) {
                            return Chip(
                              backgroundColor: ColorStyle.primary40,
                              label: Text(
                                item,
                                style: TextStyles.smallTextBold,
                              ),
                              onDeleted: () {
                                final updated = List<String>.from(selectedItems)
                                  ..remove(item);
                                viewModel.setSelectedUsers(updated);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
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
                                  : ColorStyle.primary60,
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
