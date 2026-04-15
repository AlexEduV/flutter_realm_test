import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/data_sources/remote/mock_region_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

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

  tearDown(() {
    serviceLocator.reset();
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

    //todo: these tests are not working;
    //   test('getAvailableCountries returns correct UI models', () {
    //     final regions = [const RegionEntity(locale: 'US'), const RegionEntity(locale: 'CA')];
    //     dataSource.regions = regions;
    //
    //     when(mockLocalisationsCubit.getLocalisationByKey('country_US')).thenReturn('United States');
    //     when(mockLocalisationsCubit.getLocalisationByKey('country_CA')).thenReturn('Canada');
    //
    //     final countries = dataSource.getAvailableCountries();
    //
    //     expect(countries, [
    //       const RegionUiModel(code: 'US', countryName: 'United States'),
    //       const RegionUiModel(code: 'CA', countryName: 'Canada'),
    //     ]);
    //   });
    //
    //   test('loadRegions loads and parses regions from JSON', () async {
    //     // Prepare a fake JSON asset
    //     const fakeJson = '''
    //     {
    //       "status": "success",
    //       "results": [
    //         {
    //           "regions": [
    //             {"locale": "US", "name": "United States"},
    //             {"locale": "CA", "name": "Canada"}
    //           ]
    //         }
    //       ]
    //     }
    //     ''';
    //
    //     // Mock rootBundle.loadString
    //     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
    //       'flutter/assets',
    //       (message) async {
    //         final String key = utf8.decode(message!.buffer.asUint8List());
    //         if (key.contains('regions_data.json')) {
    //           return const StandardMethodCodec().encodeSuccessEnvelope(fakeJson);
    //         }
    //         return null;
    //       },
    //     );
    //
    //     await dataSource.loadRegions();
    //
    //     expect(dataSource.regions, isNotNull);
    //     expect(dataSource.regions!.length, 2);
    //     expect(dataSource.regions!.first.locale, 'US');
    //     expect(dataSource.regions!.last.locale, 'CA');
    //   });
  });
}
