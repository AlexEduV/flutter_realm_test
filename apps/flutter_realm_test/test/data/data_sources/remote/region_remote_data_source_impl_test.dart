import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/data/data_sources/remote/seed_region_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SeedRegionRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = SeedRegionRemoteDataSourceImpl();
  });

  group('MockRegionRemoteDataSourceImpl', () {
    test('getAllRegions returns empty list if regions is null', () {
      dataSource.regions = null;
      expect(dataSource.getAllRegions(), isEmpty);
    });

    test('getAllRegions returns regions if not null', () {
      final regions = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'CA')];
      dataSource.regions = regions;
      expect(dataSource.getAllRegions(), regions);
    });

    test('loadRegions loads and parses regions from the asset JSON', () async {
      await dataSource.loadRegions();

      expect(dataSource.regions, isNotNull);
      expect(dataSource.regions!.isNotEmpty, isTrue);
      expect(dataSource.regions!.first.locale, isNotEmpty);
    });
  });
}
