// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) => ProfileState(
      selectedGroup: json['selectedGroup'] as String? ?? '클라이언트',
      userGroup: (json['userGroup'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      isChecked: json['isChecked'] as bool? ?? false,
      checkboxList: (json['checkboxList'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          const [],
      labelList: (json['labelList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProfileStateToJson(ProfileState instance) =>
    <String, dynamic>{
      'selectedGroup': instance.selectedGroup,
      'userGroup': instance.userGroup,
      'id': instance.id,
      'userId': instance.userId,
      'isChecked': instance.isChecked,
      'labelList': instance.labelList,
      'checkboxList': instance.checkboxList,
    };
