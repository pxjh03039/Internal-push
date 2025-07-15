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
      final db = FirebaseDatabase.instance;
      final now = DateTime.now().toIso8601String();
      final platform = isPlatform();

      debugLog('🔄 Updating token for $userId on $platform');

      // ✅ 먼저 userTokens 인덱스 갱신
      await db.ref("userTokens/$userId").update({
        "fcmToken": token,
        "platform": platform,
        "updatedAt": now,
      });

      // ✅ userInfos 전체 조회하여 userId가 있는 곳 찾기
      final allUsersSnap = await db.ref("userInfos").get();
      if (allUsersSnap.exists) {
        final allUsers = Map<String, dynamic>.from(allUsersSnap.value as Map);

        for (final entry in allUsers.entries) {
          final userKey = entry.key;
          final userData = Map<String, dynamic>.from(entry.value);

          if (userData.containsKey("platform")) {
            final platformMap = Map<String, dynamic>.from(userData["platform"]);

            bool updated = false;

            for (final platformKey in platformMap.keys) {
              final rawPlatform =
                  Map<String, dynamic>.from(platformMap[platformKey]);

              if (rawPlatform["userId"] == userId) {
                // ✅ 해당 플랫폼만 pushKey, updatedAt 갱신 (userId는 그대로 유지)
                rawPlatform["pushKey"] = token;
                rawPlatform["updatedAt"] = now;
                platformMap[platformKey] = rawPlatform;

                updated = true;
                break;
              }
            }

            if (updated) {
              final updatedUser = {
                "id": userData["id"],
                "group": userData["group"] ?? [],
                "platform": platformMap,
              };

              await db.ref("userInfos/$userKey").set(updatedUser);
              debugLog("📝 userInfos/$userKey → 플랫폼 토큰 업데이트 완료");
              return;
            }
          }
        }
      }

      debugLog("⚠️ userId '$userId'에 해당하는 userInfos 내 플랫폼 정보가 없음");
    } catch (e) {
      debugLog('❌ Failed to update token for $userId: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>> getUserGroup() async {
    try {
      final snapShot = await FirebaseDatabase.instance.ref("userGroup").get();
      if (snapShot.exists) {
        final dataMap = Map<String, dynamic>.from(snapShot.value as Map);
        return dataMap.values.map((value) => value.toString()).toList();
      } else {
        debugLog('No user groups found.');
        return [];
      }
    } catch (e) {
      debugLog('Failed to get userGroup: $e');
      return [];
    }
  }

  @override
  Future<void> registerOrUpdateUser(
    String token,
    String userId,
    String id,
  ) async {
    final db = FirebaseDatabase.instance;
    final now = DateTime.now().toIso8601String();
    final registerIds = userId;

    await cleanUpDuplicatedUserId(userId: userId, correctId: id);

    final userRef = db.ref("userInfos/$id");
    final snapshot = await userRef.get();

    final newPlatform = {
      "userId": userId,
      "pushKey": token,
      "updatedAt": now,
      "platform": isPlatform(),
    };

    if (snapshot.exists) {
      await userRef.update({
        "registerIds/$registerIds": newPlatform,
      });
    } else {
      final newUser = {
        "id": id,
        "group": [],
        "registerIds": {
          registerIds: newPlatform,
        },
      };
      await userRef.set(newUser);
    }

    await db.ref("userTokens/$userId").set({
      "id": id,
      "registerIds": registerIds,
      "fcmToken": token,
      "updatedAt": now,
    });
  }

  @override
  Future<void> cleanUpDuplicatedUserId({
    required String userId,
    required String correctId,
  }) async {
    final db = FirebaseDatabase.instance;
    final tokenRef = db.ref("userTokens/$userId");
    final tokenSnap = await tokenRef.get();

    if (tokenSnap.exists) {
      final data = Map<String, dynamic>.from(tokenSnap.value as Map);
      final existingId = data['id'];

      if (existingId != correctId) {
        debugLog(
            "⚠️ 중복된 userId 발견: '$userId'는 '$existingId'에 등록됨. '$correctId'로 이동 처리.");

        // userInfos 전체 탐색하여 잘못된 userId가 등록된 platform 제거
        final allUsersSnap = await db.ref("userInfos").get();
        if (allUsersSnap.exists) {
          final allUsers = Map<String, dynamic>.from(allUsersSnap.value as Map);
          for (final entry in allUsers.entries) {
            final userKey = entry.key;
            final userValue = Map<String, dynamic>.from(entry.value);

            if (userValue.containsKey('platform')) {
              final platformMap =
                  Map<String, dynamic>.from(userValue['platform']);
              for (final platformKey in platformMap.keys) {
                final rawPlatformData =
                    Map<String, dynamic>.from(platformMap[platformKey]);

                if (rawPlatformData['userId'] == userId) {
                  await db
                      .ref("userInfos/$userKey/platform/$platformKey")
                      .remove();
                  debugLog(
                      "🧹 잘못된 platform 제거 → userInfos/$userKey/platform/$platformKey");
                }
              }
            }
          }
        }

        // userTokens 인덱스 삭제
        await tokenRef.remove();
        debugLog("🧹 userTokens/$userId 제거 완료");
      }
    }
  }
}
