// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_push_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivePushData _$ReceivePushDataFromJson(Map<String, dynamic> json) =>
    ReceivePushData(
      messageId: json['messageId'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
    );

Map<String, dynamic> _$ReceivePushDataToJson(ReceivePushData instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'receivedAt': instance.receivedAt.toIso8601String(),
    };
