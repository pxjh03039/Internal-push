import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_state.freezed.dart';
part 'message_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class MessageState with _$MessageState {
  final String pushTitle;
  final String pushContents;
  final List<String> userNames;
  const MessageState(
      {this.pushTitle = "", this.pushContents = "", this.userNames = const []});

  factory MessageState.fromJson(Map<String, dynamic> json) =>
      _$MessageStateFromJson(json);
  Map<String, dynamic> toJson() => _$MessageStateToJson(this);
}
