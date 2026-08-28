import 'package:logger/logger.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

class NetworkLoggingServiceImpl implements LoggingService {
  final _logger = Logger();

  @override
  void verbose(String message) {
    if (!AppConstants.shouldShowNetworkLogs) return;

    _logger.t('[Network/verbose]: $message');
  }

  @override
  void debug(String message) {
    if (!AppConstants.shouldShowNetworkLogs) return;

    _logger.d('[Network/debug]: $message');
  }

  @override
  void info(String message) {
    if (!AppConstants.shouldShowNetworkLogs) return;

    _logger.i('[Network/info]: $message');
  }

  @override
  void warning(String message) {
    if (!AppConstants.shouldShowNetworkLogs) return;

    _logger.w('[Network/warning]: $message');
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (!AppConstants.shouldShowNetworkLogs) return;

    _logger.e('[Network/error]: $message', error: error, stackTrace: stackTrace);
  }
}
