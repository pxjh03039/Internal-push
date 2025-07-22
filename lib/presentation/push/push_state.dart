// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:push_test_app/domain/model/push_schedule.dart';

part 'push_state.freezed.dart';
part 'push_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class PushState with _$PushState {
  final String query;
  final String selectRepeat;
  final List<PushSchedule> pushSchedule;
  const PushState({
    this.query = '',
    this.selectRepeat = 'All',
    this.pushSchedule = const [],
  });

  factory PushState.fromJson(Map<String, dynamic> json) =>
      _$PushStateFromJson(json);
  Map<String, dynamic> toJson() => _$PushStateToJson(this);
}
