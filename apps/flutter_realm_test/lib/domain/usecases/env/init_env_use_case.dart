import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../usecase.dart';

class InitEnvUseCase implements UseCaseNoParams<Future<void>> {
  InitEnvUseCase(this._loggingService, this._envRepository);

  final LoggingService _loggingService;
  final EnvRepository _envRepository;

  @override
  Future<void> call() async {
    try {
      await _envRepository.init();
    } catch (e) {
      _loggingService.error('Could not load .env file: $e');
    }
  }
}
