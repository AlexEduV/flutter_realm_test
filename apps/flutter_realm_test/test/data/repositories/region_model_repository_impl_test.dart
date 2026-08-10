import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/region_model_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';

import 'region_model_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RegionRemoteDataSource>()])
void main() {
  late MockRegionRemoteDataSource mockRemoteDataSource;
  late RegionModelRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRegionRemoteDataSource();
    repository = RegionModelRepositoryImpl(mockRemoteDataSource);
  });

  test('getAvailableCountries maps regions to UI models with l10n keys', () {
    when(mockRemoteDataSource.getAllRegions()).thenReturn([
      const RegionEntity(locale: 'us'),
      const RegionEntity(locale: 'uk'),
    ]);

    final result = repository.getAvailableCountries();

    expect(result, [
      const RegionUiModel(code: 'us', countryName: 'countries.us'),
      const RegionUiModel(code: 'uk', countryName: 'countries.uk'),
    ]);
    verify(mockRemoteDataSource.getAllRegions()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('init calls remote data source and completes', () async {
    when(mockRemoteDataSource.init()).thenAnswer((_) async {});

    await repository.init();

    verify(mockRemoteDataSource.init()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
