// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intro_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntroState {
  bool get isRegistered;

  /// Create a copy of IntroState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntroStateCopyWith<IntroState> get copyWith =>
      _$IntroStateCopyWithImpl<IntroState>(this as IntroState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntroState &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isRegistered);

  @override
  String toString() {
    return 'IntroState(isRegistered: $isRegistered)';
  }
}

/// @nodoc
abstract mixin class $IntroStateCopyWith<$Res> {
  factory $IntroStateCopyWith(
          IntroState value, $Res Function(IntroState) _then) =
      _$IntroStateCopyWithImpl;
  @useResult
  $Res call({bool isRegistered});
}

/// @nodoc
class _$IntroStateCopyWithImpl<$Res> implements $IntroStateCopyWith<$Res> {
  _$IntroStateCopyWithImpl(this._self, this._then);

  final IntroState _self;
  final $Res Function(IntroState) _then;

  /// Create a copy of IntroState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRegistered = null,
  }) {
    return _then(IntroState(
      isRegistered: null == isRegistered
          ? _self.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
