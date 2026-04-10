import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';

import 'fetch_regions_use_case_test.mocks.dart';

void main() {
  late MockRegionRepository mockRepository;
  late GetAllRegionsUseCase useCase;

  setUp(() {
    mockRepository = MockRegionRepository();
    useCase = GetAllRegionsUseCase(mockRepository);
  });

  group('GetAllRegionsUseCase', () {
    test('call returns list from regionRepository.getAllRegions', () {
      final regions = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'DE')];

      when(mockRepository.getAllRegions()).thenReturn(regions);

      final result = useCase.call();

      expect(result, regions);
      verify(mockRepository.getAllRegions()).called(1);
    });
  });
}
