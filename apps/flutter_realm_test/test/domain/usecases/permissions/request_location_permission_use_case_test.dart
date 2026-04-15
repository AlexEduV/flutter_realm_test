import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';

import '../../repositories/permission_repository_test.mocks.dart';

void main() {
  group('RequestLocationPermissionUseCase', () {
    late MockPermissionRepository mockPermissionRepository;
    late RequestLocationPermissionUseCase useCase;

    setUp(() {
      mockPermissionRepository = MockPermissionRepository();
      useCase = RequestLocationPermissionUseCase(mockPermissionRepository);
    });

    test('calls requestLocationPermission on repository and returns the result', () async {
      when(mockPermissionRepository.requestLocationPermission()).thenAnswer((_) async => true);

      final result = await useCase.call();

      expect(result, isTrue);
      verify(mockPermissionRepository.requestLocationPermission()).called(1);
    });
  });
}
