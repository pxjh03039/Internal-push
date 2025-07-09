import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';

class PushRepositoryImpl implements PushRepository {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref('pushSchedules');

  @override
  Future<List<PushSchedule>> getPushSchedules() async {
    final snapshot = await _dbRef.get();
    if (!snapshot.exists || snapshot.value == null) return [];

    final dataMap = Map<String, dynamic>.from(snapshot.value as Map);
    return dataMap.values
        .map((value) => PushSchedule.fromJson(Map<String, dynamic>.from(value)))
        .toList();
  }

  @override
  Future<List<PushSchedule>> getPushSchedule(String id) async {
    final snapshot =
        await _dbRef.orderByChild('id').equalTo(id).limitToFirst(1).get();

    if (!snapshot.exists || snapshot.value == null) return [];

    final dataMap = Map<String, dynamic>.from(snapshot.value as Map);
    return dataMap.values
        .map((value) => PushSchedule.fromJson(Map<String, dynamic>.from(value)))
        .toList();
  }

  @override
  Future<void> createPushSchedule(PushSchedule schedule) async {
    final newRef = _dbRef.push(); // Firebase가 고유한 키 생성
    final newId = newRef.key!;
    final newSchedule = schedule.copyWith(id: newId); // id 필드에 자동 id 넣기
    debugLog("newSchedule ${newSchedule.toString()}");

    await newRef.set(newSchedule.toJson());
  }

  @override
  Future<void> updatePushSchedule(PushSchedule schedule) async {
    await _dbRef.child(schedule.id).update(schedule.toJson());
  }

  @override
  Future<void> deletePushSchedule(String id) async {
    await _dbRef.child(id).remove();
  }
}
