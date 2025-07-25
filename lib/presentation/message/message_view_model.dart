import 'dart:async';

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/clipboard/clipboard_service.dart';
import 'package:push_test_app/domain/model/receive_push_data.dart';
import 'package:push_test_app/domain/repository/message_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/domain/send_push/receive_push_save_service.dart';
import 'package:push_test_app/presentation/message/message_state.dart';

class MessageViewModel with ChangeNotifier {
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;
  final ReceivePushSaveService _receivePushSaveService;
  final ClipboardService _clipboardService;

  MessageState _messageState = const MessageState();
  MessageState get messageState => _messageState;

  final TextEditingController pushTitleController = TextEditingController();
  final TextEditingController pushMessageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  StreamSubscription<List<ReceivePushData>>? _pushSubscription;

  MessageViewModel({
    required MessageRepository messageRepository,
    required UserRepository userRepository,
    required ReceivePushSaveService receivePushSaveService,
    required ClipboardService clipboardService,
  })  : _messageRepository = messageRepository,
        _userRepository = userRepository,
        _receivePushSaveService = receivePushSaveService,
        _clipboardService = clipboardService {
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
    setUserInfo();
    notifyListeners();
    setUserNames();
    getUserGroup();
    _subscribeToPushMessages();
    _getPushMessageHistory();
    _messageState = _messageState.copyWith(isLoading: false);
    notifyListeners();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 널 체크 및 hasClients 확인 후 스크롤
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    });
  }

  void setUserInfo() async {
    String id = await loadRegisterInfo('id');
    _messageState = _messageState.copyWith(id: id);
  }

  void copyClipboard(String value) async {
    await _clipboardService.copyText(value);
  }

  void _getPushMessageHistory() async {
    String id = await loadRegisterInfo('id');
    final res = await _messageRepository.getPushMessageHistory(id: id);
    debugLog('push 확인');
    debugLog(res);
    _messageState = _messageState.copyWith(getPushMessages: res);
    notifyListeners();
    scrollToBottom();
  }

  void _subscribeToPushMessages() {
    _pushSubscription =
        _receivePushSaveService.messageStream.listen((messages) {
      _getPushMessageHistory();
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
    _getPushMessageHistory();
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
