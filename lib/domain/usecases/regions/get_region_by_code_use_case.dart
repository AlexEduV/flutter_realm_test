import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetRegionByCodeUseCase extends UseCaseWithParams<String, RegionEntity?> {
  final RegionRepository regionRepository;

  GetRegionByCodeUseCase(this.regionRepository);

  @override
  RegionEntity? call(String code) {
    return regionRepository.getRegionByCode(code);
  }
}
