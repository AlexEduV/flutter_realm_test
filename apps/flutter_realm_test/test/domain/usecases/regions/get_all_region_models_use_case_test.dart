import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_all_region_models_use_case.dart';

import 'init_region_model_use_case_test.mocks.dart';

void main() {
  late MockRegionModelRepository mockRepository;
  late GetAllRegionModelsUseCase useCase;

  setUp(() {
    mockRepository = MockRegionModelRepository();
    useCase = GetAllRegionModelsUseCase(mockRepository);
  });

  test('calls getAvailableCountries on repository and returns list', () {
    final countries = [
      const RegionUiModel(code: 'us', countryName: 'United States'),
      const RegionUiModel(code: 'uk', countryName: 'United Kingdom'),
    ];
    when(mockRepository.getAvailableCountries()).thenReturn(countries);

    final result = useCase.call();

    expect(result, countries);
    verify(mockRepository.getAvailableCountries()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
