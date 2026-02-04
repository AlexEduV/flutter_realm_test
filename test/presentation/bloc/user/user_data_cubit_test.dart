import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_usecase.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

import 'user_data_cubit_test.mocks.dart';

@GenerateMocks([BaseLocalStorage, RequestLocationPermissionUseCase, GeolocatorPlatform])
void main() {
  late MockBaseLocalStorage mockLocalStorage;
  late MockRequestLocationPermissionUseCase mockRequestLocationPermissionUseCase;
  late UserDataCubit cubit;
  late UserEntity testUser;

  setUp(() {
    mockLocalStorage = MockBaseLocalStorage();
    mockRequestLocationPermissionUseCase = MockRequestLocationPermissionUseCase();
    cubit = UserDataCubit(mockLocalStorage, mockRequestLocationPermissionUseCase);
    testUser = const UserEntity(
      userId: 'u1',
      firstName: 'John',
      lastName: 'Doe',
      isLocationPermissionGranted: false,
    );
  });

  group('UserDataCubit', () {
    test('init sets user from local storage', () {
      when(mockLocalStorage.initUser()).thenReturn(testUser);

      cubit.init();

      expect(cubit.user, testUser);
    });

    blocTest<UserDataCubit, UserDataState>(
      'requestLocationPermission does nothing if permission not granted',
      build: () {
        when(mockRequestLocationPermissionUseCase.call(null)).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) async {
        await cubit.requestLocationPermission();
      },
      expect: () => [],
    );

    //todo: permission handler is harder to mock
    // blocTest<UserDataCubit, UserDataState>(
    //   'requestLocationPermission updates permission status and opens location settings if service not enabled',
    //   build: () {
    //     when(mockPermissionRepository.requestLocationPermission()).thenAnswer((_) async => true);
    //     when(mockLocalStorage.initUser()).thenReturn(testUser);
    //     when(mockLocalStorage.update(any)).thenReturn(null);
    //     // Mock Geolocator static methods
    //     GeolocatorPlatform.instance = MockGeolocatorPlatform();
    //     cubit.init();
    //     return cubit;
    //   },
    //   act: (cubit) async {
    //     await cubit.requestLocationPermission();
    //   },
    //   expect: () => [const UserDataState(isLocationPermissionGranted: true)],
    // );

    blocTest<UserDataCubit, UserDataState>(
      'updateLocationPermissionStatus updates user and emits new state',
      build: () {
        when(mockLocalStorage.update(any)).thenReturn(null);
        cubit.user = testUser;
        return cubit;
      },
      act: (cubit) {
        cubit.updateLocationPermissionStatus(true);
      },
      expect: () => [const UserDataState(isLocationPermissionGranted: true)],
    );
  });
}
