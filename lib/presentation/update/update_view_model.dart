// update_view_model.dart

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/update/update_state.dart';

class UpdateViewModel extends ChangeNotifier {
  final PushRepository _pushRepository;
  final String scheduleId;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final List<String> weeklyList = ['일', '월', '화', '수', '목', '금', '토'];

  UpdateViewModel({
    required PushRepository pushRepository,
    required this.scheduleId,
  }) : _pushRepository = pushRepository {
    titleController.addListener(() {
      updateTitle(titleController.text);
    });
    messageController.addListener(() {
      updateMessage(messageController.text);
    });
    _loadInitialSchedule();
  }

  UpdateState _updateState = const UpdateState();
  UpdateState get updateState => _updateState;

  Future<void> _loadInitialSchedule() async {
    try {
      final getSchedule = await _pushRepository.getPushSchedule(scheduleId);
      if (getSchedule.isEmpty) return;

      final loadSchedule = getSchedule.first;

      final parts = loadSchedule.scheduleAt.split(':');
      final hours = int.tryParse(parts[0]) ?? 0;
      final mins = int.tryParse(parts[1]) ?? 0;

      _updateState = _updateState.copyWith(
        title: loadSchedule.title,
        message: loadSchedule.message,
        selectedTime: Duration(hours: hours, minutes: mins),
        selectedTarget: loadSchedule.target,
        selectedRepeat: loadSchedule.repeat,
        selectedDays: loadSchedule.scheduleDays ?? <String>[],
        startDate: DateTime.parse(loadSchedule.startTime),
        endDate: DateTime.parse(loadSchedule.endTime),
      );

      titleController.text = loadSchedule.title;
      messageController.text = loadSchedule.message;

      notifyListeners();
    } catch (e) {
      debugLog('Failed to load schedule $scheduleId');
    }
  }

  void updateTitle(String newTitle) {
    _updateState = _updateState.copyWith(title: newTitle);
    notifyListeners();
  }

  void updateMessage(String newMessage) {
    _updateState = _updateState.copyWith(message: newMessage);
    notifyListeners();
  }

  void updateSelectedTime(Duration newTime) {
    _updateState = _updateState.copyWith(selectedTime: newTime);
    notifyListeners();
  }

  void updateTarget(String newTarget) {
    _updateState = _updateState.copyWith(selectedTarget: newTarget);
    notifyListeners();
  }

  void updateRepeat(String newRepeat) {
    var newStart = _updateState.startDate!;
    var newEnd = _updateState.endDate!;
    List<String> newDays = List.from(_updateState.selectedDays);

    switch (newRepeat) {
      case 'none':
        newEnd = newStart;
        newDays = [];
        break;
      case 'daily':
        newEnd = newStart.add(const Duration(days: 7));
        newDays = [];
        break;
      case 'weekly':
        newEnd = newStart.add(const Duration(days: 30));
        break;
    }

    _updateState = _updateState.copyWith(
      selectedRepeat: newRepeat,
      selectedDays: newDays,
      startDate: newStart,
      endDate: newEnd,
    );
    notifyListeners();
  }

  bool updateStartDate(DateTime newStart) {
    if (_updateState.selectedRepeat != 'none' &&
        newStart.isAfter(_updateState.endDate!)) {
      return false;
    }
    final newEnd = _updateState.selectedRepeat == 'none'
        ? newStart
        : _updateState.endDate!;
    _updateState = _updateState.copyWith(
      startDate: newStart,
      endDate: newEnd,
    );
    notifyListeners();
    return true;
  }

  bool updateEndDate(DateTime newEnd) {
    if (newEnd.isBefore(_updateState.startDate!)) {
      return false;
    }
    _updateState = _updateState.copyWith(endDate: newEnd);
    notifyListeners();
    return true;
  }

  void updateSelectedDays(String day) {
    final days = List<String>.from(_updateState.selectedDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    days.sort((a, b) => weeklyList.indexOf(a).compareTo(weeklyList.indexOf(b)));
    _updateState = _updateState.copyWith(selectedDays: days);
    notifyListeners();
  }

  Future<void> updatePushSchedule() async {
    if (_updateState.title.isEmpty || _updateState.message.isEmpty) {
      throw Exception('제목과 메시지를 입력해주세요');
    }

    final data = PushSchedule(
      id: scheduleId,
      title: _updateState.title,
      message: _updateState.message,
      platform: "AOS",
      userId: "Test001",
      scheduleAt:
          _formatTime(_updateState.selectedTime).toString().substring(0, 5),
      target: _updateState.selectedTarget,
      startTime: _updateState.startDate!.toIso8601String().substring(0, 10),
      repeat: _updateState.selectedRepeat,
      endTime: _updateState.endDate!.toIso8601String().substring(0, 10),
      isSent: false,
      scheduleDays: _updateState.selectedDays,
    );

    debugLog('Updating schedule: $data');
    await _pushRepository.updatePushSchedule(data);
  }

  String _formatTime(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    debugLog(h);
    debugLog(m);
    return '$h:$m';
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
