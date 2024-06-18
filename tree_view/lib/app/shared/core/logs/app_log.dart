import 'package:flutter/foundation.dart';

class AppLog {
  final bool isError;
  final bool activePlus;
  final String logType;
  AppLog({
    this.isError = false,
    this.activePlus = false,
    this.logType = 'info',
  });

  void printAll(
    String text,
  ) {
    if (kReleaseMode) return;
    final pattern = RegExp('.{1,800}');
    _print();
    pattern.allMatches(text).forEach(
      (element) {
        isError
            ? _printTheMessage(
                emoji: activePlus ? '+++ 🚨' : '🚨',
                message: "ERROR - ${element.group(0)}",
                logType: logType,
              )
            : _printTheMessage(
                message: '${element.group(0)}',
                logType: logType,
              );
      },
    );
    _print();
  }

  void _print() {
    if (kDebugMode) {
      print('---------------------------------------------');
    }
  }

  void _printTheMessage(
      {String emoji = '✅', String message = "", String logType = "info"}) {
    if (kDebugMode) {
      emoji = activePlus ? '+++ ✅' : '✅';
      print('$emoji [${logType.toUpperCase()}]: $message');
    }
  }
}
