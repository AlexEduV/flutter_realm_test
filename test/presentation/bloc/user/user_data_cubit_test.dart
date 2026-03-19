import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';
import 'package:test_futter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_email_use_case.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

import '../../../data/data_sources/remote/auth_remote_data_source_impl_test.mocks.dart';
import 'user_data_cubit_test.mocks.dart';

@GenerateMocks([
  BaseLocalStorage,
  OpenAppSettingsUseCase,
  CheckLocationServiceStatusUseCase,
  RequestLocationPermissionUseCase,
  CheckLocationPermissionStatusUseCase,
  GetUserByEmailUseCase,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBaseLocalStorage mockLocalStorage;
  late MockRequestLocationPermissionUseCase mockRequestLocationPermissionUseCase;
  late MockCheckLocationPermissionStatusUseCase mockCheckLocationPermissionStatusUseCase;
  late MockCheckLocationServiceStatusUseCase mockCheckLocationServiceStatusUseCase;
  late MockGetUserByEmailUseCase mockGetUserByEmailUseCase;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late UserDataCubit cubit;
  late UserEntity testUser;

  final mockAuthRepository = MockAuthRepository();
  final appLocalisationsCubit = AppLocalisationsCubit();

  mockRequestLocationPermissionUseCase = MockRequestLocationPermissionUseCase();
  mockCheckLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();
  mockCheckLocationServiceStatusUseCase = MockCheckLocationServiceStatusUseCase();
  mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();
  mockGetUserByEmailUseCase = MockGetUserByEmailUseCase();

  setUp(() {
    SharedPreferences.setMockInitialValues({'userId': ''});

    mockLocalStorage = MockBaseLocalStorage();

    cubit = UserDataCubit(
      mockLocalStorage,
      mockCheckLocationServiceStatusUseCase,
      mockOpenAppSettingsUseCase,
      mockRequestLocationPermissionUseCase,
      mockCheckLocationPermissionStatusUseCase,
      mockGetUserByEmailUseCase,
    );
    testUser = const UserEntity(
      userId: 'u1',
      firstName: 'John',
      lastName: 'Doe',
      isLocationPermissionGranted: false,
      favoriteIds: [],
      email: 'mock@gmail.com',
      password: '',
      lastSeenCar: null,
      region: 'uk',
      createdIds: [],
      avatarImageSrc: null,
      viewedIds: [],
    );
    when(mockLocalStorage.initUser()).thenReturn(testUser);
  });

  setUpAll(() {
    serviceLocator.registerLazySingleton<AuthRepository>(() => mockAuthRepository);
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    serviceLocator.registerLazySingleton<CheckLocationPermissionStatusUseCase>(
      () => mockCheckLocationPermissionStatusUseCase,
    );
    when(
      mockCheckLocationPermissionStatusUseCase.call(),
    ).thenAnswer((_) async => PermissionStatus.granted);
  });

  tearDownAll(() {
    serviceLocator.unregister<AuthRepository>();
    serviceLocator.unregister<CheckLocationPermissionStatusUseCase>();
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('UserDataCubit', () {
    test('init sets user from local storage', () async {
      when(mockLocalStorage.initUser()).thenReturn(testUser);

      await cubit.init();

      expect(cubit.user, testUser);
    });

    blocTest<UserDataCubit, UserDataState>(
      'requestLocationPermission does nothing if permission not granted',
      build: () {
        when(mockRequestLocationPermissionUseCase.call()).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) async {
        await cubit.requestLocationPermission();
      },
      expect: () => [],
    );

    blocTest<UserDataCubit, UserDataState>(
      'requestLocationPermission updates permission status and opens location settings if service not enabled',
      build: () {
        when(mockRequestLocationPermissionUseCase.call()).thenAnswer((_) async => true);
        when(mockLocalStorage.initUser()).thenReturn(testUser);
        when(mockLocalStorage.update(any)).thenReturn(null);

        when(mockCheckLocationServiceStatusUseCase.call()).thenAnswer((_) async => false);
        when(mockOpenAppSettingsUseCase.call()).thenAnswer((_) async => true);

        cubit.init();
        return cubit;
      },
      act: (cubit) async {
        await cubit.requestLocationPermission();
      },
      expect: () => [
        const UserDataState(isLoading: true, isLocationPermissionGranted: true),
        isA<UserDataState>()
            .having(
              (state) => state.isLoading, // The property to check
              'loading', // Description for failure messages
              false, // The expected value
            )
            .having(
              (state) => state.isLocationPermissionGranted,
              'locationPermissionGranted',
              true,
            ),
      ],
      verify: (cubit) {
        verify(mockOpenAppSettingsUseCase.call()).called(1);
        verify(mockCheckLocationServiceStatusUseCase.call()).called(1);
      },
    );

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

  group('addCarIdToFavorites', () {
    test('adds new carId and emits updated state without duplicates', () {
      cubit.user = const UserEntity(
        favoriteIds: ['1', '2'],
        email: 'test@example.com',
        password: '',
        firstName: 'Test',
        lastName: 'User',
        userId: '1',
        isLocationPermissionGranted: false,
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
      );
      cubit.addCarIdToFavorites('3');
      expect(cubit.user.favoriteIds, contains('3'));
      expect(cubit.user.favoriteIds.length, 3);
    });

    test('does not add duplicate carId', () {
      cubit.user = const UserEntity(
        favoriteIds: ['1', '2'],
        email: 'test@example.com',
        password: '',
        firstName: 'Test',
        lastName: 'User',
        userId: '1',
        isLocationPermissionGranted: false,
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
      );

      cubit.addCarIdToFavorites('1');
      // Should still only have 2 unique IDs
      expect(cubit.user.favoriteIds.length, 2);
    });
  });

  group('removeCarIdFromFavorites', () {
    test('removes carId and emits updated state', () {
      cubit.user = const UserEntity(
        favoriteIds: ['1', '2'],
        email: 'test@example.com',
        password: '',
        firstName: 'Test',
        lastName: 'User',
        userId: '1',
        isLocationPermissionGranted: false,
        lastSeenCar: null,
        region: 'uk',
        createdIds: [],
        avatarImageSrc: null,
        viewedIds: [],
      );

      cubit.removeCarIdFromFavorites('1');
      expect(cubit.user.favoriteIds, isNot(contains('1')));
    });
  });

  group('authUser', () {
    test('emits authenticated state with user data', () async {
      final user = UserEntity.initial(
        userId: '1',
        email: 'auth@example.com',
        password: 'qwertyUI10!',
        firstName: 'Auth',
        lastName: 'User',
      );

      //todo: this is outdated
      //MockUsers.initialUsers = [user];

      when(mockLocalStorage.initUser()).thenReturn(user);

      await cubit.authUser('auth@example.com');
      expect(cubit.state.isUserAuthenticated, true);
      expect(cubit.state.email, 'auth@example.com');
      expect(cubit.state.firstName, 'Auth');
      expect(cubit.state.lastName, 'User');
    });

    test('does nothing if user not found', () {
      final prevState = cubit.state;
      cubit.authUser('notfound@example.com');
      expect(cubit.state, prevState);
    });
  });

  group('logOutUser', () {
    test('emits unauthenticated state', () {
      cubit.emit(cubit.state.copyWith(isUserAuthenticated: true));
      cubit.logOutUser();
      expect(cubit.state.isUserAuthenticated, false);
    });
  });
}
