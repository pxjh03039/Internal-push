abstract class UserRepository {
  Future<List<String>> getUserNames();
  Future<void> updateGroup(String id, String group, bool value);
  Future<Map<String, dynamic>> getRegisterInfo(String userId, String id);
  Future<String> getToken();
  Future<void> registerOrUpdateUser(
      String token, String userId, String nickname);
  Future<void> registerToken(String token, String userId);
  Future<String?> updateToken(String token, String userId);
  Future<void> deleteToken(String userId, String id);
  Future<bool> isUserTokenRegistered(String userId);
  Future<List<String>> getUserGroup();
  Future<void> cleanUpDuplicatedUserId({
    required String userId,
    required String correctId,
  });
}
