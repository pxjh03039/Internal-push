import 'package:freezed_annotation/freezed_annotation.dart';

part 'receive_push_data.freezed.dart';
part 'receive_push_data.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class ReceivePushData with _$ReceivePushData {
  final String? messageId;
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final DateTime receivedAt;
  const ReceivePushData({
    this.messageId,
    this.title,
    this.body,
    this.data,
    required this.receivedAt,
  });

  factory ReceivePushData.fromJson(Map<String, dynamic> json) =>
      _$ReceivePushDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReceivePushDataToJson(this);
}
