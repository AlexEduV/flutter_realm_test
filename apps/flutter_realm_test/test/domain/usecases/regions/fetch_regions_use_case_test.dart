import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/usecases/regions/fetch_regions_use_case.dart'; // Update with your actual file path

import 'fetch_regions_use_case_test.mocks.dart';

@GenerateMocks([RegionRepository])
void main() {
  late MockRegionRepository mockRepository;
  late FetchRegionsUseCase useCase;

  setUp(() {
    mockRepository = MockRegionRepository();
    useCase = FetchRegionsUseCase(mockRepository);
  });

  group('FetchRegionsUseCase', () {
    test('call delegates to regionRepository.loadRegions', () async {
      when(mockRepository.loadRegions()).thenAnswer((_) async {});

      await useCase.call();

      verify(mockRepository.loadRegions()).called(1);
    });
  });
}
