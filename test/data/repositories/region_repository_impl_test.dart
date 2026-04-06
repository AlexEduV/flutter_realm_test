import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:test_futter_project/data/repositories/region_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';

import 'region_repository_impl_test.mocks.dart';

@GenerateMocks([RegionRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockRegionRemoteDataSource = MockRegionRemoteDataSource();

  setUp(() {
    // Reset singleton state before each test
    RegionRepositoryImpl(mockRegionRemoteDataSource).regions = null;
  });

  test('getRegionByCode returns correct region', () {
    // Setup regions manually
    final repo = RegionRepositoryImpl(mockRegionRemoteDataSource);
    repo.regions = [const RegionEntity(locale: 'en'), const RegionEntity(locale: 'it')];

    final region = repo.getRegionByCode('it');
    expect(region, isNotNull);
  });

  test('getRegionByCode returns null if not found', () {
    final repo = RegionRepositoryImpl(mockRegionRemoteDataSource);
    repo.regions = [const RegionEntity(locale: 'en')];

    final region = repo.getRegionByCode('fr');
    expect(region, isNull);
  });

  test('getAllRegions returns empty list if not loaded', () {
    final repo = RegionRepositoryImpl(mockRegionRemoteDataSource);
    repo.regions = null;
    expect(repo.getAllRegions(), isEmpty);
  });
}
