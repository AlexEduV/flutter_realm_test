import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/data/repositories/region_repository_impl.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // const mockJson =
  //     '''
  // {
  //   "status": "${ApiConstants.apiSuccessStatus}",
  //   "results": [
  //     {
  //       "regions": [
  //         {"locale": "en", "name": "English"},
  //         {"locale": "it", "name": "Italian"}
  //       ]
  //     }
  //   ]
  // }
  // ''';

  setUp(() {
    // Reset singleton state before each test
    RegionRepositoryImpl().regions = null;
  });

  test('is a singleton', () {
    final repo1 = RegionRepositoryImpl();
    final repo2 = RegionRepositoryImpl();
    expect(identical(repo1, repo2), isTrue);
  });

  //todo: this test is not working;
  // test('loadRegions loads and parses regions correctly', () async {
  //   // Mock rootBundle.loadString
  //   const assetPath = '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}regions_data.json';
  //   TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
  //     'flutter/assets',
  //     (ByteData? message) async {
  //       if (message == null || message.lengthInBytes == 0) return null; // 👈 Safety check
  //
  //       try {
  //         final String key = utf8.decode(message.buffer.asUint8List());
  //         if (key == assetPath) {
  //           return const StandardMethodCodec().encodeSuccessEnvelope(mockJson);
  //         }
  //       } catch (e) {
  //         debugPrint('Failed to decode asset key: $e');
  //       }
  //       return null;
  //     },
  //   );
  //
  //   final repo = RegionRepositoryImpl();
  //   await repo.loadRegions();
  //
  //   final regions = repo.getAllRegions();
  //   expect(regions.length, 2);
  //   expect(regions[0].locale, 'en');
  //   expect(regions[1].locale, 'it');
  // });

  test('getRegionByCode returns correct region', () {
    // Setup regions manually
    final repo = RegionRepositoryImpl();
    repo.regions = [const RegionEntity(locale: 'en'), const RegionEntity(locale: 'it')];

    final region = repo.getRegionByCode('it');
    expect(region, isNotNull);
  });

  test('getRegionByCode returns null if not found', () {
    final repo = RegionRepositoryImpl();
    repo.regions = [const RegionEntity(locale: 'en')];

    final region = repo.getRegionByCode('fr');
    expect(region, isNull);
  });

  test('getAllRegions returns empty list if not loaded', () {
    final repo = RegionRepositoryImpl();
    repo.regions = null;
    expect(repo.getAllRegions(), isEmpty);
  });
}
