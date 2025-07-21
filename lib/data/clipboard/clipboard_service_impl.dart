import 'package:flutter/services.dart';
import 'package:push_test_app/domain/clipboard/clipboard_service.dart';

class ClipboardServiceImpl implements ClipboardService {
  @override
  Future<void> copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Future<String?> pasteText() async {
    final clipboardData = await Clipboard.getData('text/plain');
    return clipboardData?.text;
  }
}
