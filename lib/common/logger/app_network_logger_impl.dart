import 'package:logger/logger.dart';
import 'package:test_futter_project/common/constants/app_constants.dart';
import 'package:test_futter_project/common/logger/base_logger.dart';

class AppNetworkLoggerImpl implements BaseLogger {
  final _logger = Logger();

  @override
  void e(String message) {
    if (!AppConstants.showNetworkLogs) return;

    _logger.e('[Network]: $message');
  }

  @override
  void i(String message) {
    _logger.i('[Network]: $message');
  }
}
