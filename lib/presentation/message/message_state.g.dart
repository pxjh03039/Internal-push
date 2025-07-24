// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageState _$MessageStateFromJson(Map<String, dynamic> json) => MessageState(
      id: json['id'] as String? ?? "",
      getPushMessages: (json['getPushMessages'] as List<dynamic>?)
              ?.map((e) => PushMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      receivedPushMessages: (json['receivedPushMessages'] as List<dynamic>?)
              ?.map((e) => ReceivePushData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pushTitle: json['pushTitle'] as String? ?? "",
      pushContents: json['pushContents'] as String? ?? "",
      userNames: (json['userNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      selectedUsers: (json['selectedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userGroup: (json['userGroup'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      selectedGroups: (json['selectedGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageStateToJson(MessageState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pushTitle': instance.pushTitle,
      'pushContents': instance.pushContents,
      'userNames': instance.userNames,
      'selectedUsers': instance.selectedUsers,
      'isLoading': instance.isLoading,
      'userGroup': instance.userGroup,
      'selectedGroups': instance.selectedGroups,
      'receivedPushMessages': instance.receivedPushMessages,
      'getPushMessages': instance.getPushMessages,
    };
