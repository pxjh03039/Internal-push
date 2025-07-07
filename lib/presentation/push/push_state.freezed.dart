// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushState {
  String get query;
  String get selectRepeat;
  List<PushSchedule> get pushSchedule;

  /// Create a copy of PushState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushStateCopyWith<PushState> get copyWith =>
      _$PushStateCopyWithImpl<PushState>(this as PushState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.selectRepeat, selectRepeat) ||
                other.selectRepeat == selectRepeat) &&
            const DeepCollectionEquality()
                .equals(other.pushSchedule, pushSchedule));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, query, selectRepeat,
      const DeepCollectionEquality().hash(pushSchedule));

  @override
  String toString() {
    return 'PushState(query: $query, selectRepeat: $selectRepeat, pushSchedule: $pushSchedule)';
  }
}

/// @nodoc
abstract mixin class $PushStateCopyWith<$Res> {
  factory $PushStateCopyWith(PushState value, $Res Function(PushState) _then) =
      _$PushStateCopyWithImpl;
  @useResult
  $Res call(
      {String query, String selectRepeat, List<PushSchedule> pushSchedule});
}

/// @nodoc
class _$PushStateCopyWithImpl<$Res> implements $PushStateCopyWith<$Res> {
  _$PushStateCopyWithImpl(this._self, this._then);

  final PushState _self;
  final $Res Function(PushState) _then;

  /// Create a copy of PushState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? selectRepeat = null,
    Object? pushSchedule = null,
  }) {
    return _then(PushState(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      selectRepeat: null == selectRepeat
          ? _self.selectRepeat
          : selectRepeat // ignore: cast_nullable_to_non_nullable
              as String,
      pushSchedule: null == pushSchedule
          ? _self.pushSchedule
          : pushSchedule // ignore: cast_nullable_to_non_nullable
              as List<PushSchedule>,
    ));
  }
}

// dart format on
