abstract interface class MessageRepository {
  Future<void> pushSendMessage({
    required String title,
    required String contents,
    required List<String> ids,
  });
}
