// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushMessage {
  String get id;
  String get title;
  String get body;
  String get senderId;
  List<String> get receiverIds;
  List<String>? get receiverGroups; // optional
  int get timestamp;

  /// Create a copy of PushMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushMessageCopyWith<PushMessage> get copyWith =>
      _$PushMessageCopyWithImpl<PushMessage>(this as PushMessage, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            const DeepCollectionEquality()
                .equals(other.receiverIds, receiverIds) &&
            const DeepCollectionEquality()
                .equals(other.receiverGroups, receiverGroups) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      body,
      senderId,
      const DeepCollectionEquality().hash(receiverIds),
      const DeepCollectionEquality().hash(receiverGroups),
      timestamp);

  @override
  String toString() {
    return 'PushMessage(id: $id, title: $title, body: $body, senderId: $senderId, receiverIds: $receiverIds, receiverGroups: $receiverGroups, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $PushMessageCopyWith<$Res> {
  factory $PushMessageCopyWith(
          PushMessage value, $Res Function(PushMessage) _then) =
      _$PushMessageCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      String senderId,
      List<String> receiverIds,
      List<String>? receiverGroups,
      int timestamp});
}

/// @nodoc
class _$PushMessageCopyWithImpl<$Res> implements $PushMessageCopyWith<$Res> {
  _$PushMessageCopyWithImpl(this._self, this._then);

  final PushMessage _self;
  final $Res Function(PushMessage) _then;

  /// Create a copy of PushMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? senderId = null,
    Object? receiverIds = null,
    Object? receiverGroups = freezed,
    Object? timestamp = null,
  }) {
    return _then(PushMessage(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverIds: null == receiverIds
          ? _self.receiverIds
          : receiverIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      receiverGroups: freezed == receiverGroups
          ? _self.receiverGroups
          : receiverGroups // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
