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
      setUserNames();
    }
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
    return _messageState.pushContents.trim().isEmpty;
  }

  Future<void> onClickPushSend() async {
    _messageState = _messageState.copyWith(isLoading: true);
    notifyListeners();
    await _messageRepository.pushSendMessage(
        title: "푸시 메시지",
        contents: _messageState.pushContents,
        ids: _messageState.userNames);
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
    pushMessageController.clear();
  }
}
