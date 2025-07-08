// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushAction {
  PushField get field;
  dynamic get value;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushActionCopyWith<PushAction> get copyWith =>
      _$PushActionCopyWithImpl<PushAction>(this as PushAction, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushAction &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, field, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'PushAction(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $PushActionCopyWith<$Res> {
  factory $PushActionCopyWith(
          PushAction value, $Res Function(PushAction) _then) =
      _$PushActionCopyWithImpl;
  @useResult
  $Res call({PushField field, dynamic value});
}

/// @nodoc
class _$PushActionCopyWithImpl<$Res> implements $PushActionCopyWith<$Res> {
  _$PushActionCopyWithImpl(this._self, this._then);

  final PushAction _self;
  final $Res Function(PushAction) _then;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as PushField,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class SetField implements PushAction {
  SetField(this.field, this.value);

  @override
  final PushField field;
  @override
  final dynamic value;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SetFieldCopyWith<SetField> get copyWith =>
      _$SetFieldCopyWithImpl<SetField>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SetField &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, field, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'PushAction.setField(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $SetFieldCopyWith<$Res>
    implements $PushActionCopyWith<$Res> {
  factory $SetFieldCopyWith(SetField value, $Res Function(SetField) _then) =
      _$SetFieldCopyWithImpl;
  @override
  @useResult
  $Res call({PushField field, dynamic value});
}

/// @nodoc
class _$SetFieldCopyWithImpl<$Res> implements $SetFieldCopyWith<$Res> {
  _$SetFieldCopyWithImpl(this._self, this._then);

  final SetField _self;
  final $Res Function(SetField) _then;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = freezed,
  }) {
    return _then(SetField(
      null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as PushField,
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
