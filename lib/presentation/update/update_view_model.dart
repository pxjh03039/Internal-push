// update_view_model.dart

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/update/update_state.dart';

class UpdateViewModel extends ChangeNotifier {
  final PushRepository _pushRepository;
  final String scheduleId;
  final PushSchedule schedule;

  // Controllers for text fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Weekday options
  final List<String> weeklyList = ['일', '월', '화', '수', '목', '금', '토'];

  // Internal UI state
  UpdateState _updateState = UpdateState(
    title: '',
    message: '',
    selectedTime: Duration(
      hours: DateTime.now().hour,
      minutes: (DateTime.now().minute ~/ 5) * 5,
    ),
    selectedTarget: 'All',
    selectedRepeat: 'none',
    selectedDays: const [],
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );
  UpdateState get updateState => _updateState;

  UpdateViewModel({
    required PushRepository pushRepository,
    required this.scheduleId,
    required this.schedule,
  }) : _pushRepository = pushRepository {
    // Listen to controller changes
    titleController.addListener(() {
      _updateState = _updateState.copyWith(title: titleController.text);
      notifyListeners();
    });
    messageController.addListener(() {
      _updateState = _updateState.copyWith(message: messageController.text);
      notifyListeners();
    });
    debugLog(schedule);
    // Load the existing schedule
    // _loadInitialSchedule();
  }

  Future<void> _loadInitialSchedule() async {
    try {
      final list = await _pushRepository.getPushSchedule(scheduleId);
      if (list.isEmpty) return;
      final sched = list.first;

      // parse time string "HH:mm"
      final parts = sched.scheduleAt.split(':');
      final hours = int.tryParse(parts[0]) ?? 0;
      final mins = int.tryParse(parts[1]) ?? 0;

      // update state
      _updateState = UpdateState(
        title: sched.title,
        message: sched.message,
        selectedTime: Duration(hours: hours, minutes: mins),
        selectedTarget: sched.target,
        selectedRepeat: sched.repeat,
        selectedDays: sched.scheduleDays ?? const [],
        startDate: DateTime.parse(sched.startTime),
        endDate: DateTime.parse(sched.endTime),
      );

      // set controllers
      titleController.text = sched.title;
      messageController.text = sched.message;

      notifyListeners();
    } catch (e) {
      debugLog('Failed to load schedule $scheduleId: $e');
    }
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
      scheduleAt: _formatDuration(_updateState.selectedTime),
      target: _updateState.selectedTarget,
      startTime: _formatDate(_updateState.startDate!),
      repeat: _updateState.selectedRepeat,
      endTime: _formatDate(_updateState.endDate!),
      isSent: false,
      scheduleDays: _updateState.selectedDays,
    );

    debugLog('Updating schedule: $data');
    await _pushRepository.updatePushSchedule(data);
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatDate(DateTime dt) => dt.toIso8601String().substring(0, 10);

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
