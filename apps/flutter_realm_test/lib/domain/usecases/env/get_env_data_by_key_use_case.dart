import 'package:test_flutter_project/domain/models/env_params_model.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetEnvDataByKeyUseCase implements UseCaseWithParams<EnvParamsModel, String?> {
  GetEnvDataByKeyUseCase(this._loggingService, this._envRepository);

  final LoggingService _loggingService;
  final EnvRepository _envRepository;

  @override
  String? call(EnvParamsModel params) {
    try {
      return _envRepository.get(key: params.key, fallback: params.fallbackValue);
    } catch (e) {
      _loggingService.error('Could not retrieve env data for key ${params.key}: $e');
      return null;
    }
  }
}
