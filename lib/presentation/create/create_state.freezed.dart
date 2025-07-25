// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateState {
  String get title;
  String get message;
  String get selectedTarget;
  String get selectedRepeat;
  Duration get selectedTime;
  List<String> get selectedDays;
  DateTime? get startDate;
  DateTime? get endDate;
  List<String> get selectedGroups;
  List<String> get selectedUsers;

  /// Create a copy of CreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateStateCopyWith<CreateState> get copyWith =>
      _$CreateStateCopyWithImpl<CreateState>(this as CreateState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedTarget, selectedTarget) ||
                other.selectedTarget == selectedTarget) &&
            (identical(other.selectedRepeat, selectedRepeat) ||
                other.selectedRepeat == selectedRepeat) &&
            (identical(other.selectedTime, selectedTime) ||
                other.selectedTime == selectedTime) &&
            const DeepCollectionEquality()
                .equals(other.selectedDays, selectedDays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other.selectedGroups, selectedGroups) &&
            const DeepCollectionEquality()
                .equals(other.selectedUsers, selectedUsers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      message,
      selectedTarget,
      selectedRepeat,
      selectedTime,
      const DeepCollectionEquality().hash(selectedDays),
      startDate,
      endDate,
      const DeepCollectionEquality().hash(selectedGroups),
      const DeepCollectionEquality().hash(selectedUsers));

  @override
  String toString() {
    return 'CreateState(title: $title, message: $message, selectedTarget: $selectedTarget, selectedRepeat: $selectedRepeat, selectedTime: $selectedTime, selectedDays: $selectedDays, startDate: $startDate, endDate: $endDate, selectedGroups: $selectedGroups, selectedUsers: $selectedUsers)';
  }
}

/// @nodoc
abstract mixin class $CreateStateCopyWith<$Res> {
  factory $CreateStateCopyWith(
          CreateState value, $Res Function(CreateState) _then) =
      _$CreateStateCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String message,
      String selectedTarget,
      Duration selectedTime,
      String selectedRepeat,
      List<String> selectedDays,
      DateTime? startDate,
      DateTime? endDate,
      List<String> selectedGroups,
      List<String> selectedUsers});
}

/// @nodoc
class _$CreateStateCopyWithImpl<$Res> implements $CreateStateCopyWith<$Res> {
  _$CreateStateCopyWithImpl(this._self, this._then);

  final CreateState _self;
  final $Res Function(CreateState) _then;

  /// Create a copy of CreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? selectedTarget = null,
    Object? selectedTime = null,
    Object? selectedRepeat = null,
    Object? selectedDays = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedGroups = null,
    Object? selectedUsers = null,
  }) {
    return _then(CreateState(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTarget: null == selectedTarget
          ? _self.selectedTarget
          : selectedTarget // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTime: null == selectedTime
          ? _self.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      selectedRepeat: null == selectedRepeat
          ? _self.selectedRepeat
          : selectedRepeat // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDays: null == selectedDays
          ? _self.selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedGroups: null == selectedGroups
          ? _self.selectedGroups
          : selectedGroups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedUsers: null == selectedUsers
          ? _self.selectedUsers
          : selectedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
