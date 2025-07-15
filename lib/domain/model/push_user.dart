import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_user.freezed.dart';
part 'push_user.g.dart';

// ignore_for_file: annotate_overrides
@freezed
@JsonSerializable()
class PushUser with _$PushUser {
  final String id;
  final List<String>? group;
  final Map<String, dynamic> platform;
  final List<String> pushKey;
  const PushUser({
    required this.id,
    this.group,
    required this.platform,
    required this.pushKey,
  });

  factory PushUser.fromJson(Map<String, dynamic> json) =>
      _$PushUserFromJson(json);
  Map<String, dynamic> toJson() => _$PushUserToJson(this);
}
