import 'package:push_test_app/domain/model/receive_push_data.dart';

abstract interface class ReceivePushSaveService {
  Stream<List<ReceivePushData>> get messageStream; // 이 부분 추가
  Future<void> addPush(ReceivePushData pushData);
  Future<void> disposePush();
}
