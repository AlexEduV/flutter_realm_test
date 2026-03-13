import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';

import 'permission_repository_test.mocks.dart';

@GenerateMocks([PermissionRepository])
void main() {
  late MockPermissionRepository mockRepository;

  setUp(() {
    mockRepository = MockPermissionRepository();
  });

  group('PermissionRepository', () {
    test('requestLocationPermission returns a Future<bool>', () async {
      when(mockRepository.requestLocationPermission()).thenAnswer((_) async => true);

      final result = await mockRepository.requestLocationPermission();

      expect(result, isA<bool>());
      expect(result, isTrue);
    });

    test('checkLocationPermissionState returns a Future<PermissionStatus>', () async {
      when(
        mockRepository.checkLocationPermissionState(),
      ).thenAnswer((_) async => PermissionStatus.denied);

      final result = await mockRepository.checkLocationPermissionState();

      expect(result, isA<PermissionStatus>());
      expect(result.isGranted, isFalse);
    });
  });
}
