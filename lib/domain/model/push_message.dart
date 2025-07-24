import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_message.freezed.dart';
part 'push_message.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class PushMessage with _$PushMessage {
  final String id;
  final String title;
  final String body;
  final String senderId;
  final List<String> receiverIds;
  final List<String>? receiverGroups; // optional
  final int timestamp;
  const PushMessage({
    this.id = '',
    this.title = '',
    this.body = '',
    this.senderId = '',
    this.receiverIds = const [],
    this.receiverGroups = const [],
    this.timestamp = 0,
  });

  factory PushMessage.fromJson(Map<String, dynamic> json) =>
      _$PushMessageFromJson(json);
  Map<String, dynamic> toJson() => _$PushMessageToJson(this);
}
