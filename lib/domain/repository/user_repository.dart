abstract class UserRepository {
  Future<String> getToken();
  Future<void> registerToken(String token, String userId);
  Future<void> updateToken(String token, String userId);
  Future<void> deleteToken(String userId);
  Future<bool> isUserTokenRegistered(String userId);
}
