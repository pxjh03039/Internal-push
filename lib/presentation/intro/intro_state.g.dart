// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntroState _$IntroStateFromJson(Map<String, dynamic> json) => IntroState(
      isLoading: json['isLoading'] as bool? ?? false,
      isRegistered: json['isRegistered'] as bool? ?? false,
      titleController: json['titleController'] as String? ?? '',
      getUserGroup: (json['getUserGroup'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IntroStateToJson(IntroState instance) =>
    <String, dynamic>{
      'isRegistered': instance.isRegistered,
      'isLoading': instance.isLoading,
      'titleController': instance.titleController,
      'getUserGroup': instance.getUserGroup,
    };
