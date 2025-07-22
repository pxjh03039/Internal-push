import 'package:flutter/material.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/profile/profile_state.dart';

class ProfileViewModel with ChangeNotifier {
  final UserRepository _userRepository;
  ProfileState _profileState = const ProfileState();
  ProfileViewModel({required UserRepository userRepository})
      : _userRepository = userRepository {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProfileData();
    });
  }

  // 모든 초기 데이터 로딩을 통합하는 단일 메서드
  Future<void> _initializeProfileData() async {
    try {
      await getUserGroup();
      final userId = await getDeviceId();
      final id = await loadRegisterInfo('id');

      _profileState = _profileState.copyWith(
        id: id,
        userId: userId,
      );
    } finally {
      notifyListeners();
    }
  }

  // 체크박스 상태 변경 + DB 업데이트 같이 처리
  Future<void> toggleGroup({required int idx, required bool value}) async {
    toggleSingle(idx, value);
    final group = profileState.labelList[idx];
    try {
      await updateGroup(id: profileState.id, group: group, value: value);
    } catch (e) {
      toggleSingle(idx, !value);
      rethrow;
    }
  }

  void toggleSingle(int index, bool value) {
    final List<bool> updatedCheckboxList =
        List.from(_profileState.checkboxList);
    updatedCheckboxList[index] = value;
    _profileState = _profileState.copyWith(
      checkboxList: updatedCheckboxList,
    );
    notifyListeners();
  }

  ProfileState get profileState => _profileState;

  void setChecked(bool isChecked) {
    _profileState = _profileState.copyWith(isChecked: isChecked);
  }

  Future<void> getuserInfo() async {
    final id = await loadRegisterInfo('id');
    final userId = await getDeviceId();
    final userInfo = await _userRepository.getRegisterInfo(userId, id);
    await saveRegisterInfo(key: 'userInfo', value: userInfo);
  }

  Future<void> getUserGroup() async {
    final group = await _userRepository.getUserGroup();
    final selecedUserGroups = await loadRegisterInfo('userInfo');
    final Map<String, bool> userGroupsMap = (selecedUserGroups['groups'] is Map)
        ? Map<String, bool>.from(selecedUserGroups['groups'])
        : <String, bool>{};
    final List<bool> checkboxList = group.map((groupName) {
      return userGroupsMap[groupName] ?? false;
    }).toList();

    debugLog(checkboxList.toString());

    _profileState = _profileState.copyWith(
        userGroup: group,
        labelList: List.generate(group.length, (i) => group[i]),
        checkboxList: checkboxList);

    notifyListeners();
  }

  void getUserData() async {
    final userId = await getDeviceId();
    final id = await loadRegisterInfo('id');
    // final userInfo = await loadRegisterInfo('userInfo');
    _profileState = _profileState.copyWith(id: id, userId: userId);
    notifyListeners();
  }

  void setSelectedGroup(String? selectedGroup) {
    // 현재 값과 다를 경우에만 상태를 변경하고 notifyListeners 호출
    if (_profileState.selectedGroup != selectedGroup) {
      // copyWith를 사용하여 selectedGroup만 변경된 새로운 ProfileState 객체 생성
      _profileState = _profileState.copyWith(selectedGroup: selectedGroup!);
    }
    notifyListeners();
  }

  Future<void> updateGroup(
      {required String id, required String group, required bool value}) async {
    _userRepository.updateGroup(id, group, value);
  }

  Future<void> onDeleteUser() async {
    final id = await loadRegisterInfo('id');
    final userId = await getDeviceId();
    _userRepository.deleteUser(id, userId);
  }
}
