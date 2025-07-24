import 'dart:async';

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/receive_push_data.dart';
import 'package:push_test_app/domain/repository/message_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/domain/send_push/receive_push_save_service.dart';
import 'package:push_test_app/presentation/message/message_state.dart';

class MessageViewModel with ChangeNotifier {
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;
  final ReceivePushSaveService _receivePushSaveService;

  MessageState _messageState = const MessageState();
  MessageState get messageState => _messageState;

  final TextEditingController pushTitleController = TextEditingController();
  final TextEditingController pushMessageController = TextEditingController();

  StreamSubscription<List<ReceivePushData>>? _pushSubscription;

  MessageViewModel({
    required MessageRepository messageRepository,
    required UserRepository userRepository,
    required ReceivePushSaveService receivePushSaveService,
  })  : _messageRepository = messageRepository,
        _userRepository = userRepository,
        _receivePushSaveService = receivePushSaveService {
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
    _subscribeToPushMessages();
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
  }

  void _subscribeToPushMessages() {
    _pushSubscription =
        _receivePushSaveService.messageStream.listen((messages) {
      // 메시지 리스트가 바뀔 때마다 상태에 반영
      // 예를 들어, MessageState에 새로운 필드를 추가해서 저장하거나 UI에 반영
      _messageState = _messageState.copyWith(receivedPushMessages: messages);
      notifyListeners();
      debugLog("푸시 메시지 수신: 총 ${messages.length}건");
    });
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
    // String userId = await getDeviceId();
    String id = await loadRegisterInfo('id');
    _messageState = _messageState.copyWith(isLoading: true);
    notifyListeners();
    if (_messageState.selectedUsers.isNotEmpty) {
      await _messageRepository.pushSendMessage(
          title: "유저 푸시 메시지",
          contents: _messageState.pushContents,
          ids: _messageState.selectedUsers,
          id: id);
    }
    if (_messageState.selectedGroups.isNotEmpty) {
      await _messageRepository.pushSendGroupMessage(
          title: "구룹 푸시 메시지",
          contents: _messageState.pushContents,
          id: id,
          groups: _messageState.selectedGroups);
    }
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
    pushMessageController.clear();
  }

  @override
  void dispose() {
    _pushSubscription?.cancel();
    pushTitleController.dispose();
    pushMessageController.dispose();
    super.dispose();
  }
}
