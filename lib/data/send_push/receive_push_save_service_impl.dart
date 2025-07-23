import 'package:push_test_app/domain/model/receive_push_data.dart';
import 'package:push_test_app/domain/send_push/receive_push_save_service.dart';
import 'package:rxdart/rxdart.dart';

class ReceivePushSaveServiceImpl implements ReceivePushSaveService {
  final _controller = BehaviorSubject<List<ReceivePushData>>();

  @override
  Future<void> addPush(ReceivePushData pushData) async {
    final currentList = _controller.valueOrNull ?? [];
    final updatedList = [pushData, ...currentList];
    _controller.add(updatedList);
  }

  @override
  Future<void> disposePush() async {
    _controller.close();
  }

  @override
  Stream<List<ReceivePushData>> get messageStream => _controller.stream;
}
