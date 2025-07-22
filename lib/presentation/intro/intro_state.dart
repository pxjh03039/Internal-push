import 'package:freezed_annotation/freezed_annotation.dart';

part 'intro_state.freezed.dart';
part 'intro_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class IntroState with _$IntroState {
  final bool isRegistered;
  final bool isLoading;
  final String titleController;
  final List<String> getUserGroup;
  const IntroState({
    this.isLoading = false,
    this.isRegistered = false,
    this.titleController = '',
    this.getUserGroup = const [],
  });

  factory IntroState.fromJson(Map<String, dynamic> json) =>
      _$IntroStateFromJson(json);
  Map<String, dynamic> toJson() => _$IntroStateToJson(this);
}
