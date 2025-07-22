import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/message_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/message/message_state.dart';

class MessageViewModel with ChangeNotifier {
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;

  MessageState _messageState = const MessageState();
  MessageState get messageState => _messageState;

  final TextEditingController pushTitleController = TextEditingController();
  final TextEditingController pushMessageController = TextEditingController();

  MessageViewModel(
      {required MessageRepository messageRepository,
      required UserRepository userRepository})
      : _messageRepository = messageRepository,
        _userRepository = userRepository {
    {
      pushTitleController.text = _messageState.pushTitle;
      pushMessageController.text = _messageState.pushContents;

      pushTitleController.addListener(() {
        updateTitle(pushTitleController.text);
      });
      pushMessageController.addListener(() {
        updateMessage(pushMessageController.text);
      });
      initData();
    }
  }

  void initData() {
    _messageState = _messageState.copyWith(isLoading: true);
    notifyListeners();
    setUserNames();
    getUserGroup();
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> getUserGroup() async {
    final group = await _userRepository.getUserGroup();
    _messageState = _messageState.copyWith(
      userGroup: group,
    );

    notifyListeners();
  }

  void setSelectedUsers(List<String> selectedUsers) {
    _messageState = _messageState.copyWith(selectedUsers: selectedUsers);
    debugLog(_messageState.selectedUsers);
    notifyListeners();
  }

  void setSelectedGroups(List<String> selectedGroups) {
    _messageState = _messageState.copyWith(selectedGroups: selectedGroups);
    debugLog(_messageState.selectedGroups);
    notifyListeners();
  }

  void setUserNames() async {
    List<String> userNames = await _userRepository.getUserNames();
    _messageState = _messageState.copyWith(userNames: userNames);
    debugLog(_messageState.userNames);
    notifyListeners();
  }

  void updateTitle(String newTitle) {
    _messageState = _messageState.copyWith(pushTitle: newTitle);
    notifyListeners();
  }

  void updateMessage(String newMessage) {
    _messageState = _messageState.copyWith(pushContents: newMessage);
    notifyListeners();
  }

  bool validatePushContents() {
    return (_messageState.pushContents.trim().isNotEmpty &&
            _messageState.selectedUsers.isNotEmpty) ||
        (_messageState.pushContents.trim().isNotEmpty &&
            _messageState.selectedGroups.isNotEmpty);
  }

  Future<void> onClickPushSend() async {
    _messageState = _messageState.copyWith(isLoading: true);
    notifyListeners();
    if (_messageState.selectedUsers.isNotEmpty) {
      await _messageRepository.pushSendMessage(
          title: "유저 푸시 메시지",
          contents: _messageState.pushContents,
          ids: _messageState.selectedUsers);
    }
    if (_messageState.selectedGroups.isNotEmpty) {
      await _messageRepository.pushSendGroupMessage(
          title: "구룹 푸시 메시지",
          contents: _messageState.pushContents,
          groups: _messageState.selectedGroups);
    }
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
    pushMessageController.clear();
  }
}
