// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushMessage _$PushMessageFromJson(Map<String, dynamic> json) => PushMessage(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      receiverIds: (json['receiverIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      receiverGroups: (json['receiverGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PushMessageToJson(PushMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'senderId': instance.senderId,
      'receiverIds': instance.receiverIds,
      'receiverGroups': instance.receiverGroups,
      'timestamp': instance.timestamp,
    };
