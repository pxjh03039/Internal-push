import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_message.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:push_test_app/ui/text_styles.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessageViewModel>();
    // final FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Message',
          style: TextStyles.mediumTextBold,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            top: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextInputFiled(
                  isFocuse: true,
                  placeHolder: "메시지 입력",
                  controller: viewModel.pushMessageController,
                  onSubmitted: (_) {
                    if (viewModel.validatePushContents()) {
                      viewModel.onClickPushSend();
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: viewModel.validatePushContents()
                      ? ColorStyle.primary60
                      : ColorStyle.primary40,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    if (viewModel.validatePushContents()) {
                      viewModel.onClickPushSend();
                    }
                  },
                  icon: const Icon(Icons.send_sharp, size: 25),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: viewModel.messageState.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(height: 10),
                    DropdownSearch<String>.multiSelection(
                      items: (f, cs) => viewModel.messageState.userGroup,
                      selectedItems: viewModel
                          .messageState.selectedGroups, // 초기 선택값 (List<String>)
                      onChanged: (List<String> selected) {
                        // 선택된 항목이 변경될 때마다 호출
                        viewModel.setSelectedGroups(selected);
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: "구룹을 선택해주세요",
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
                                viewModel.setSelectedGroups(updated);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView(
                        reverse: true,
                        children: viewModel.messageState.getPushMessages
                            .map((PushMessage e) {
                          bool isSent = e.senderId == viewModel.messageState.id;
                          // 툴팁을 조건부로 적용하기 위해 별도의 위젯 변수 생성
                          Widget messageContent = Container(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              maxWidth: 250, // 최대 너비 지정
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isSent
                                  ? ColorStyle.primary60
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: isSent
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (!isSent)
                                  Text(
                                    e.senderId,
                                    style: TextStyles.smallerTextBold,
                                  ),
                                Text(
                                  e.body,
                                  style: TextStyles.smallTextBold
                                      .copyWith(color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatToMMDD(e.timestamp),
                                  style: TextStyles.smallerTextRegular,
                                ),
                              ],
                            ),
                          );

                          // isSent일 경우에만 Tooltip으로 감쌉니다.
                          if (isSent) {
                            messageContent = Tooltip(
                              message: '수신자: ${e.receiverIds.join(', ')}',
                              child:
                                  messageContent, // 위에서 정의한 메시지 컨텐츠를 child로 사용
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              final id = e.senderId;
                              final List<String> current;
                              if (viewModel.userGroupGubun(id) == 'user') {
                                current = viewModel.messageState.selectedUsers;
                                if (!current.contains(id)) {
                                  viewModel.setSelectedUsers([...current, id]);
                                }
                              } else {
                                current = viewModel.messageState.selectedGroups;
                                if (!current.contains(id)) {
                                  viewModel.setSelectedGroups([...current, id]);
                                }
                              }
                            },
                            onDoubleTap: () {
                              viewModel.copyClipboard(e.body);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('저장 되었습니다.'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: ColorStyle.primary100,
                                duration: Duration(milliseconds: 30),
                              ));
                            },
                            child: Align(
                              alignment: isSent
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child:
                                  messageContent, // 조건부로 감싸진 messageContent 사용
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
