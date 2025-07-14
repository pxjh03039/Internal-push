import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/intro/intro_state.dart';

class IntroViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  final titleController = TextEditingController();

  IntroViewModel({required UserRepository userRepository})
      : _userRepository = userRepository {
    testGetDeviceId();
    isUserTokenRegistered();
  }

  IntroState _introState = const IntroState();
  IntroState get introState => _introState;

  void setInputNickname(String nickname) {
    _introState = _introState.copyWith(titleController: nickname);
    notifyListeners();
  }

  Future<void> testGetDeviceId() async {
    String token = await getToken();
    String userId = await getDeviceId();
    debugLog('token: $token, userId: $userId');
    notifyListeners();
  }

  Future<void> registerToken() async {
    String token = await getToken();
    String userId = await getDeviceId();
    await _userRepository.registerToken(token, userId);
  }

  Future<void> updateUserToken() async {
    String token = await getToken();
    String userId = await getDeviceId();
    await _userRepository.updateToken(token, userId);
    // 상태 갱신 (예: 토큰 등록 상태 다시 체크)
    var isRegistered = await _userRepository.isUserTokenRegistered(userId);

    _introState = _introState.copyWith(isRegistered: isRegistered);
    notifyListeners();

    debugLog('updateUserToken 완료, isRegistered: $isRegistered');
  }

  Future<void> deleteToken() async {
    String userId = await getDeviceId();
    await _userRepository.deleteToken(userId);
  }

  Future<String> getToken() async {
    return await _userRepository.getToken();
  }

  Future<void> isUserTokenRegistered() async {
    String userId = await getDeviceId();
    var isRegistered = await _userRepository.isUserTokenRegistered(userId);
    debugLog('isUserTokenRegistered: $isRegistered');
    _introState = _introState.copyWith(
      isRegistered: isRegistered,
    );
    notifyListeners();
  }
}
