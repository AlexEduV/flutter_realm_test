import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/region_model_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';

import 'region_model_repository_impl_test.mocks.dart';

@GenerateMocks([RegionRemoteDataSource])
void main() {
  late MockRegionRemoteDataSource mockRemoteDataSource;
  late RegionModelRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRegionRemoteDataSource();
    repository = RegionModelRepositoryImpl(mockRemoteDataSource);
  });

  test('getAvailableCountries calls remote data source and returns list', () {
    final countries = [
      const RegionUiModel(code: 'us', countryName: 'United States'),
      const RegionUiModel(code: 'uk', countryName: 'United Kingdom'),
    ];
    when(mockRemoteDataSource.getAvailableCountries()).thenReturn(countries);

    final result = repository.getAvailableCountries();

    expect(result, countries);
    verify(mockRemoteDataSource.getAvailableCountries()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('init calls remote data source and completes', () async {
    when(mockRemoteDataSource.init()).thenAnswer((_) async {});

    await repository.init();

    verify(mockRemoteDataSource.init()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
