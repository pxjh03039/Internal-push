import 'package:flutter/material.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class PushScheduleCard extends StatelessWidget {
  final PushSchedule pushSchedule;
  final VoidCallback? onDelete;
  const PushScheduleCard({
    super.key,
    required this.pushSchedule,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorStyle.primary40,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(pushSchedule.scheduleAt, style: TextStyles.smallTextBold),
                const Spacer(flex: 1),
                IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  icon: Image.asset(
                    'image/delete.png',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 16),
                const SizedBox(width: 4),
                Text(
                    "${pushSchedule.startTime.substring(5)} ~ ${pushSchedule.endTime.substring(5)}",
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
            Text(
              pushSchedule.title,
              style: TextStyles.smallTextBold,
            ),
            const SizedBox(height: 4),
            Text(
              pushSchedule.message,
              style: TextStyles.smallTextRegular,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              pushSchedule.target,
              style:
                  TextStyles.smallTextRegular.copyWith(color: ColorStyle.gray3),
            ),
          ],
        ),
      ),
    );
  }
}
