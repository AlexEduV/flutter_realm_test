import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/geolocator_repository_impl.dart';
import 'package:test_flutter_project/domain/services/geolocator_service.dart';

import 'geolocator_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GeolocatorService>()])
void main() {
  late MockGeolocatorService mockGeolocatorService;
  late GeolocatorRepositoryImpl repository;

  setUp(() {
    mockGeolocatorService = MockGeolocatorService();
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
