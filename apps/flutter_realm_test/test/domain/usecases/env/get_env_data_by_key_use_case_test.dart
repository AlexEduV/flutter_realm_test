import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/env_params_model.dart';
import 'package:test_flutter_project/domain/repositories/env_repository.dart';
import 'package:test_flutter_project/domain/usecases/env/get_env_data_by_key_use_case.dart';

import 'get_env_data_by_key_use_case_test.mocks.dart';

@GenerateMocks([EnvRepository])
void main() {
  late MockEnvRepository mockEnvRepository;
  late GetEnvDataByKeyUseCase useCase;

  setUp(() {
    mockEnvRepository = MockEnvRepository();
    useCase = GetEnvDataByKeyUseCase(mockEnvRepository);
  });

  test('should return value from repository when key exists', () {
    // Arrange
    final params = EnvParamsModel(key: 'API_URL', fallbackValue: 'https://fallback.com');
    when(
      mockEnvRepository.get(key: 'API_URL', fallback: 'https://fallback.com'),
    ).thenReturn('https://real.com');

    // Act
    final result = useCase(params);

    // Assert
    expect(result, 'https://real.com');
    verify(mockEnvRepository.get(key: 'API_URL', fallback: 'https://fallback.com')).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
  });

  test('should return fallback value when key does not exist', () {
    // Arrange
    final params = EnvParamsModel(key: 'MISSING_KEY', fallbackValue: 'default');
    when(mockEnvRepository.get(key: 'MISSING_KEY', fallback: 'default')).thenReturn('default');

    // Act
    final result = useCase(params);

    // Assert
    expect(result, 'default');
    verify(mockEnvRepository.get(key: 'MISSING_KEY', fallback: 'default')).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
  });
}
