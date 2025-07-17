import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_state.freezed.dart';
part 'update_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class UpdateState with _$UpdateState {
  final String title;
  final String message;
  final String selectedTarget;
  final String selectedRepeat;
  final Duration selectedTime;
  final List<String> selectedDays;
  final DateTime? startDate;
  final DateTime? endDate;
  const UpdateState({
    this.title = '',
    this.message = '',
    this.selectedTarget = '',
    this.selectedTime = Duration.zero,
    this.selectedRepeat = '',
    this.selectedDays = const [],
    this.startDate,
    this.endDate,
  });

  factory UpdateState.fromJson(Map<String, dynamic> json) =>
      _$UpdateStateFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateStateToJson(this);
}
