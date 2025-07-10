import 'package:freezed_annotation/freezed_annotation.dart';

part 'intro_state.freezed.dart';
part 'intro_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class IntroState with _$IntroState {
  final bool isRegistered;
  const IntroState({
    this.isRegistered = false,
  });

  factory IntroState.fromJson(Map<String, dynamic> json) =>
      _$IntroStateFromJson(json);
  Map<String, dynamic> toJson() => _$IntroStateToJson(this);
}
