import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/create/create_state.dart';
import 'package:push_test_app/util/date_picker_helper.dart';

class CreateViewModel extends ChangeNotifier {
  final PushRepository _pushRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final List<String> WEEKLY = ['일', '월', '화', '수', '목', '금', '토'];

  CreateState _createState = CreateState(
    selectedTime: Duration(
      hours: DateTime.now().hour,
      minutes: (DateTime.now().minute ~/ 5) * 5,
    ),
    selectedTarget: 'All',
    selectedRepeat: 'none',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  CreateState get createState => _createState;

  CreateViewModel({required PushRepository pushRepository})
      : _pushRepository = pushRepository {
    titleController.text = _createState.title;
    messageController.text = _createState.message;

    titleController.addListener(() {
      updateTitle(titleController.text);
    });
    messageController.addListener(() {
      updateMessage(messageController.text);
    });
  }

  void updateSelectedTime(Duration newTime) {
    _createState = _createState.copyWith(selectedTime: newTime);
    notifyListeners();
  }

  void updateTitle(String newTitle) {
    _createState = _createState.copyWith(title: newTitle);
    notifyListeners();
  }

  void updateMessage(String newMessage) {
    _createState = _createState.copyWith(message: newMessage);
    notifyListeners();
  }

  void updateTarget(String newTarget) {
    _createState = _createState.copyWith(selectedTarget: newTarget);
    notifyListeners();
  }

  void updateRepeat(String newRepeat) {
    DateTime newStart = _createState.startDate!;
    DateTime newEnd = _createState.endDate!;
    List<String> newDays = _createState.selectedDays;
    switch (newRepeat) {
      case 'none':
        newEnd = _createState.startDate!;
        newDays = <String>[];
        break;
      case 'daily':
        newEnd = newStart.add(const Duration(days: 7));
        newDays = <String>[];
        break;
      case 'weekly':
        newStart = DateTime.now();
        newEnd = newStart.add(const Duration(days: 30));
    }
    _createState = _createState.copyWith(
      selectedRepeat: newRepeat,
      selectedDays: newDays,
      startDate: newStart,
      endDate: newEnd,
    );
    notifyListeners();
  }

  bool updateStartDate(DateTime newStart) {
    if (_createState.selectedRepeat != 'none' &&
        newStart.isAfter(_createState.endDate!)) {
      return false;
    }
    // repeat none 이면 startDate = endDate
    DateTime newEnd = _createState.selectedRepeat == 'none'
        ? newStart
        : _createState.endDate!;
    _createState = _createState.copyWith(startDate: newStart, endDate: newEnd);
    notifyListeners();
    return true;
  }

  bool updateEndDate(DateTime newEnd) {
    if (newEnd.isBefore(_createState.startDate!)) {
      return false;
    }
    _createState = _createState.copyWith(endDate: newEnd);
    notifyListeners();
    return true;
  }

  Future<void> selectStartDate(BuildContext context) async {
    final picked = await datePicker(
        context: context, initialDate: _createState.startDate!);
    if (picked == null) return;
    if (!updateStartDate(picked)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('시작일이 종료일 다음 날로 지정될 수 없습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final picked =
        await datePicker(context: context, initialDate: _createState.endDate!);
    if (picked == null) return;
    if (!updateEndDate(picked)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('종료일이 시작일 이전 날로 지정될 수 없습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void updateSelectedDays(String day) {
    final days = List<String>.from(_createState.selectedDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    days.sort((a, b) => WEEKLY.indexOf(a).compareTo(WEEKLY.indexOf(b))); // 정렬

    _createState = _createState.copyWith(selectedDays: days);
    notifyListeners();
  }

  Future<void> createPushSchedule() async {
    if (_createState.title.isEmpty || _createState.message.isEmpty) {
      throw Exception();
    }

    final data = PushSchedule(
      id: "",
      title: _createState.title,
      message: _createState.message,
      platform: "AOS",
      userId: "Test001",
      scheduleAt: _createState.selectedTime.toString().substring(0, 5),
      target: _createState.selectedTarget,
      startTime: _createState.startDate!.toIso8601String().substring(0, 10),
      repeat: _createState.selectedRepeat,
      endTime: _createState.endDate!.toIso8601String().substring(0, 10),
      isSent: false,
      scheduleDays: _createState.selectedDays,
    );
    debugLog(data.toString());
    await _pushRepository.createPushSchedule(data);
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
