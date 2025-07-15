import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/big_button.dart';
import 'package:push_test_app/core/presentation/components/small_multi_select_button_group.dart';
import 'package:push_test_app/core/presentation/components/text_input_filed.dart';
import 'package:push_test_app/presentation/create/create_view_model.dart';
import 'package:push_test_app/ui/text_styles.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/core/presentation/components/small_text_button_group.dart';
import 'package:push_test_app/util/date_picker_helper.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('푸시 생성')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: viewModel.createState.selectedTime,
                minuteInterval: 5,
                onTimerDurationChanged: (Duration value) {
                  viewModel.updateSelectedTime(value);
                },
              ),
            ),
            const SizedBox(height: 20),

            // 제목
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('제목', style: TextStyles.mediumTextBold),
            ),
            const SizedBox(height: 10),
            TextInputFiled(
              placeHolder: "제목",
              controller: viewModel.titleController,
              // onSubmitted: viewModel.,
            ),
            const SizedBox(height: 20),

            // 내용
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('알람 내용', style: TextStyles.mediumTextBold),
            ),
            const SizedBox(height: 10),
            TextInputFiled(
              placeHolder: "알람 내용",
              controller: viewModel.messageController,
              // onSubmitted: viewModel.,
            ),
            const SizedBox(height: 20),

            /// 타겟 선택
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('타겟', style: TextStyles.mediumTextBold),
            ),
            const SizedBox(height: 10),
            SmallTextButtonGroup(
              options: const ['All', 'User'],
              selectedTarget: viewModel.createState.selectedTarget,
              onChanged: (String value) {
                viewModel.updateTarget(value);
              },
            ),
            const SizedBox(height: 20),

            /// 반복 선택
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('반복', style: TextStyles.mediumTextBold),
            ),
            const SizedBox(height: 10),
            SmallTextButtonGroup(
                options: const ['none', 'daily', 'weekly'],
                selectedTarget: viewModel.createState.selectedRepeat,
                onChanged: (String value) {
                  viewModel.updateRepeat(value);
                }),
            const SizedBox(height: 20),

            /// 요일 선택 (weekly 때만 표시)
            if (viewModel.createState.selectedRepeat == 'weekly') ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('요일', style: TextStyles.mediumTextBold),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SmallMultiSelectButtonGroup(
                    options: viewModel.WEEKLY,
                    selectedValues: viewModel.createState.selectedDays,
                    onChanged: viewModel.updateSelectedDays,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            const Align(
              alignment: Alignment.centerLeft,
              child: Text('기간', style: TextStyles.mediumTextBold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: ColorStyle.primary100),
                const SizedBox(width: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorStyle.gray4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  onPressed: () async {
                    final picked = await datePicker(
                      context: context,
                      initialDate: viewModel.createState.startDate!,
                    );
                    if (picked == null) return;
                    if (!viewModel.updateStartDate(picked) && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('시작일이 종료일 다음 날로 지정될 수 없습니다.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "${viewModel.createState.startDate}".split(' ')[0],
                    style: TextStyles.mediumTextBold
                        .copyWith(color: ColorStyle.black),
                  ),
                ),

                /// 날짜 선택 (daily 또는 weekly일 때만 종료일 표시)
                if (viewModel.createState.selectedRepeat == 'daily' ||
                    viewModel.createState.selectedRepeat == 'weekly') ...[
                  Text(
                    " ~ ",
                    style: TextStyles.mediumTextBold
                        .copyWith(color: ColorStyle.black),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ColorStyle.gray4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                    onPressed: () async {
                      final picked = await datePicker(
                        context: context,
                        initialDate: viewModel.createState.startDate!,
                      );
                      if (picked == null) return;
                      if (!viewModel.updateEndDate(picked) && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('시작일이 종료일 다음 날로 지정될 수 없습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "${viewModel.createState.endDate}".split(' ')[0],
                      style: TextStyles.mediumTextBold
                          .copyWith(color: ColorStyle.black),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 40),
            BigButton(
              label: '등록',
              onPressed: () async {
                try {
                  await viewModel.createPushSchedule();
                  if (context.mounted) {
                    Navigator.of(context)
                        .pop(); // pop하고 난뒤 push화면으로 갈때 push리스트 새로고침 안됨
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('빈 값이 있습니다.'),
                        backgroundColor: ColorStyle.primaryColor,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
