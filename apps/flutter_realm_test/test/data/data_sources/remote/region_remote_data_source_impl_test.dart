import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_region_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';

import '../../../common/extensions/context_extension_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRegionRemoteDataSourceImpl dataSource;
  late MockAppLocalisationsCubit mockLocalisationsCubit;

  setUp(() {
    dataSource = MockRegionRemoteDataSourceImpl();
    mockLocalisationsCubit = MockAppLocalisationsCubit();

    // Register the mock cubit in the service locator
    serviceLocator.registerSingleton<AppLocalisationsCubit>(mockLocalisationsCubit);
  });

  tearDown(() async {
    await serviceLocator.reset();
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

    test('getAvailableCountries returns correct UI models', () {
      final regions = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'CA')];
      dataSource.regions = regions;

      // Key prefix is L10nKeys.countryPrefix = 'countries.'
      when(mockLocalisationsCubit.getLocalisationByKey('countries.US')).thenReturn('United States');
      when(mockLocalisationsCubit.getLocalisationByKey('countries.CA')).thenReturn('Canada');

      final countries = dataSource.getAvailableCountries();

      expect(countries, [
        const RegionUiModel(code: 'US', countryName: 'United States'),
        const RegionUiModel(code: 'CA', countryName: 'Canada'),
      ]);
    });

    test('loadRegions loads and parses regions from the asset JSON', () async {
      await dataSource.loadRegions();

      // Locales come from the "code" field in regions_data.json
      expect(dataSource.regions, isNotNull);
      expect(dataSource.regions!.isNotEmpty, isTrue);
      expect(dataSource.regions!.first.locale, isNotEmpty);
    });
  });
}
