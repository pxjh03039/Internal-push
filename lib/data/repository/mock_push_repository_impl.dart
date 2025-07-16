import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';

class MockPushRepositoryImpl implements PushRepository {
  final _mockData = [
    {
      "id": "push001",
      "title": "기상 알림",
      "message": "좋은 아침입니다! 오늘도 화이팅 ☀",
      "platform": "AOS",
      "userId": "user_aos_001",
      "target": "all",
      "scheduleAt": "07:00",
      "startTime": "07-09",
      "endTime": "07-09",
      "repeat": "none",
      "isSent": false,
      "scheduleDays": [],
    },
    {
      "id": "push002",
      "title": "점심시간 알림",
      "message": "점심 먹을 시간이에요 🍱",
      "platform": "AOS",
      "userId": "user_aos_123",
      "target": "all",
      "scheduleAt": "15:00",
      "startTime": "07-09",
      "endTime": "07-16",
      "repeat": "daily",
      "isSent": false,
      "scheduleDays": [],
    },
    {
      "id": "push003",
      "title": "일정 알림",
      "message": "18시에 운동 일정이 있어요 🏃",
      "platform": "AOS",
      "userId": "user_aos_456",
      "target": "user",
      "scheduleAt": "15:00",
      "startTime": "07-09",
      "endTime": "07-16",
      "repeat": "weekly",
      "isSent": false,
      "scheduleDays": ['Fri', 'Sat', 'Mon'],
    }
  ];
  @override
  Future<List<PushSchedule>> getPushSchedule(String id) async {
    return (await getPushSchedules()).where((e) => e.id == id).toList();
  }

  @override
  Future<List<PushSchedule>> getPushSchedules() async {
    return _mockData.map((e) => PushSchedule.fromJson(e)).toList();
  }

  @override
  Future<void> createPushSchedule(PushSchedule schedule) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePushSchedule(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePushSchedule(PushSchedule schedule) {
    throw UnimplementedError();
  }

  @override
  Future<void> registerToken() {
    throw UnimplementedError();
  }

  @override
  Stream<List<PushSchedule>> listenPushSchedules() {
    throw UnimplementedError();
  }
}
