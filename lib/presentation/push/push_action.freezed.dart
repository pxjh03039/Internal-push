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
  dynamic get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushAction &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'PushAction(value: $value)';
  }
}

/// @nodoc
class $PushActionCopyWith<$Res> {
  $PushActionCopyWith(PushAction _, $Res Function(PushAction) __);
}

/// @nodoc

class OnTextChanged implements PushAction {
  OnTextChanged(this.value);

  @override
  final String value;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OnTextChangedCopyWith<OnTextChanged> get copyWith =>
      _$OnTextChangedCopyWithImpl<OnTextChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OnTextChanged &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'PushAction.onTextChanged(value: $value)';
  }
}

/// @nodoc
abstract mixin class $OnTextChangedCopyWith<$Res>
    implements $PushActionCopyWith<$Res> {
  factory $OnTextChangedCopyWith(
          OnTextChanged value, $Res Function(OnTextChanged) _then) =
      _$OnTextChangedCopyWithImpl;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$OnTextChangedCopyWithImpl<$Res>
    implements $OnTextChangedCopyWith<$Res> {
  _$OnTextChangedCopyWithImpl(this._self, this._then);

  final OnTextChanged _self;
  final $Res Function(OnTextChanged) _then;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(OnTextChanged(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SetField implements PushAction {
  SetField(this.field, this.value);

  final PushField field;
  @override
  final dynamic value;

  /// Create a copy of PushAction
  /// with the given fields replaced by the non-null parameter values.
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
