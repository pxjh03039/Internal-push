import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';
part 'profile_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class ProfileState with _$ProfileState {
  final String selectedGroup;
  final List<String> userGroup;
  final String id;
  final String userId;
  final bool isChecked;
  final List<String> labelList;
  final List<bool> checkboxList;
  const ProfileState({
    this.selectedGroup = '클라이언트',
    this.userGroup = const [],
    this.id = '',
    this.userId = '',
    this.isChecked = false,
    this.checkboxList = const [],
    this.labelList = const [],
  });

  factory ProfileState.fromJson(Map<String, dynamic> json) =>
      _$ProfileStateFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileStateToJson(this);
}
