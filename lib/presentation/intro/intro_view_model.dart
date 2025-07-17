import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/intro/intro_state.dart';

class IntroViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  final titleController = TextEditingController();

  IntroViewModel({required UserRepository userRepository})
      : _userRepository = userRepository {
    isUserTokenRegistered();
  }

  IntroState _introState = const IntroState();
  IntroState get introState => _introState;

  void setInputNickname(String nickname) {
    _introState = _introState.copyWith(titleController: nickname);
    notifyListeners();
  }

  Future<void> getUserGroup() async {
    _introState = _introState.copyWith(
        getUserGroup: await _userRepository.getUserGroup());
    notifyListeners();
  }

  Future<void> getuserInfo() async {
    final id = await loadRegisterInfo('id');
    final userId = await getDeviceId();
    final userInfo = await _userRepository.getRegisterInfo(userId, id);
    await saveRegisterInfo(key: 'userInfo', value: userInfo);
  }

  Future<void> registerOrUpdateUser() async {
    String token = await getToken();
    String userId = await getDeviceId();
    debugLog('registerOrUpdateUser 호출, token: $token, userId: $userId');
    await _userRepository.registerOrUpdateUser(
        token, userId, titleController.text);
  }

  Future<String?> updateUserToken() async {
    String token = await getToken();
    String userId = await getDeviceId();
    String? id = await _userRepository.updateToken(token, userId);

    // 상태 갱신 (예: 토큰 등록 상태 다시 체크)
    var isRegistered = await _userRepository.isUserTokenRegistered(userId);

    _introState = _introState.copyWith(isRegistered: isRegistered);
    notifyListeners();

    debugLog('updateUserToken 완료, isRegistered: $isRegistered');
    return id;
  }

  Future<void> deleteToken() async {
    String userId = await getDeviceId();
    await _userRepository.deleteToken(userId, titleController.text);
  }

  Future<String> getToken() async {
    return await _userRepository.getToken();
  }

  Future<void> isUserTokenRegistered() async {
    String userId = await getDeviceId();
    var isRegistered = await _userRepository.isUserTokenRegistered(userId);
    _introState = _introState.copyWith(
      isRegistered: isRegistered,
    );
    notifyListeners();
  }

  Future<bool> tryRegister() async {
    if (titleController.text.isEmpty) return false;

    if (!introState.isRegistered) {
      await registerOrUpdateUser();
    }

    return true;
  }
}
