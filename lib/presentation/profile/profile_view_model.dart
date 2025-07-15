import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';

class ProfileViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  ProfileViewModel({required UserRepository userRepository})
      : _userRepository = userRepository {
    getuserInfo();
  }

  Future<void> getuserInfo() async {
    final id = await loadRegisterInfo('id');
    final userId = await getDeviceId();
    final userInfo = await _userRepository.getRegisterInfo(userId, id);
    await saveRegisterInfo(key: 'userInfo', value: userInfo);
    final userinfo = await loadRegisterInfo('userInfo');
    // debugLog($userinfo['id']);
    debugLog('userinfo: $userinfo');
  }
}
