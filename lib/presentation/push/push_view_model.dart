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
  String userId = '';

  final PushRepository _pushRepository;

  PushViewModel({
    required PushRepository pushRepository,
  }) : _pushRepository = pushRepository {
    controller.addListener(() {
      _onTextChanged(controller.text);
    });
    _initDeviceId();
    _schedulesSub = _pushRepository.listenPushSchedules().listen((schedules) {
      _allSchedules = schedules;
      _loadSchedules();
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
    _loadSchedules();
  }

  void _onTextChanged(String text) {
    _pushState = pushState.copyWith(query: text);
    _loadSchedules();
  }

  Future<void> deletePushSchedule(String id) async {
    await _pushRepository.deletePushSchedule(id);
    _loadSchedules();
  }

  void _loadSchedules() {
    final filterSchedules = _allSchedules.where((schedule) {
      return _matchesSearch(schedule) && _matchesRepeat(schedule);
    }).toList();

    _pushState = _pushState.copyWith(pushSchedule: filterSchedules);
    notifyListeners();
  }

  bool _matchesSearch(PushSchedule schedule) {
    final searchText = _pushState.query.trim().toLowerCase();
    if (searchText.isEmpty) return true;
    final title = schedule.title.toLowerCase();
    final message = schedule.message.toLowerCase();
    return title.contains(searchText) || message.contains(searchText);
  }

  bool _matchesRepeat(PushSchedule schedule) {
    final repeatFilter = _pushState.selectRepeat;
    if (repeatFilter == 'All') return true;
    return schedule.repeat == repeatFilter;
  }

  Future<void> _initDeviceId() async {
    userId = await getDeviceId();
    notifyListeners();
  }

  @override
  void dispose() {
    _schedulesSub.cancel();
    controller.dispose();
    super.dispose();
  }
}
