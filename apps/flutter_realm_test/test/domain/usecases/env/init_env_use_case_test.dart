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
