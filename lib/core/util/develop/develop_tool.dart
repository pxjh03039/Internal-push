import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugLog(dynamic value) {
  if (kIsWeb) {
    // ignore: avoid_print
    print(value);
  } else {
    log(value.toString());
  }
}
