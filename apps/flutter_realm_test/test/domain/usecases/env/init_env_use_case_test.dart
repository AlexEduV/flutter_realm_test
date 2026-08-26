import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/env/init_env_use_case.dart';

import '../../../data/data_sources/remote/article_remote_data_source_impl_test.mocks.dart';
import 'get_env_data_by_key_use_case_test.mocks.dart';

void main() {
  late MockEnvRepository mockEnvRepository;
  late MockLoggingService mockLoggingService;
  late InitEnvUseCase useCase;

  setUp(() {
    mockEnvRepository = MockEnvRepository();
    mockLoggingService = MockLoggingService();
    useCase = InitEnvUseCase(mockLoggingService, mockEnvRepository);
  });

  test('should call init on EnvRepository', () async {
    // Arrange
    when(mockEnvRepository.init()).thenAnswer((_) async {});

    // Act
    await useCase();

    // Assert
    verify(mockEnvRepository.init()).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
    verifyZeroInteractions(mockLoggingService);
  });

  test('should log error and complete normally when EnvRepository.init throws', () async {
    // Arrange
    final exception = Exception('init failed');
    when(mockEnvRepository.init()).thenThrow(exception);

    // Act & Assert
    await expectLater(useCase(), completes);
    verify(mockEnvRepository.init()).called(1);
    verify(mockLoggingService.error('Could not load .env file: $exception')).called(1);
    verifyNoMoreInteractions(mockEnvRepository);
    verifyNoMoreInteractions(mockLoggingService);
  });
}
