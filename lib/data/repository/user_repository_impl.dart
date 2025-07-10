import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> deleteToken(String userId) async {
    try {
      await FirebaseDatabase.instance.ref("userTokens/$userId").remove();
    } catch (e) {
      // 예외 처리 필요 시 추가
      debugLog('Failed to delete token for $userId: $e');
      rethrow;
    }
  }

  @override
  Future<String> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken ?? '';
  }

  @override
  Future<void> registerToken(String token, String userId) async {
    String platform = isPlatform();
    final now = DateTime.now().toIso8601String();
    debugLog('Registering token for user $userId: $token on $platform at $now');
    FirebaseDatabase.instance.ref("userTokens/$userId").set({
      "fcmToken": token,
      "platform": platform,
      "updatedAt": now,
    });
  }

  @override
  Future<bool> isUserTokenRegistered(String userId) async {
    final snapshot =
        await FirebaseDatabase.instance.ref("userTokens/$userId").get();
    return snapshot.exists;
  }

  @override
  Future<void> updateToken(String token, String userId) async {
    try {
      String platform = isPlatform();
      final now = DateTime.now().toIso8601String();

      debugLog('Updating token for user $userId: $token on $platform at $now');

      await FirebaseDatabase.instance.ref("userTokens/$userId").update({
        "fcmToken": token,
        "platform": platform,
        "updatedAt": now,
      });
    } catch (e) {
      debugLog('Failed to update token for $userId: $e');
      rethrow;
    }
  }
}
