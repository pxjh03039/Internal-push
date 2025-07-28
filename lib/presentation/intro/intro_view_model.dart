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

  IntroState _introState = const IntroState(isLoading: true);
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
    _introState = _introState.copyWith(isLoading: true);
    // notifyListeners();

    _introState = _introState.copyWith(isLoading: false);
    // notifyListeners();

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
    _introState = _introState.copyWith(isLoading: true);
    notifyListeners();
    var isRegistered = await _userRepository.isUserTokenRegistered(userId);
    _introState = _introState.copyWith(
      isRegistered: isRegistered,
    );
    await saveRegisterInfo(key: 'deviceId', value: userId);
    _introState = _introState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<bool> tryRegister() async {
    if (titleController.text.isEmpty) return false;

    if (!introState.isRegistered) {
      await registerOrUpdateUser();
    }

    return true;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
