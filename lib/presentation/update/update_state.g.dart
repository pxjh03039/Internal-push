// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateState _$UpdateStateFromJson(Map<String, dynamic> json) => UpdateState(
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
    );

Map<String, dynamic> _$UpdateStateToJson(UpdateState instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'selectedTarget': instance.selectedTarget,
      'selectedRepeat': instance.selectedRepeat,
      'selectedTime': instance.selectedTime.inMicroseconds,
      'selectedDays': instance.selectedDays,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
