import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/constants/app_asset_routes.dart';
import 'package:test_flutter_project/data/data_sources/local/env_local_data_source_impl.dart';

import 'env_local_data_source_impl_test.mocks.dart';

@GenerateMocks([DotEnv])
void main() {
  late MockDotEnv mockDotEnv;
  late EnvLocalDataSourceImpl dataSource;

  setUp(() {
    mockDotEnv = MockDotEnv();
    dataSource = EnvLocalDataSourceImpl(mockDotEnv);
  });

  group('EnvLocalDataSourceImpl', () {
    test('init calls dotenv.load with correct file name', () async {
      when(mockDotEnv.load(fileName: anyNamed('fileName'))).thenAnswer((_) async {});

      await dataSource.init();

      verify(mockDotEnv.load(fileName: AppAssetRoutes.envRoute)).called(1);
    });

    test('get returns value from dotenv', () {
      when(mockDotEnv.get('API_KEY', fallback: 'default')).thenReturn('12345');

      final result = dataSource.get(key: 'API_KEY', fallback: 'default');

      expect(result, '12345');
      verify(mockDotEnv.get('API_KEY', fallback: 'default')).called(1);
    });

    test('get returns fallback if key is missing', () {
      when(mockDotEnv.get('MISSING_KEY', fallback: 'fallback')).thenReturn('fallback');

      final result = dataSource.get(key: 'MISSING_KEY', fallback: 'fallback');

      expect(result, 'fallback');
      verify(mockDotEnv.get('MISSING_KEY', fallback: 'fallback')).called(1);
    });
  });
}
