import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_state.freezed.dart';
part 'create_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class CreateState with _$CreateState {
  final String title;
  final String message;
  final String selectedTarget;
  final String selectedRepeat;
  final Duration selectedTime;
  final List<String> selectedDays;
  final DateTime? startDate;
  final DateTime? endDate;
  const CreateState({
    this.title = '',
    this.message = '',
    this.selectedTarget = '',
    this.selectedTime = Duration.zero,
    this.selectedRepeat = '',
    this.selectedDays = const [],
    this.startDate,
    this.endDate,
  });

  factory CreateState.fromJson(Map<String, dynamic> json) =>
      _$CreateStateFromJson(json);
  Map<String, dynamic> toJson() => _$CreateStateToJson(this);
}
