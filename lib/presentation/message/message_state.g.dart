// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageState _$MessageStateFromJson(Map<String, dynamic> json) => MessageState(
      pushTitle: json['pushTitle'] as String? ?? "",
      pushContents: json['pushContents'] as String? ?? "",
      userNames: (json['userNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageStateToJson(MessageState instance) =>
    <String, dynamic>{
      'pushTitle': instance.pushTitle,
      'pushContents': instance.pushContents,
      'userNames': instance.userNames,
      'isLoading': instance.isLoading,
    };
