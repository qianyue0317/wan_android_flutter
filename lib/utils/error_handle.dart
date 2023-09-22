

import 'dart:async';

import 'package:flutter/cupertino.dart';

void handleError(void Function() body) {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  runZonedGuarded(body, (error, stack) async {
    await reportError(error, stack);
  });
}

Future<void> reportError(Object error, StackTrace stack) async {
  // 上传报错信息
}