import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class FetchRegionsUseCase extends UseCaseNoParams<Future<void>> {
  final RegionRepository regionRepository;

  FetchRegionsUseCase(this.regionRepository);

  @override
  Future<void> call() {
    return regionRepository.loadRegions();
  }
}
