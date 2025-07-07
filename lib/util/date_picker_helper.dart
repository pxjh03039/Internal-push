import 'package:flutter/material.dart';
import 'package:push_test_app/ui/color_style.dart';

Future<DateTime?> datePicker({
  required BuildContext context,
  required DateTime initialDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: ColorStyle.primary80),
        ),
        child: child!,
      );
    },
  );
}
