import 'package:flutter/cupertino.dart';
import 'package:test_futter_project/common/constants/app_constants.dart';
import 'package:test_futter_project/common/logger/base_logger.dart';

class AppNetworkLoggerImpl implements BaseLogger {
  @override
  void log(String message) {
    if (AppConstants.showNetworkLogs) {
      debugPrint(message);
    }
  }
}
