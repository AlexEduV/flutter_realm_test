import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/repositories/geolocator_repository.dart';
import 'package:test_futter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';

import 'check_location_service_status_use_case_test.mocks.dart';

@GenerateMocks([GeolocatorRepository])
void main() {
  late MockGeolocatorRepository mockRepository;
  late CheckLocationServiceStatusUseCase useCase;

  setUp(() {
    mockRepository = MockGeolocatorRepository();
    useCase = CheckLocationServiceStatusUseCase(mockRepository);
  });

  group('CheckLocationServiceStatusUseCase', () {
    test('call returns true when repository returns true', () async {
      when(mockRepository.checkLocationServiceStatus()).thenAnswer((_) async => true);

      final result = await useCase.call();

      expect(result, isTrue);
      verify(mockRepository.checkLocationServiceStatus()).called(1);
    });

    test('call returns false when repository returns false', () async {
      when(mockRepository.checkLocationServiceStatus()).thenAnswer((_) async => false);

      final result = await useCase.call();

      expect(result, isFalse);
      verify(mockRepository.checkLocationServiceStatus()).called(1);
    });
  });
}
