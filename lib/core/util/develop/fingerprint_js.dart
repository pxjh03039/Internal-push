@JS()
library fingerprint_js;

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

@JS('FingerprintJS.load')
external Object loadFingerprintJS();

@JS()
@anonymous
class FingerprintResult {
  external String get visitorId;
}

Future<String> getFingerprint() async {
  final fpPromise = loadFingerprintJS();
  final fp = await js_util.promiseToFuture<Object>(fpPromise);
  final resultPromise = js_util.callMethod(fp, 'get', []);
  final result =
      await js_util.promiseToFuture<FingerprintResult>(resultPromise);
  return result.visitorId;
}
