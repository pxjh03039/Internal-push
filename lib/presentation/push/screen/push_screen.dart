// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/search_input_filed.dart';
import 'package:push_test_app/core/presentation/components/small_text_button_group.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PushViewModel>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hello \${uuid}',
                style: TextStyles.largeTextBold,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: SearchInputFiled(
                      controller: viewModel.controller,
                      placeHolder: "Search",
                      onChanged: (value) {
                        return viewModel
                            .onAction(PushAction.onTextChanged(value));
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorStyle.primary100),
                    child: const Icon(Icons.tune, color: ColorStyle.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SmallTextButtonGroup(
                options: const ['none', 'daily', 'weekly'],
                selectedTarget: viewModel.pushState.selectRepeat,
                onChanged: (value) {
                  viewModel.onAction(
                    PushAction.setField(PushField.selectRepeat, value),
                  );
                },
              ),
              Text(viewModel.pushState.query),
              ElevatedButton(
                  onPressed: () async {
                    // log(viewModel.pushState.pushSchedule.toString());
                    viewModel.controller.text = '2234324';

                    // final dbRef =
                    //     FirebaseDatabase.instance.ref().child('pushSchedules');

                    // final List<Map<String, dynamic>> schedules = [
                    //   {
                    //     "id": "push001",
                    //     "title": "기상 알림",
                    //     "message": "좋은 아침입니다! 오늘도 화이팅 ☀",
                    //     "platform": "AOS",
                    //     "userId": "user_aos_001",
                    //     "target": "user",
                    //     "scheduleAt": "2025-07-02T07:00:00+09:00",
                    //     "startTime": "2025-07-02T06:55:00+09:00",
                    //     "endTime": "2025-07-02T07:05:00+09:00",
                    //     "repeat": "daily",
                    //     "isSent": false
                    //   },
                    //   {
                    //     "id": "push002",
                    //     "title": "점심시간 알림",
                    //     "message": "점심 먹을 시간이에요 🍱",
                    //     "platform": "AOS",
                    //     "userId": "user_aos_123",
                    //     "target": "user",
                    //     "scheduleAt": "2025-07-02T12:00:00+09:00",
                    //     "startTime": "2025-07-02T11:55:00+09:00",
                    //     "endTime": "2025-07-02T12:05:00+09:00",
                    //     "repeat": "none",
                    //     "isSent": false
                    //   },
                    //   {
                    //     "id": "push003",
                    //     "title": "일정 알림",
                    //     "message": "18시에 운동 일정이 있어요 🏃",
                    //     "platform": "AOS",
                    //     "userId": "user_aos_456",
                    //     "target": "user",
                    //     "scheduleAt": "2025-07-02T18:00:00+09:00",
                    //     "startTime": "2025-07-02T17:55:00+09:00",
                    //     "endTime": "2025-07-02T18:10:00+09:00",
                    //     "repeat": "weekly",
                    //     "isSent": false
                    //   },
                    // ];

                    // for (var schedule in schedules) {
                    //   await dbRef.child(schedule['id']).set(schedule);
                    // }
                  },
                  child: const Text('click me'))
            ],
          ),
        )),
      ),
    );
  }
}
