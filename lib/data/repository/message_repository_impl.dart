import 'package:push_test_app/domain/repository/message_repository.dart';

import 'package:dio/dio.dart';

final dio = Dio();

class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<void> pushSendMessage(
      {required String title,
      required String contents,
      required List<String> ids}) async {
    await dio.post('https://sendpush-iadldraf3a-uc.a.run.app/broadcast/users',
        data: {'title': title, 'body': contents, 'ids': ids});
  }
}
