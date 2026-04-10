import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetRegionByCodeUseCase extends UseCaseWithParams<String, RegionEntity?> {
  final RegionRepository _regionRepository;

  GetRegionByCodeUseCase(this._regionRepository);

  @override
  RegionEntity? call(String code) {
    return _regionRepository.getRegionByCode(code);
  }
}
