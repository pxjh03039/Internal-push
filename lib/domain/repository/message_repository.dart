abstract interface class MessageRepository {
  Future<void> pushSendMessage({
    required String title,
    required String contents,
    required String id,
    required List<String> ids,
  });
  Future<void> pushSendGroupMessage({
    required String title,
    required String contents,
    required String id,
    required List<String> groups,
  });
}
