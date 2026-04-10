import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/env_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/env_local_data_source.dart';

import 'env_repository_impl_test.mocks.dart';

@GenerateMocks([EnvLocalDataSource])
void main() {
  late MockEnvLocalDataSource mockDataSource;
  late EnvRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockEnvLocalDataSource();
    repository = EnvRepositoryImpl(mockDataSource);
  });

  test('init delegates to EnvLocalDataSource.init', () async {
    when(mockDataSource.init()).thenAnswer((_) async {});

    await repository.init();

    verify(mockDataSource.init()).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });

  test('get delegates to EnvLocalDataSource.get and returns value', () {
    when(mockDataSource.get(key: 'API_KEY', fallback: 'default')).thenReturn('12345');

    final result = repository.get(key: 'API_KEY', fallback: 'default');

    expect(result, '12345');
    verify(mockDataSource.get(key: 'API_KEY', fallback: 'default')).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });

  test('get returns fallback if key is missing', () {
    when(mockDataSource.get(key: 'MISSING_KEY', fallback: 'fallback')).thenReturn('fallback');

    final result = repository.get(key: 'MISSING_KEY', fallback: 'fallback');

    expect(result, 'fallback');
    verify(mockDataSource.get(key: 'MISSING_KEY', fallback: 'fallback')).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });
}
