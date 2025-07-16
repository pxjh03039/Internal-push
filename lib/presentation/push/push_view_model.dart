import 'dart:async';

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_state.dart';

import 'package:rxdart/rxdart.dart';

enum PushField {
  textChange,
  selectRepeat,
}

class PushViewModel with ChangeNotifier {
  final _eventController = BehaviorSubject<PushAction>();
  Stream<PushAction> get eventStream => _eventController.stream;
  late final StreamSubscription<List<PushSchedule>> _schedulesSub;
  List<PushSchedule> _allSchedules = [];

  final PushRepository _pushRepository;

  PushViewModel({
    required PushRepository pushRepository,
  }) : _pushRepository = pushRepository {
    controller.addListener(() {
      _onTextChanged(controller.text);
    });
    // _loadPushList();

    _schedulesSub = _pushRepository.listenPushSchedules().listen((schedules) {
      _allSchedules = schedules;
      _applyFilters();
    });
  }

  PushState _pushState = const PushState();
  PushState get pushState => _pushState;

  final TextEditingController controller = TextEditingController();

  void onAction(PushAction action) {
    switch (action) {
      case SetField():
        _handelSetField(action);
    }
  }

  void _handelSetField(SetField action) {
    _pushState = switch (action.field) {
      PushField.textChange => pushState.copyWith(query: action.value),
      PushField.selectRepeat => () {
          return pushState.copyWith(selectRepeat: action.value);
        }(),
    };
    _eventController.add(action);
    notifyListeners();
  }

  void _loadPushList() async {
    controller.text = pushState.query;

    _pushState = pushState.copyWith(
        pushSchedule: await _pushRepository.getPushSchedules());
    // var data = await _pushRepository.getPushSchedule("push002");
    debugLog(_pushState.toString());

    notifyListeners();
  }

  void _onTextChanged(String text) {
    _pushState = pushState.copyWith(query: text);
    _applyFilters();
  }

  Future<void> deletePushSchedule(String id) async {
    await _pushRepository.deletePushSchedule(id);
    _loadPushList();
  }

  void _applyFilters() {
    final searchText = _pushState.query.trim().toLowerCase();
    final filteredScheduleList = searchText.isEmpty
        ? _allSchedules
        : _allSchedules.where((schedule) {
            final searchTitle = schedule.title.toLowerCase();
            final searchContents = schedule.message.toLowerCase();
            return searchTitle.contains(searchText) ||
                searchContents.contains(searchText);
          }).toList();

    _pushState = _pushState.copyWith(pushSchedule: filteredScheduleList);
    notifyListeners();
  }

  @override
  void dispose() {
    _schedulesSub.cancel();
    controller.dispose();
    super.dispose();
  }
}
