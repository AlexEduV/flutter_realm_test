import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/repositories/region_model_repository.dart';
import 'package:test_futter_project/domain/usecases/regions/init_region_models_use_case.dart';

import 'init_region_model_ues_case_test.mocks.dart';

@GenerateMocks([RegionModelRepository])
void main() {
  late MockRegionModelRepository mockRepository;
  late InitRegionModelsUseCase useCase;

  setUp(() {
    mockRepository = MockRegionModelRepository();
    useCase = InitRegionModelsUseCase(mockRepository);
  });

  test('calls init on repository and completes', () async {
    when(mockRepository.init()).thenAnswer((_) async => null);

    await useCase.call();

    verify(mockRepository.init()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
