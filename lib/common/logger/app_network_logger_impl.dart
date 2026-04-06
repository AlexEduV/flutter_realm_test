import 'package:flutter/cupertino.dart';
import 'package:test_futter_project/common/constants/app_constants.dart';
import 'package:test_futter_project/common/logger/base_logger.dart';

class AppNetworkLoggerImpl implements BaseLogger {
  final separationLine = '-' * 45;

  @override
  void log(String message) {
    if (!AppConstants.showNetworkLogs) return;

    debugPrint(
      '[Network]: $message\n'
      '$separationLine',
    );
  }
}
