import 'package:flutter/material.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class SwitchItem extends StatelessWidget {
  final int index;
  final bool isChecked;
  final String label;
  final Function(int index, bool value) onChanged;
  const SwitchItem(
      {super.key,
      required this.index,
      required this.isChecked,
      required this.label,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(index, !isChecked),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorStyle.primary100,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // 👈 추가된 부분: 가로 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 중앙 정렬 (기존)
            children: [
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.smallTextRegular
                    .copyWith(color: ColorStyle.white),
              ),
              Switch(
                value: isChecked,
                onChanged: (bool? value) {
                  if (value != null) {
                    onChanged(index, value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
