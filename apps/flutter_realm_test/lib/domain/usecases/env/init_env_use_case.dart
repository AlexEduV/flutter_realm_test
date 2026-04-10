import 'package:test_futter_project/domain/repositories/env_repository.dart';

import '../usecase.dart';

class InitEnvUseCase implements UseCaseNoParams<Future<void>> {
  InitEnvUseCase(this._envRepository);

  final EnvRepository _envRepository;

  @override
  Future<void> call() {
    return _envRepository.init();
  }
}
