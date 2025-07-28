// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateState _$CreateStateFromJson(Map<String, dynamic> json) => CreateState(
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      selectedTarget: json['selectedTarget'] as String? ?? '',
      selectedTime: json['selectedTime'] == null
          ? Duration.zero
          : Duration(microseconds: (json['selectedTime'] as num).toInt()),
      selectedRepeat: json['selectedRepeat'] as String? ?? '',
      selectedDays: (json['selectedDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      selectedTargetList: (json['selectedTargetList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CreateStateToJson(CreateState instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'selectedTarget': instance.selectedTarget,
      'selectedRepeat': instance.selectedRepeat,
      'selectedTime': instance.selectedTime.inMicroseconds,
      'selectedDays': instance.selectedDays,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'selectedTargetList': instance.selectedTargetList,
    };
