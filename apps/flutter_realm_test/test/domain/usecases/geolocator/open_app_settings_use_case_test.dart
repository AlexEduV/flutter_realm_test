import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';

import 'check_location_service_status_use_case_test.mocks.dart';

void main() {
  late MockGeolocatorRepository mockRepository;
  late OpenAppSettingsUseCase useCase;

  setUp(() {
    mockRepository = MockGeolocatorRepository();
    useCase = OpenAppSettingsUseCase(mockRepository);
  });

  group('OpenAppSettingsUseCase', () {
    test('call returns true when repository returns true', () async {
      when(mockRepository.openAppSettings()).thenAnswer((_) async => true);

      final result = await useCase.call();

      expect(result, isTrue);
      verify(mockRepository.openAppSettings()).called(1);
    });

    test('call returns false when repository returns false', () async {
      when(mockRepository.openAppSettings()).thenAnswer((_) async => false);

      final result = await useCase.call();

      expect(result, isFalse);
      verify(mockRepository.openAppSettings()).called(1);
    });
  });
}
