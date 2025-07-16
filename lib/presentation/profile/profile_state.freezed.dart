// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileState {
  String get selectedGroup;
  List<String> get userGroup;
  String get id;
  String get userId;
  bool get isChecked;
  List<String> get labelList;
  List<bool> get checkboxList;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      _$ProfileStateCopyWithImpl<ProfileState>(
          this as ProfileState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileState &&
            (identical(other.selectedGroup, selectedGroup) ||
                other.selectedGroup == selectedGroup) &&
            const DeepCollectionEquality().equals(other.userGroup, userGroup) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            const DeepCollectionEquality().equals(other.labelList, labelList) &&
            const DeepCollectionEquality()
                .equals(other.checkboxList, checkboxList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedGroup,
      const DeepCollectionEquality().hash(userGroup),
      id,
      userId,
      isChecked,
      const DeepCollectionEquality().hash(labelList),
      const DeepCollectionEquality().hash(checkboxList));

  @override
  String toString() {
    return 'ProfileState(selectedGroup: $selectedGroup, userGroup: $userGroup, id: $id, userId: $userId, isChecked: $isChecked, labelList: $labelList, checkboxList: $checkboxList)';
  }
}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) _then) =
      _$ProfileStateCopyWithImpl;
  @useResult
  $Res call(
      {String selectedGroup,
      List<String> userGroup,
      String id,
      String userId,
      bool isChecked,
      List<bool> checkboxList,
      List<String> labelList});
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res> implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGroup = null,
    Object? userGroup = null,
    Object? id = null,
    Object? userId = null,
    Object? isChecked = null,
    Object? checkboxList = null,
    Object? labelList = null,
  }) {
    return _then(ProfileState(
      selectedGroup: null == selectedGroup
          ? _self.selectedGroup
          : selectedGroup // ignore: cast_nullable_to_non_nullable
              as String,
      userGroup: null == userGroup
          ? _self.userGroup
          : userGroup // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _self.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      checkboxList: null == checkboxList
          ? _self.checkboxList
          : checkboxList // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      labelList: null == labelList
          ? _self.labelList
          : labelList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
