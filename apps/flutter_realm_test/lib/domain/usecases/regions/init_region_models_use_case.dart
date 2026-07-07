import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class InitRegionModelsUseCase extends UseCaseNoParams<Future<void>> {
  InitRegionModelsUseCase(this._regionModelRepository);

  final RegionModelRepository _regionModelRepository;

  @override
  Future<void> call() {
    return _regionModelRepository.init();
  }
}
