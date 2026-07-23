import 'package:test_flutter_project/domain/models/env_params_model.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetEnvDataByKeyUseCase implements UseCaseWithParams<EnvParamsModel, String> {
  GetEnvDataByKeyUseCase(this._envRepository);

  final EnvRepository _envRepository;

  @override
  String call(EnvParamsModel params) {
    return _envRepository.get(key: params.key, fallback: params.fallbackValue);
  }
}
