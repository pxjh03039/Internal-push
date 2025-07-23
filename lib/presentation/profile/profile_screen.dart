import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/switch_item.dart';
import 'package:push_test_app/presentation/profile/profile_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyles.mediumTextBold,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // 버튼 클릭 시 동작
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      '회원탈퇴',
                      style: TextStyles.mediumTextBold,
                    ),
                    content: const Text(
                      '정말로 회원탈퇴하시겠습니까?',
                      style: TextStyles.smallTextRegular,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await viewModel.onDeleteUser();
                          if (context.mounted) {
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                            context.go('/intro');
                          }
                        },
                        child: const Text(
                          "확인",
                          style: TextStyles.mediumTextRegular,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        child: const Text(
                          "취소",
                          style: TextStyles.mediumTextRegular,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              '탈퇴',
              style: TextStyles.mediumTextRegular
                  .copyWith(color: ColorStyle.error),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 99,
                  height: 99,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/image/profile_sample.png'),
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        viewModel.profileState.id,
                        style: TextStyles.normalTextBold,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        viewModel.profileState.userId,
                        style: TextStyles.smallerTextRegular
                            .copyWith(color: ColorStyle.gray3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 이 부분 추가
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '그룹 관리',
                  style: TextStyles.normalTextBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                viewModel.profileState.labelList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // 부모가 스크롤 가능하면 이중 스크롤 방지
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // 한 줄에 표시할 항목 개수
                          crossAxisSpacing: 5.0, // 가로 간격
                          mainAxisSpacing: 5.0, // 세로 간격
                          childAspectRatio: 8.0, // 항목의 너비/높이 비율을 조정하여 크기 조절
                        ),
                        itemCount: viewModel.profileState.labelList.length,
                        itemBuilder: (context, index) {
                          return SwitchItem(
                            index: index,
                            isChecked:
                                viewModel.profileState.checkboxList[index],
                            label: viewModel.profileState.labelList[index],
                            onChanged: (idx, value) async {
                              if (viewModel.profileState.checkboxList[idx] !=
                                  value) {
                                viewModel.toggleGroup(idx: idx, value: value);
                              }
                            },
                          );
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
