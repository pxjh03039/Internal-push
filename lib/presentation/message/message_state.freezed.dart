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
  String get pushTitle;
  String get pushContents;
  List<String> get userNames;

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
            (identical(other.pushTitle, pushTitle) ||
                other.pushTitle == pushTitle) &&
            (identical(other.pushContents, pushContents) ||
                other.pushContents == pushContents) &&
            const DeepCollectionEquality().equals(other.userNames, userNames));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pushTitle, pushContents,
      const DeepCollectionEquality().hash(userNames));

  @override
  String toString() {
    return 'MessageState(pushTitle: $pushTitle, pushContents: $pushContents, userNames: $userNames)';
  }
}

/// @nodoc
abstract mixin class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) _then) =
      _$MessageStateCopyWithImpl;
  @useResult
  $Res call({String pushTitle, String pushContents, List<String> userNames});
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
    Object? pushTitle = null,
    Object? pushContents = null,
    Object? userNames = null,
  }) {
    return _then(MessageState(
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
    ));
  }
}

// dart format on
