import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/env/init_env_use_case.dart';

import 'get_env_data_by_key_use_case_test.mocks.dart';

void main() {
  late MockEnvRepository mockEnvRepository;
  late InitEnvUseCase useCase;

  setUp(() {
    mockEnvRepository = MockEnvRepository();
    useCase = InitEnvUseCase(mockEnvRepository);
  });

  test('should call init on EnvRepository', () async {
    // Arrange
    when(mockEnvRepository.init()).thenAnswer((_) async {});

    // Act
    await useCase();

    // Assert
    verify(mockEnvRepository.init()).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
  });

  test('should propagate errors from EnvRepository.init', () {
    // Arrange
    when(mockEnvRepository.init()).thenThrow(Exception('init failed'));

    // Act & Assert
    expect(() => useCase(), throwsException);
    verify(mockEnvRepository.init()).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
  });
}
