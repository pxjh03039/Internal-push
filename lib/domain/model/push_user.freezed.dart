// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushUser {
  String get id;
  List<String>? get group;
  Map<String, dynamic> get registerIds;

  /// Create a copy of PushUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushUserCopyWith<PushUser> get copyWith =>
      _$PushUserCopyWithImpl<PushUser>(this as PushUser, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushUser &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.group, group) &&
            const DeepCollectionEquality()
                .equals(other.registerIds, registerIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(group),
      const DeepCollectionEquality().hash(registerIds));

  @override
  String toString() {
    return 'PushUser(id: $id, group: $group, registerIds: $registerIds)';
  }
}

/// @nodoc
abstract mixin class $PushUserCopyWith<$Res> {
  factory $PushUserCopyWith(PushUser value, $Res Function(PushUser) _then) =
      _$PushUserCopyWithImpl;
  @useResult
  $Res call({String id, List<String>? group, Map<String, dynamic> registerIds});
}

/// @nodoc
class _$PushUserCopyWithImpl<$Res> implements $PushUserCopyWith<$Res> {
  _$PushUserCopyWithImpl(this._self, this._then);

  final PushUser _self;
  final $Res Function(PushUser) _then;

  /// Create a copy of PushUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? group = freezed,
    Object? registerIds = null,
  }) {
    return _then(PushUser(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      registerIds: null == registerIds
          ? _self.registerIds
          : registerIds // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
