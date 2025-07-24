import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:push_test_app/domain/model/push_message.dart';
import 'package:push_test_app/domain/model/receive_push_data.dart';

part 'message_state.freezed.dart';
part 'message_state.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class MessageState with _$MessageState {
  final String id;
  final String pushTitle;
  final String pushContents;
  final List<String> userNames;
  final List<String> selectedUsers;
  final bool isLoading;
  final List<String> userGroup;
  final List<String> selectedGroups;
  final List<ReceivePushData> receivedPushMessages;
  final List<PushMessage> getPushMessages;
  const MessageState({
    this.id = "",
    this.getPushMessages = const [],
    this.receivedPushMessages = const [],
    this.pushTitle = "",
    this.pushContents = "",
    this.userNames = const [],
    this.selectedUsers = const [],
    this.userGroup = const [],
    this.selectedGroups = const [],
    this.isLoading = false,
  });

  factory MessageState.fromJson(Map<String, dynamic> json) =>
      _$MessageStateFromJson(json);
  Map<String, dynamic> toJson() => _$MessageStateToJson(this);
}
