import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';

import '../../../data/data_sources/remote/article_remote_data_source_impl_test.mocks.dart';
import 'check_location_service_status_use_case_test.mocks.dart';

void main() {
  late MockLoggingService mockLoggingService;
  late MockGeolocatorRepository mockRepository;
  late OpenAppSettingsUseCase useCase;

  setUp(() {
    mockLoggingService = MockLoggingService();
    mockRepository = MockGeolocatorRepository();
    useCase = OpenAppSettingsUseCase(mockLoggingService, mockRepository);
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
