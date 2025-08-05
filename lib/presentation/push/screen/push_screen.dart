// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/core/presentation/components/push_schedule_card.dart';
import 'package:push_test_app/core/presentation/components/search_input_filed.dart';
import 'package:push_test_app/core/presentation/components/small_text_button_group.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/presentation/push/push_action.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';
import 'package:push_test_app/router/route_path.dart';
import 'package:push_test_app/ui/text_styles.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PushViewModel>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyles.mediumTextBold,
          ),
          centerTitle: true,
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
                children: [
                  Expanded(
                    child: SearchInputFiled(
                      controller: viewModel.controller,
                      placeHolder: "Search",
                      onChanged: (value) {
                        return viewModel.onAction(
                            PushAction.setField(PushField.textChange, value));
                      },
                    ),
                  ),
                  // 검색 필터 버튼 임시 제거
                  // const SizedBox(width: 20),
                  // Container(
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: ColorStyle.primary100),
                  //   child: const Icon(Icons.tune, color: ColorStyle.white),
                  // ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SmallTextButtonGroup(
                options: const ['All', 'none', 'daily', 'weekly'],
                selectedTarget: viewModel.pushState.selectRepeat,
                onChanged: (value) {
                  viewModel.onAction(
                    PushAction.setField(PushField.selectRepeat, value),
                  );
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, // 각 칸 최대 너비 고정
                    mainAxisExtent: 220,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 12,
                  ),
                  itemCount: viewModel.pushState.pushSchedule.length,
                  itemBuilder: (context, index) {
                    final PushSchedule item =
                        viewModel.pushState.pushSchedule[index];
                    return PushScheduleCard(
                      pushSchedule: item,
                      onDelete: () async {
                        await viewModel.deletePushSchedule(item.id);
                      },
                      onUpdate: (item) {
                        context.push(RoutePath.update, extra: item);
                      },
                      idName: viewModel.idName,
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
