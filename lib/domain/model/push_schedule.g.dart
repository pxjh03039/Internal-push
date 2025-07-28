// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushSchedule _$PushScheduleFromJson(Map<String, dynamic> json) => PushSchedule(
      id: json['id'] as String,
      idName: json['idName'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      platform: json['platform'] as String,
      userId: json['userId'] as String,
      scheduleAt: json['scheduleAt'] as String,
      target: json['target'] as String,
      startTime: json['startTime'] as String,
      repeat: json['repeat'] as String,
      endTime: json['endTime'] as String,
      isSent: json['isSent'] as bool,
      scheduleDays: (json['scheduleDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      targetList: (json['targetList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PushScheduleToJson(PushSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'platform': instance.platform,
      'userId': instance.userId,
      'target': instance.target,
      'scheduleAt': instance.scheduleAt,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'repeat': instance.repeat,
      'isSent': instance.isSent,
      'scheduleDays': instance.scheduleDays,
      'idName': instance.idName,
      'targetList': instance.targetList,
    };
