import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_state.dart';

enum PushField {
  textChange,
  selectRepeat,
}

class PushViewModel with ChangeNotifier {
  final PushRepository _pushRepository;

  PushViewModel({
    required PushRepository pushRepository,
  }) : _pushRepository = pushRepository {
    controller.addListener(() {
      _onTextChanged(controller.text);
    });
    _loadPushList();
  }

  PushState _pushState = const PushState();
  PushState get pushState => _pushState;

  final TextEditingController controller = TextEditingController();

  void onAction(PushAction action) {
    switch (action) {
      case SetField():
        _handelSetField(action);
      case OnTextChanged():
        _onTextChanged(action.value);
    }
  }

  void _handelSetField(SetField action) {
    _pushState = switch (action.field) {
      PushField.textChange => pushState.copyWith(query: action.value),
      PushField.selectRepeat => () {
          debugLog(action.value);
          return pushState.copyWith(selectRepeat: action.value);
        }(),
    };
    notifyListeners();
  }

  void _loadPushList() async {
    controller.text = pushState.query;

    _pushState = pushState.copyWith(
        pushSchedule: await _pushRepository.getPushSchedules());
    var data = await _pushRepository.getPushSchedule("push002");
    log(data.toString());

    notifyListeners();
  }

  void _onTextChanged(String text) {
    _pushState = pushState.copyWith(query: text);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
