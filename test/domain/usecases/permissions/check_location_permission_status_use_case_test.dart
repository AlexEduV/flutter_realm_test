import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';

import '../../repositories/permission_repository_test.mocks.dart';

void main() {
  group('CheckLocationPermissionStatusUseCase', () {
    late MockPermissionRepository mockPermissionRepository;
    late CheckLocationPermissionStatusUseCase useCase;

    setUp(() {
      mockPermissionRepository = MockPermissionRepository();
      useCase = CheckLocationPermissionStatusUseCase(mockPermissionRepository);
    });

    test('calls checkLocationPermissionState on repository and returns the result', () async {
      when(mockPermissionRepository.checkLocationPermissionState()).thenAnswer((_) async => true);

      final result = await useCase.call();

      expect(result, isTrue);
      verify(mockPermissionRepository.checkLocationPermissionState()).called(1);
    });
  });
}
