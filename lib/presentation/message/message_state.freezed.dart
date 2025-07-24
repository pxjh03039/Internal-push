// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageState {
  String get id;
  String get pushTitle;
  String get pushContents;
  List<String> get userNames;
  List<String> get selectedUsers;
  bool get isLoading;
  List<String> get userGroup;
  List<String> get selectedGroups;
  List<ReceivePushData> get receivedPushMessages;
  List<PushMessage> get getPushMessages;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStateCopyWith<MessageState> get copyWith =>
      _$MessageStateCopyWithImpl<MessageState>(
          this as MessageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pushTitle, pushTitle) ||
                other.pushTitle == pushTitle) &&
            (identical(other.pushContents, pushContents) ||
                other.pushContents == pushContents) &&
            const DeepCollectionEquality().equals(other.userNames, userNames) &&
            const DeepCollectionEquality()
                .equals(other.selectedUsers, selectedUsers) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.userGroup, userGroup) &&
            const DeepCollectionEquality()
                .equals(other.selectedGroups, selectedGroups) &&
            const DeepCollectionEquality()
                .equals(other.receivedPushMessages, receivedPushMessages) &&
            const DeepCollectionEquality()
                .equals(other.getPushMessages, getPushMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pushTitle,
      pushContents,
      const DeepCollectionEquality().hash(userNames),
      const DeepCollectionEquality().hash(selectedUsers),
      isLoading,
      const DeepCollectionEquality().hash(userGroup),
      const DeepCollectionEquality().hash(selectedGroups),
      const DeepCollectionEquality().hash(receivedPushMessages),
      const DeepCollectionEquality().hash(getPushMessages));

  @override
  String toString() {
    return 'MessageState(id: $id, pushTitle: $pushTitle, pushContents: $pushContents, userNames: $userNames, selectedUsers: $selectedUsers, isLoading: $isLoading, userGroup: $userGroup, selectedGroups: $selectedGroups, receivedPushMessages: $receivedPushMessages, getPushMessages: $getPushMessages)';
  }
}

/// @nodoc
abstract mixin class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) _then) =
      _$MessageStateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      List<PushMessage> getPushMessages,
      List<ReceivePushData> receivedPushMessages,
      String pushTitle,
      String pushContents,
      List<String> userNames,
      List<String> selectedUsers,
      List<String> userGroup,
      List<String> selectedGroups,
      bool isLoading});
}

/// @nodoc
class _$MessageStateCopyWithImpl<$Res> implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._self, this._then);

  final MessageState _self;
  final $Res Function(MessageState) _then;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? getPushMessages = null,
    Object? receivedPushMessages = null,
    Object? pushTitle = null,
    Object? pushContents = null,
    Object? userNames = null,
    Object? selectedUsers = null,
    Object? userGroup = null,
    Object? selectedGroups = null,
    Object? isLoading = null,
  }) {
    return _then(MessageState(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      getPushMessages: null == getPushMessages
          ? _self.getPushMessages
          : getPushMessages // ignore: cast_nullable_to_non_nullable
              as List<PushMessage>,
      receivedPushMessages: null == receivedPushMessages
          ? _self.receivedPushMessages
          : receivedPushMessages // ignore: cast_nullable_to_non_nullable
              as List<ReceivePushData>,
      pushTitle: null == pushTitle
          ? _self.pushTitle
          : pushTitle // ignore: cast_nullable_to_non_nullable
              as String,
      pushContents: null == pushContents
          ? _self.pushContents
          : pushContents // ignore: cast_nullable_to_non_nullable
              as String,
      userNames: null == userNames
          ? _self.userNames
          : userNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedUsers: null == selectedUsers
          ? _self.selectedUsers
          : selectedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userGroup: null == userGroup
          ? _self.userGroup
          : userGroup // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedGroups: null == selectedGroups
          ? _self.selectedGroups
          : selectedGroups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
