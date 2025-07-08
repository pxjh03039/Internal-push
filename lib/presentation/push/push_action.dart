import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';

part 'push_action.freezed.dart';

@freezed
sealed class PushAction with _$PushAction {
  factory PushAction.setField(PushField field, dynamic value) = SetField;
}
