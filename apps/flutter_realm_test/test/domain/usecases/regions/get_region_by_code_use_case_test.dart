import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_region_by_code_use_case.dart';

import 'fetch_regions_use_case_test.mocks.dart';

void main() {
  late MockRegionRepository mockRepository;
  late GetRegionByCodeUseCase useCase;

  setUp(() {
    mockRepository = MockRegionRepository();
    useCase = GetRegionByCodeUseCase(mockRepository);
  });

  group('GetRegionByCodeUseCase', () {
    test('call returns RegionEntity when found', () {
      const code = 'US';
      const region = RegionEntity(locale: 'US');

      when(mockRepository.getRegionByCode(code)).thenReturn(region);

      final result = useCase.call(code);

      expect(result, region);
      verify(mockRepository.getRegionByCode(code)).called(1);
    });

    test('call returns null when region not found', () {
      const code = 'XX';

      when(mockRepository.getRegionByCode(code)).thenReturn(null);

      final result = useCase.call(code);

      expect(result, isNull);
      verify(mockRepository.getRegionByCode(code)).called(1);
    });
  });
}
