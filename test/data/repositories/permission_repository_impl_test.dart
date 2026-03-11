import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/permission_service.dart';

import 'permission_repository_impl_test.mocks.dart'; // Import the generated mock

@GenerateMocks([PermissionService])
void main() {
  late MockPermissionService mockPermissionService;
  late PermissionRepositoryImpl permissionRepository;

  setUp(() {
    mockPermissionService = MockPermissionService();
    permissionRepository = PermissionRepositoryImpl(mockPermissionService);
  });

  test('requestLocationPermission returns true when permission is granted', () async {
    when(mockPermissionService.requestLocation()).thenAnswer((_) async => PermissionStatus.granted);

    final result = await permissionRepository.requestLocationPermission();
    expect(result, isTrue);
  });

  test('requestLocationPermission returns false when permission is denied', () async {
    when(mockPermissionService.requestLocation()).thenAnswer((_) async => PermissionStatus.denied);

    final result = await permissionRepository.requestLocationPermission();
    expect(result, isFalse);
  });

  test('checkLocationPermissionState returns true when permission is granted', () async {
    when(
      mockPermissionService.checkLocationStatus(),
    ).thenAnswer((_) async => PermissionStatus.granted);

    final result = await permissionRepository.checkLocationPermissionState();
    expect(result, isTrue);
  });

  test('checkLocationPermissionState returns false when permission is denied', () async {
    when(
      mockPermissionService.checkLocationStatus(),
    ).thenAnswer((_) async => PermissionStatus.denied);

    final result = await permissionRepository.checkLocationPermissionState();
    expect(result, isFalse);
  });
}
