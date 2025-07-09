import 'package:flutter/material.dart';
import 'package:push_test_app/domain/model/push_schedule.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class PushScheduleCard extends StatelessWidget {
  final PushSchedule pushSchedule;
  const PushScheduleCard({super.key, required this.pushSchedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorStyle.primary40,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text("07:00", style: TextStyles.smallTextBold),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.calendar_month, size: 16),
                SizedBox(width: 4),
                Text("07/07 ~ 07/08", style: TextStyles.smallTextRegular),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "월 수",
                  style: TextStyles.smallerTextRegular
                      .copyWith(color: ColorStyle.gray3),
                ),
              ],
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
              "ALL",
              style:
                  TextStyles.smallTextRegular.copyWith(color: ColorStyle.gray3),
            ),
          ],
        ),
      ),
    );
  }
}
