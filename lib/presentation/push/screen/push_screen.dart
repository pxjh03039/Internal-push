// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/push_schedule_card.dart';
import 'package:push_test_app/core/presentation/components/search_input_filed.dart';
import 'package:push_test_app/core/presentation/components/small_text_button_group.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

final List<Map<String, dynamic>> items = [
  {
    "id": "id_001",
    "title": "점심 알림",
    "message": "오늘 오후 5시 Zoom 입장해주세요. 오늘 회의는 바쁩니다.",
    "platform": "AOS",
    "userId": "user_001",
    "target": "All",
    "scheduleAt": "07:00",
    "startTime": "2025-07-07",
    "endTime": "2025-07-08",
    "repeat": "daily",
    "isSent": false,
    "scheduleDays": ["월", "화", "수", "목", "금"]
  },
  {
    "id": "id_002",
    "title": "팀 미팅",
    "message": "팀 전체 회의가 예정되어 있습니다. 참석 바랍니다.",
    "platform": "AOS",
    "userId": "user_002",
    "target": "All",
    "scheduleAt": "09:00",
    "startTime": "2025-07-08",
    "endTime": "2025-07-09",
    "repeat": "weekly",
    "isSent": false,
    "scheduleDays": ["월", "수", "금"]
  },
  {
    "id": "id_003",
    "title": "개발 리뷰",
    "message": "모듈 리뷰 및 코드 정리 시간입니다.",
    "platform": "AOS",
    "userId": "user_003",
    "target": "All",
    "scheduleAt": "14:00",
    "startTime": "2025-07-09",
    "endTime": "2025-07-10",
    "repeat": "none",
    "isSent": false,
    "scheduleDays": []
  },
  {
    "id": "id_004",
    "title": "업무 종료 알림",
    "message": "오늘 업무 종료 전 마무리 점검 부탁드립니다.",
    "platform": "AOS",
    "userId": "user_004",
    "target": "All",
    "scheduleAt": "17:00",
    "startTime": "2025-07-10",
    "endTime": "2025-07-11",
    "repeat": "daily",
    "isSent": true,
    "scheduleDays": ["월", "화", "수", "목", "금"]
  },
  {
    "id": "id_005",
    "title": "업무 종료 알림",
    "message": "오늘 업무 종료 전 마무리 점검 부탁드립니다.",
    "platform": "AOS",
    "userId": "user_005",
    "target": "All",
    "scheduleAt": "17:00",
    "startTime": "2025-07-10",
    "endTime": "2025-07-11",
    "repeat": "weekly",
    "isSent": false,
    "scheduleDays": ["화", "목"]
  },
  {
    "id": "id_006",
    "title": "업무 종료 알림",
    "message": "오늘 업무 종료 전 마무리 점검 부탁드립니다.",
    "platform": "AOS",
    "userId": "user_006",
    "target": "All",
    "scheduleAt": "17:00",
    "startTime": "2025-07-10",
    "endTime": "2025-07-11",
    "repeat": "none",
    "isSent": false,
    "scheduleDays": []
  },
  {
    "id": "id_007",
    "title": "업무 종료 알림",
    "message": "오늘 업무 종료 전 마무리 점검 부탁드립니다.",
    "platform": "AOS",
    "userId": "user_007",
    "target": "All",
    "scheduleAt": "17:00",
    "startTime": "2025-07-10",
    "endTime": "2025-07-11",
    "repeat": "daily",
    "isSent": true,
    "scheduleDays": ["월", "화", "수", "목", "금"]
  }
];

class PushScreen extends StatelessWidget {
  PushScreen({
    super.key,
  });

  final List<PushSchedule> pushSchedules = items.asMap().entries.map((entry) {
    final idx = entry.key;
    final map = entry.value;
    return PushSchedule(
      id: 'id_$idx',
      title: map['title'] ?? '',
      message: map['description'] ?? '',
      platform: 'AOS', // 임의 값
      userId: 'user_$idx', // 임의 값
      target: 'All', // 임의 값
      scheduleAt: map['time'] ?? '',
      startTime: map['dateRange'] ?? '',
      endTime: map['dateRange'] ?? '',
      repeat: 'none', // 임의 값
      isSent: false, // 기본 false
      scheduleDays: [], // 빈 리스트
    );
  }).toList();

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
                        return viewModel.onAction(
                            PushAction.setField(PushField.textChange, value));
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
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, // 각 칸 최대 너비 고정
                    mainAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 12,
                  ),
                  itemCount: pushSchedules.length,
                  itemBuilder: (context, index) {
                    final PushSchedule item = pushSchedules[index];
                    return PushScheduleCard(
                      pushSchedule: item,
                    );
                  },
                ),
              ),
              //   Text(viewModel.pushState.query),
              //   ElevatedButton(
              //       onPressed: () async {
              //         // log(viewModel.pushState.pushSchedule.toString());
              //         viewModel.controller.text = '2234324';

              //         final dbRef =
              //             FirebaseDatabase.instance.ref().child('pushSchedules');

              //         final List<Map<String, dynamic>> schedules = [
              //           {
              //             "id": "push001",
              //             "title": "기상 알림",
              //             "message": "좋은 아침입니다! 오늘도 화이팅 ☀",
              //             "platform": "AOS",
              //             "userId": "user_aos_001",
              //             "target": "user",
              //             "scheduleAt": "2025-07-02T07:00:00+09:00",
              //             "startTime": "2025-07-02T06:55:00+09:00",
              //             "endTime": "2025-07-02T07:05:00+09:00",
              //             "repeat": "daily",
              //             "isSent": false
              //           },
              //           {
              //             "id": "push002",
              //             "title": "점심시간 알림",
              //             "message": "점심 먹을 시간이에요 🍱",
              //             "platform": "AOS",
              //             "userId": "user_aos_123",
              //             "target": "user",
              //             "scheduleAt": "2025-07-02T12:00:00+09:00",
              //             "startTime": "2025-07-02T11:55:00+09:00",
              //             "endTime": "2025-07-02T12:05:00+09:00",
              //             "repeat": "none",
              //             "isSent": false
              //           },
              //           {
              //             "id": "push003",
              //             "title": "일정 알림",
              //             "message": "18시에 운동 일정이 있어요 🏃",
              //             "platform": "AOS",
              //             "userId": "user_aos_456",
              //             "target": "user",
              //             "scheduleAt": "2025-07-02T18:00:00+09:00",
              //             "startTime": "2025-07-02T17:55:00+09:00",
              //             "endTime": "2025-07-02T18:10:00+09:00",
              //             "repeat": "weekly",
              //             "isSent": false
              //           },
              //         ];

              //         for (var schedule in schedules) {
              //           await dbRef.child(schedule['id']).set(schedule);
              //         }
              //       },
              //       child: const Text('click me'))
            ],
          ),
        )),
      ),
    );
  }
}
