import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/presentation/create/create_state.dart';
import 'package:push_test_app/util/date_picker_helper.dart';

enum CreateField {
  selectedTime,
  title,
  message,
  target,
  repeat,
  selectedDays,
  startDate,
  endDate,
}

class CreateViewModel extends ChangeNotifier {
  final PushRepository _pushRepository;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  CreateState _createState = CreateState(
    selectedTime: Duration(
      hours: DateTime.now().hour,
      minutes: (DateTime.now().minute ~/ 5) * 5,
    ),
    selectedTarget: 'All',
    selectedRepeat: 'none',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 7)),
  );

  CreateState get createState => _createState;

  CreateViewModel({required PushRepository pushRepository})
      : _pushRepository = pushRepository {
    titleController.text = createState.title;
    messageController.text = createState.message;

    titleController.addListener(() {
      setField(CreateField.title, titleController.text);
    });

    messageController.addListener(() {
      setField(CreateField.message, messageController.text);
    });
  }

  /// enum 기반 필드 업데이트 메서드 (중복 최소화)
  void setField<T>(CreateField field, T value) {
    _createState = switch (field) {
      CreateField.selectedTime =>
        createState.copyWith(selectedTime: value as Duration),
      CreateField.title => createState.copyWith(title: value as String),
      CreateField.message => createState.copyWith(message: value as String),
      CreateField.target =>
        createState.copyWith(selectedTarget: value as String),
      CreateField.repeat => createState.copyWith(
          selectedRepeat: value as String,
          selectedDays: (value as String) == 'weekly'
              ? createState.selectedDays
              : <String>[],
          endDate: (value as String) == 'none'
              ? createState.startDate!
              : (value as String) != 'none'
                  ? createState.startDate!.add(const Duration(days: 7))
                  : createState.endDate,
        ),
      CreateField.selectedDays =>
        createState.copyWith(selectedDays: value as List<String>),
      CreateField.startDate =>
        createState.copyWith(startDate: value as DateTime),
      CreateField.endDate => createState.copyWith(
          endDate: value as DateTime,
        ),
    };

    notifyListeners();
  }

  void toggleDay(String day) {
    final newDays = List<String>.from(createState.selectedDays);
    if (newDays.contains(day)) {
      newDays.remove(day);
    } else {
      newDays.add(day);
    }
    setField(CreateField.selectedDays, newDays);
  }

  Future<void> selectStartDate(BuildContext context) async {
    final picked =
        await datePicker(context: context, initialDate: createState.startDate!);

    if (picked == null) return;
    if (createState.selectedRepeat == 'none') {
      setField(CreateField.endDate, picked);
    } else if (createState.selectedRepeat != 'none' &&
        picked.isAfter(createState.endDate!)) {
      log("시작일은 종료일보다 늦을 수 없습니다.");
      log("시작일 : ${createState.startDate}");
      log("종료일 : ${createState.endDate}");
      return;
    }

    setField(CreateField.startDate, picked);
  }

  Future<void> selectEndDate(BuildContext context) async {
    final picked =
        await datePicker(context: context, initialDate: createState.endDate!);

    if (picked == null) return;
    if (picked.isBefore(createState.startDate!)) {
      log("종료일은 시작일보다 빠를 수 없습니다.");
      log("시작일 : ${createState.startDate}");
      log("종료일 : ${createState.endDate}");
      return;
    }

    setField(CreateField.endDate, picked);
  }

  void createPushSchedule() async {
    PushSchedule data = PushSchedule(
      id: "00111",
      title: _createState.title,
      message: _createState.message,
      platform: "AOS",
      userId: "Test001",
      scheduleAt: _createState.selectedTime.toString().substring(0, 5),
      target: _createState.selectedTarget,
      startTime: _createState.startDate!.toString().substring(0, 10),
      repeat: _createState.selectedRepeat,
      endTime: _createState.endDate!.toString().substring(0, 10),
      isSent: false,
      scheduleDays: _createState.selectedDays,
    );
    debugLog(data.toString());
    // createPushSchedule 데이터 필수 요소 체크
    await _pushRepository.createPushSchedule(data);
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
