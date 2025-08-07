import 'package:flutter/material.dart';

class OverflowTooltipText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;

  const OverflowTooltipText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final tp = TextPainter(
        text: TextSpan(
            text: text, style: style ?? DefaultTextStyle.of(context).style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: constraints.maxWidth);

      final isOverflow = tp.didExceedMaxLines;
      final child = Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );

      if (isOverflow) {
        return Tooltip(message: text, child: child);
      }
      return child;
    });
  }
}
