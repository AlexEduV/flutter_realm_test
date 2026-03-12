import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/local/geolocator_local_data_source_impl.dart';
import 'package:test_futter_project/data/repositories/geolocator_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/geolocator_local_data_source.dart';

import 'geolocator_repository_impl_test.mocks.dart';

@GenerateMocks([GeolocatorLocalDataSource])
void main() {
  late MockGeolocatorLocalDataSource mockGeolocatorService;
  late GeolocatorRepositoryImpl repository;

  setUp(() {
    mockGeolocatorService = MockGeolocatorLocalDataSource();
    repository = GeolocatorRepositoryImpl(mockGeolocatorService);
  });

  group('GeolocatorRepositoryImpl', () {
    test('checkLocationServiceStatus delegates to GeolocatorService', () async {
      when(mockGeolocatorService.checkLocationServiceStatus()).thenAnswer((_) async => true);

      final result = await repository.checkLocationServiceStatus();

      expect(result, isTrue);
      verify(mockGeolocatorService.checkLocationServiceStatus()).called(1);
    });

    test('openAppSettings delegates to GeolocatorService', () async {
      when(mockGeolocatorService.openLocationSettings()).thenAnswer((_) async => false);

      final result = await repository.openAppSettings();

      expect(result, isFalse);
      verify(mockGeolocatorService.openLocationSettings()).called(1);
    });
  });
}
