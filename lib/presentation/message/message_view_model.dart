import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/message_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/message/message_state.dart';

class MessageViewModel with ChangeNotifier {
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;

  MessageState _messageState = const MessageState();

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

  Future<void> onClickPushSend() async {
    _messageRepository.pushSendMessage(
        title: _messageState.pushTitle,
        contents: _messageState.pushContents,
        ids: _messageState.userNames);
  }
}
