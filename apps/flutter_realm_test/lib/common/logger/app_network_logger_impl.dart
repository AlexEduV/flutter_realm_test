import 'package:logger/logger.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/logger/base_logger.dart';

class AppNetworkLoggerImpl implements BaseLogger {
  final _logger = Logger();

  @override
  void e(String message) {
    if (!AppConstants.showNetworkLogs) return;

    _logger.i('[Network/error]: $message');
  }

  @override
  void i(String message) {
    if (!AppConstants.showNetworkLogs) return;

    _logger.i('[Network/info]: $message');
  }
}
