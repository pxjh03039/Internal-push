// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receive_push_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceivePushData {
  String? get messageId;
  String? get title;
  String? get body;
  Map<String, dynamic>? get data;
  DateTime get receivedAt;

  /// Create a copy of ReceivePushData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReceivePushDataCopyWith<ReceivePushData> get copyWith =>
      _$ReceivePushDataCopyWithImpl<ReceivePushData>(
          this as ReceivePushData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReceivePushData &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, title, body,
      const DeepCollectionEquality().hash(data), receivedAt);

  @override
  String toString() {
    return 'ReceivePushData(messageId: $messageId, title: $title, body: $body, data: $data, receivedAt: $receivedAt)';
  }
}

/// @nodoc
abstract mixin class $ReceivePushDataCopyWith<$Res> {
  factory $ReceivePushDataCopyWith(
          ReceivePushData value, $Res Function(ReceivePushData) _then) =
      _$ReceivePushDataCopyWithImpl;
  @useResult
  $Res call(
      {String? messageId,
      String? title,
      String? body,
      Map<String, dynamic>? data,
      DateTime receivedAt});
}

/// @nodoc
class _$ReceivePushDataCopyWithImpl<$Res>
    implements $ReceivePushDataCopyWith<$Res> {
  _$ReceivePushDataCopyWithImpl(this._self, this._then);

  final ReceivePushData _self;
  final $Res Function(ReceivePushData) _then;

  /// Create a copy of ReceivePushData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? data = freezed,
    Object? receivedAt = null,
  }) {
    return _then(ReceivePushData(
      messageId: freezed == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      receivedAt: null == receivedAt
          ? _self.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
