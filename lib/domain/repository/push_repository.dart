import 'package:push_test_app/domain/model/push_schedule.dart';

abstract interface class PushRepository {
  Future<List<PushSchedule>> getPushSchedules();
  Future<List<PushSchedule>> getPushSchedule(String id);
  Future<void> createPushSchedule(PushSchedule schedule);
  Future<void> updatePushSchedule(PushSchedule schedule);
  Future<void> deletePushSchedule(String id);
  Future<void> registerToken();
  Stream<List<PushSchedule>> listenPushSchedules();
}
