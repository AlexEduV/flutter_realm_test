import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class FetchRegionsUseCase extends UseCaseNoParams<Future<void>> {
  final RegionRepository _regionRepository;

  FetchRegionsUseCase(this._regionRepository);

  @override
  Future<void> call() {
    return _regionRepository.loadRegions();
  }
}
