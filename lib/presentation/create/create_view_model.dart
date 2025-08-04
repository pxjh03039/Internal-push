import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/create/create_state.dart';

class CreateViewModel extends ChangeNotifier {
  final PushRepository _pushRepository;
  final UserRepository _userRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final List<String> weeklyList = ['일', '월', '화', '수', '목', '금', '토'];

  CreateViewModel({
    required PushRepository pushRepository,
    required UserRepository userRepository,
  })  : _pushRepository = pushRepository,
        _userRepository = userRepository {
    titleController.text = _createState.title;
    messageController.text = _createState.message;

    titleController.addListener(() {
      createTitle(titleController.text);
    });
    messageController.addListener(() {
      createMessage(messageController.text);
    });
  }

  CreateState _createState = CreateState(
    selectedTime: Duration(
      hours: DateTime.now().hour,
      minutes: (DateTime.now().minute ~/ 30) * 30,
    ),
    selectedTarget: 'All',
    selectedRepeat: 'none',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  CreateState get createState => _createState;

  void createSelectedTime(Duration newTime) {
    _createState = _createState.copyWith(selectedTime: newTime);
    debugLog(_createState.selectedTime);
    notifyListeners();
  }

  void createTitle(String newTitle) {
    _createState = _createState.copyWith(title: newTitle);
    notifyListeners();
  }

  void createMessage(String newMessage) {
    _createState = _createState.copyWith(message: newMessage);
    notifyListeners();
  }

  void createTarget(String newTarget) {
    final prevTarget = _createState.selectedTarget;

    final newTargetList = (newTarget != prevTarget)
        ? <String>[]
        : _createState.selectedTargetList;

    _createState = _createState.copyWith(
      selectedTarget: newTarget,
      selectedTargetList: newTargetList,
    );
    notifyListeners();
  }

  void createTargetList(List<String> newTargetItem) {
    _createState = _createState.copyWith(selectedTargetList: newTargetItem);
    notifyListeners();
  }

  void createRepeat(String newRepeat) {
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

  bool createStartDate(DateTime newStart) {
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

  bool createEndDate(DateTime newEnd) {
    if (newEnd.isBefore(_createState.startDate!)) {
      return false;
    }
    _createState = _createState.copyWith(endDate: newEnd);
    notifyListeners();
    return true;
  }

  void createSelectedDays(String day) {
    final days = List<String>.from(_createState.selectedDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    days.sort((a, b) => weeklyList.indexOf(a).compareTo(weeklyList.indexOf(b)));

    _createState = _createState.copyWith(selectedDays: days);
    notifyListeners();
  }

  Future<List<String>> getGroups() async {
    return _userRepository.getUserGroup();
  }

  Future<List<String>> getUsers() async {
    return _userRepository.getUserNames();
  }

  Future<void> createPushSchedule() async {
    if (_createState.title.isEmpty || _createState.message.isEmpty) {
      throw Exception();
    }

    String userId = await getDeviceId();
    String idName = await loadRegisterInfo('id');

    final data = PushSchedule(
      id: "", // 서버에서 기본키 생성
      idName: idName,
      title: _createState.title,
      message: _createState.message,
      platform: isPlatform(),
      userId: userId,
      scheduleAt:
          _formatTime(_createState.selectedTime).toString().substring(0, 5),
      target: _createState.selectedTarget,
      startTime: _createState.startDate!.toIso8601String().substring(0, 10),
      repeat: _createState.selectedRepeat,
      endTime: _createState.endDate!.toIso8601String().substring(0, 10),
      isSent: false,
      scheduleDays: _createState.selectedDays,
      targetList: _createState.selectedTargetList,
    );
    debugLog("스케줄 생성! ${data.toString()}");
    await _pushRepository.createPushSchedule(data);
  }

  String _formatTime(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
