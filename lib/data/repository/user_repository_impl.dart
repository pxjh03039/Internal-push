import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_user.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final db = FirebaseDatabase.instance;

  @override
  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
  }

  @override
  Future<void> registerToken(String token, String userId) async {
    final platform = isPlatform();
    final now = DateTime.now().toIso8601String();

    await db.ref("userTokens/$userId").set({
      "fcmToken": token,
      "platform": platform,
      "updatedAt": now,
    });
  }

  @override
  Future<bool> isUserTokenRegistered(String userId) async {
    final snapshot = await db.ref("userTokens/$userId").get();
    return snapshot.exists;
  }

  @override
  Future<void> registerOrUpdateUser(
    String token,
    String userId,
    String id,
  ) async {
    final now = DateTime.now().toIso8601String();
    final platform = isPlatform();
    final userRef = db.ref("userInfos/$id");

    await cleanUpDuplicatedUserId(userId: userId, correctId: id);

    final newData = {
      "userId": userId,
      "pushKey": token,
      "updatedAt": now,
      "platform": platform,
    };

    final snapshot = await userRef.get();

    if (snapshot.exists) {
      await userRef.child("registerIds/$userId").set(newData);
    } else {
      final newUser = PushUser(
        id: id,
        group: [],
        registerIds: {userId: newData},
      );
      await userRef.set(newUser.toJson());
    }

    await db.ref("userTokens/$userId").set({
      "id": id,
      "registerIds": userId,
      "fcmToken": token,
      "updatedAt": now,
    });
  }

  @override
  Future<String?> updateToken(String token, String userId) async {
    final now = DateTime.now().toIso8601String();
    final platform = isPlatform();

    // 🔄 userTokens 갱신
    await db.ref("userTokens/$userId").update({
      "fcmToken": token,
      "platform": platform,
      "updatedAt": now,
    });

    // 🔍 token 기준으로 사용자 id 조회 및 업데이트
    final allUsersSnap = await db.ref("userInfos").get();
    if (!allUsersSnap.exists) return null;

    final allUsers = Map<String, dynamic>.from(allUsersSnap.value as Map);

    for (final entry in allUsers.entries) {
      final userKey = entry.key;
      final userData = Map<String, dynamic>.from(entry.value);

      if (userData.containsKey("registerIds")) {
        final registerIds = Map<String, dynamic>.from(userData["registerIds"]);

        if (registerIds.containsKey(userId)) {
          final regData = Map<String, dynamic>.from(registerIds[userId]);

          // ✅ pushKey, updatedAt, platform 업데이트
          regData["pushKey"] = token;
          regData["updatedAt"] = now;
          regData["platform"] = platform;

          // 🔄 Firebase 반영
          registerIds[userId] = regData;
          await db.ref("userInfos/$userKey/registerIds").set(registerIds);

          debugLog("📝 userInfos/$userKey → registerIds.$userId 토큰 업데이트 완료");
          return userKey;
        }
      }
    }

    debugLog("⚠️ userId '$userId'에 해당하는 registerIds 없음");
    return null;
  }

  @override
  Future<void> deleteToken(String userId, String id) async {
    try {
      await db.ref("userTokens/$userId").remove();
      debugLog("🧹 userTokens/$userId 삭제 완료");

      final userRef = db.ref("userInfos/$id");
      final userSnap = await userRef.get();
      if (!userSnap.exists) return;

      await userRef.child("registerIds/$userId").remove();
      debugLog("🧹 userInfos/$id/registerIds/$userId 삭제 완료");

      final registerIdsSnap = await userRef.child("registerIds").get();
      if (!registerIdsSnap.exists || (registerIdsSnap.value as Map).isEmpty) {
        await userRef.remove();
        debugLog("🧹 userInfos/$id 전체 삭제 (registerIds 없음)");
      }
    } catch (e) {
      debugLog("❌ deleteToken 실패: $e");
      rethrow;
    }
  }

  @override
  Future<void> cleanUpDuplicatedUserId({
    required String userId,
    required String correctId,
  }) async {
    final tokenSnap = await db.ref("userTokens/$userId").get();
    if (!tokenSnap.exists) return;

    final existingId = (tokenSnap.value as Map)['id'];
    if (existingId == correctId) return;

    final allUsersSnap = await db.ref("userInfos").get();
    if (!allUsersSnap.exists) return;

    final allUsers = Map<String, dynamic>.from(allUsersSnap.value as Map);
    for (final entry in allUsers.entries) {
      final userKey = entry.key;
      final userData = Map<String, dynamic>.from(entry.value);

      if (userData.containsKey("registerIds")) {
        final registerIds = Map<String, dynamic>.from(userData["registerIds"]);
        if (registerIds.containsKey(userId)) {
          await db.ref("userInfos/$userKey/registerIds/$userId").remove();
          debugLog("🧹 중복 제거: $userKey → registerIds/$userId 삭제");
        }
      }
    }

    await db.ref("userTokens/$userId").remove();
    debugLog("🧹 userTokens/$userId 제거 완료 (중복)");
  }

  @override
  Future<Map<String, dynamic>> getRegisterInfo(String userId, String id) async {
    final userRef = db.ref("userInfos/$id");
    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      throw Exception("❌ 사용자 '$id' 정보가 없습니다.");
    }

    final userData = Map<String, dynamic>.from(snapshot.value as Map);

    // registerIds 필드 파싱
    if (!userData.containsKey("registerIds")) {
      throw Exception("❌ 사용자 '$id'의 registerIds 필드가 없습니다.");
    }

    final registerIds = Map<String, dynamic>.from(userData["registerIds"]);

    if (!registerIds.containsKey(userId)) {
      throw Exception("❌ userId '$userId'에 대한 정보가 없습니다.");
    }

    return Map<String, dynamic>.from(registerIds[userId]);
  }

  @override
  Future<List<String>> getUserGroup() async {
    try {
      final snap = await db.ref("userGroup").get();
      if (!snap.exists) return [];

      // snap.value가 List<dynamic>이라고 가정하고 직접 캐스팅
      final List<dynamic> rawList = snap.value as List;
      return rawList.map((e) => e.toString()).toList();
    } catch (e) {
      debugLog('getUserGroup 오류: $e');
      return [];
    }
  }
}
