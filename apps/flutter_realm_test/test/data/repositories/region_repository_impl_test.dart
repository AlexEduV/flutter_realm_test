import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/region_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';

import 'region_model_repository_impl_test.mocks.dart';

@GenerateMocks([RegionRemoteDataSource])
void main() {
  late MockRegionRemoteDataSource mockRemoteDataSource;
  late RegionRepositoryImpl repository;

  final regionList = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'CA')];

  setUp(() {
    mockRemoteDataSource = MockRegionRemoteDataSource();
    repository = RegionRepositoryImpl(mockRemoteDataSource);
  });

  group('RegionRepositoryImpl', () {
    test('loadRegions caches regions after loading', () async {
      when(mockRemoteDataSource.loadRegions()).thenAnswer((_) async {});
      when(mockRemoteDataSource.getAllRegions()).thenReturn(regionList);

      await repository.loadRegions();

      expect(repository.regions, regionList);
      verify(mockRemoteDataSource.loadRegions()).called(1);
      verify(mockRemoteDataSource.getAllRegions()).called(1);
    });

    test('loadRegions does not reload if already loaded', () async {
      repository.regions = regionList;

      await repository.loadRegions();

      verifyNever(mockRemoteDataSource.loadRegions());
      verifyNever(mockRemoteDataSource.getAllRegions());
    });

    test('getRegionByCode returns correct region', () {
      repository.regions = regionList;

      final region = repository.getRegionByCode('CA');
      expect(region?.locale, 'CA');
    });

    test('getRegionByCode returns null if not found', () {
      repository.regions = regionList;

      final region = repository.getRegionByCode('FR');
      expect(region, isNull);
    });

    test('getAllRegions returns all regions', () {
      repository.regions = regionList;

      final all = repository.getAllRegions();
      expect(all, regionList);
    });

    test('getAllRegions returns empty list if regions is null', () {
      repository.regions = null;

      final all = repository.getAllRegions();
      expect(all, isEmpty);
    });
  });
}
