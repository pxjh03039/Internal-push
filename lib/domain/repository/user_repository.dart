abstract class UserRepository {
  Future<String> getToken();
  Future<void> registerOrUpdateUser(
      String token, String userId, String nickname);
  Future<void> registerToken(String token, String userId);
  Future<void> updateToken(String token, String userId);
  Future<void> deleteToken(String userId);
  Future<bool> isUserTokenRegistered(String userId);
  Future<List<String>> getUserGroup();
  Future<void> cleanUpDuplicatedUserId({
    required String userId,
    required String correctId,
  });
}
