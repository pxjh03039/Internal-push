import 'package:flutter/material.dart';
import 'package:push_test_app/core/presentation/components/overflow_tootip_text.dart';
import 'package:push_test_app/core/util/develop/develop_tool.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class PushScheduleCard extends StatelessWidget {
  final PushSchedule pushSchedule;
  final VoidCallback? onDelete;
  final void Function(PushSchedule)? onUpdate;
  final String idName;
  const PushScheduleCard({
    super.key,
    required this.pushSchedule,
    this.onDelete,
    this.onUpdate,
    required this.idName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorStyle.primary40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(pushSchedule.scheduleAt,
                        style: TextStyles.smallTextBold),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 16),
                    const SizedBox(width: 4),
                    Text(
                        pushSchedule.repeat != 'none'
                            ? '${pushSchedule.startTime.substring(5)} ~ ${pushSchedule.endTime.substring(5)}'
                            : pushSchedule.startTime.substring(5),
                        style: TextStyles.smallTextRegular),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        pushSchedule.scheduleDays?.isEmpty ?? true
                            ? "없음"
                            : pushSchedule.scheduleDays!.join(", "),
                        style: TextStyles.smallerTextRegular
                            .copyWith(fontSize: 9, color: ColorStyle.gray3),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                OverflowTooltipText(
                  '${pushSchedule.title} | ${pushSchedule.idName}',
                  style: TextStyles.smallTextBold,
                  maxLines: 1,
                ),
                OverflowTooltipText(
                  pushSchedule.message,
                  style: TextStyles.smallTextRegular,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            left: 8,
            child: Text(
              pushSchedule.target,
              style:
                  TextStyles.smallTextRegular.copyWith(color: ColorStyle.gray3),
            ),
          ),
          if (pushSchedule.idName == idName) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      onUpdate!(pushSchedule);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(18, 18),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Image.asset(
                      'assets/image/update.png',
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onDelete,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(18, 18),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Image.asset(
                      'assets/image/delete.png',
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
