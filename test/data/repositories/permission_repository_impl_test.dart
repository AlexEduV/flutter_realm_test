//todo: permission platform is not mocked easily

/*
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/data/repositories/permission_repository_impl.dart';
import 'package:test_futter_project/domain/repositories/permission_repository.dart';

@GenerateMocks([Permission, PermissionStatus])
void main() {
  late PermissionRepositoryImpl repository;
  late MockPermission mockPermission;
  late MockPermissionStatus mockStatus;

  setUp(() {
    repository = PermissionRepositoryImpl();
    mockPermission = MockPermission();
    mockStatus = MockPermissionStatus();
  });

  group('PermissionRepositoryImpl', () {
    test('requestLocationPermission returns true when permission is granted', () async {
      // Arrange
      when(Permission.location.request()).thenAnswer((_) async => PermissionStatus.granted);

      // Act
      final result = await repository.requestLocationPermission();

      // Assert
      expect(result, isTrue);
    });

    test('requestLocationPermission returns false when permission is denied', () async {
      when(Permission.location.request()).thenAnswer((_) async => PermissionStatus.denied);

      final result = await repository.requestLocationPermission();

      expect(result, isFalse);
    });

    test('checkLocationPermissionState returns true when permission is granted', () async {
      when(Permission.location.status).thenAnswer((_) async => PermissionStatus.granted);

      final result = await repository.checkLocationPermissionState();

      expect(result, isTrue);
    });

    test('checkLocationPermissionState returns false when permission is denied', () async {
      when(Permission.location.status).thenAnswer((_) async => PermissionStatus.denied);

      final result = await repository.checkLocationPermissionState();

      expect(result, isFalse);
    });
  });
}

 */

void main() {}
