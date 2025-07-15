// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushUser _$PushUserFromJson(Map<String, dynamic> json) => PushUser(
      id: json['id'] as String,
      group:
          (json['group'] as List<dynamic>?)?.map((e) => e as String).toList(),
      platform: json['platform'] as Map<String, dynamic>,
      pushKey:
          (json['pushKey'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PushUserToJson(PushUser instance) => <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'platform': instance.platform,
      'pushKey': instance.pushKey,
    };
