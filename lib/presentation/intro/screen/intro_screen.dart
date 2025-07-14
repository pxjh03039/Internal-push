import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/medium_button.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/presentation/intro/intro_view_model.dart';
import 'package:push_test_app/router/route_path.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IntroViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              // 배경 이미지 꽉 채우기
              Positioned.fill(
                child: Image.asset(
                  "assets/image/intro.png",
                  fit: BoxFit.cover,
                ),
              ),
              // 실제 내용은 위에 오도록
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 104),
                    Image.asset("assets/image/intro_bell.png",
                        width: 79, height: 79),
                    const SizedBox(height: 14),
                    Text(
                      "D35H App Push",
                      style: TextStyles.mediumTextBold.copyWith(
                        color: ColorStyle.white,
                      ),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: 341,
                      child: Text(
                        viewModel.introState.isRegistered
                            ? "등록된 사용자 입니다."
                            : "미등록\n 사용자 입니다.",
                        textAlign: TextAlign.center,
                        style: TextStyles.titleTextBold.copyWith(
                          color: ColorStyle.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "계속 진행 하시려면 등록을 눌러주세요.",
                      style: TextStyles.normalTextRegular
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputFiled(
                        placeHolder: "닉네임을 입력해주세요.",
                        controller: viewModel.titleController,
                        textColor: ColorStyle.white,
                        onSubmitted: (value) {
                          viewModel.titleController.text = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 66),
                      child: MediumButton(
                        label: '등록',
                        onPressed: () async {
                          try {
                            if (viewModel.titleController.text.isNotEmpty) {
                              if (!viewModel.introState.isRegistered) {
                                await viewModel.registerToken();
                              }
                              if (context.mounted) {
                                context.push(RoutePath.profile);
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .clearSnackBars(); // 기존 스낵바 제거
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("닉네임이 비었습니다.")),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("토큰 등록에 실패했습니다.")),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 80), // 하단 여백
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
