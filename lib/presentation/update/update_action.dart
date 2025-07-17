import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_action.freezed.dart';

@freezed
sealed class UpdateAction<T> with _$UpdateAction<T> {
  factory UpdateAction.success(T data) = Success;
  factory UpdateAction.error(String e) = Error;
}
