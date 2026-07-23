import 'package:logger/logger.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

class AppLoggingServiceImpl implements LoggingService {
  final _logger = Logger();

  @override
  void verbose(String message) => _logger.t(message);

  @override
  void debug(String message) => _logger.d(message);

  @override
  void info(String message) => _logger.i(message);

  @override
  void warning(String message) => _logger.w(message);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
