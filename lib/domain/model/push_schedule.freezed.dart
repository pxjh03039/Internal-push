// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushSchedule {
  String get id;
  String get title;
  String get message;
  String get platform;
  String get userId;
  String get target;
  Duration get scheduleAt;
  DateTime get startTime;
  DateTime get endTime;
  String get repeat;
  bool get isSent;
  List<String> get scheduleDays;

  /// Create a copy of PushSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushScheduleCopyWith<PushSchedule> get copyWith =>
      _$PushScheduleCopyWithImpl<PushSchedule>(
          this as PushSchedule, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushSchedule &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.scheduleAt, scheduleAt) ||
                other.scheduleAt == scheduleAt) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            const DeepCollectionEquality()
                .equals(other.scheduleDays, scheduleDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      message,
      platform,
      userId,
      target,
      scheduleAt,
      startTime,
      endTime,
      repeat,
      isSent,
      const DeepCollectionEquality().hash(scheduleDays));

  @override
  String toString() {
    return 'PushSchedule(id: $id, title: $title, message: $message, platform: $platform, userId: $userId, target: $target, scheduleAt: $scheduleAt, startTime: $startTime, endTime: $endTime, repeat: $repeat, isSent: $isSent, scheduleDays: $scheduleDays)';
  }
}

/// @nodoc
abstract mixin class $PushScheduleCopyWith<$Res> {
  factory $PushScheduleCopyWith(
          PushSchedule value, $Res Function(PushSchedule) _then) =
      _$PushScheduleCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      String platform,
      String userId,
      Duration scheduleAt,
      String target,
      DateTime startTime,
      String repeat,
      DateTime endTime,
      bool isSent,
      List<String> scheduleDays});
}

/// @nodoc
class _$PushScheduleCopyWithImpl<$Res> implements $PushScheduleCopyWith<$Res> {
  _$PushScheduleCopyWithImpl(this._self, this._then);

  final PushSchedule _self;
  final $Res Function(PushSchedule) _then;

  /// Create a copy of PushSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? platform = null,
    Object? userId = null,
    Object? scheduleAt = null,
    Object? target = null,
    Object? startTime = null,
    Object? repeat = null,
    Object? endTime = null,
    Object? isSent = null,
    Object? scheduleDays = null,
  }) {
    return _then(PushSchedule(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleAt: null == scheduleAt
          ? _self.scheduleAt
          : scheduleAt // ignore: cast_nullable_to_non_nullable
              as Duration,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      repeat: null == repeat
          ? _self.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSent: null == isSent
          ? _self.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduleDays: null == scheduleDays
          ? _self.scheduleDays
          : scheduleDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
