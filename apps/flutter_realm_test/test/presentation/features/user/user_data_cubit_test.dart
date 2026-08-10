import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/usecases/database/delete_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_flutter_project/domain/usecases/image_picker/pick_image_from_gallery_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_email_use_case.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

import '../../../domain/repositories/base_local_storage_test.mocks.dart';
import 'user_data_cubit_test.mocks.dart' hide MockBaseLocalStorage;

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<BaseLocalStorage>(),
  MockSpec<OpenAppSettingsUseCase>(),
  MockSpec<CheckLocationServiceStatusUseCase>(),
  MockSpec<RequestLocationPermissionUseCase>(),
  MockSpec<CheckLocationPermissionStatusUseCase>(),
  MockSpec<GetUserByEmailUseCase>(),
  MockSpec<PickImageFromGalleryUseCase>(),
  MockSpec<DeleteCarByIdUseCase>(),
  MockSpec<LoggingService>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBaseLocalStorage mockLocalStorage;
  late MockRequestLocationPermissionUseCase mockRequestLocationPermissionUseCase;
  late MockCheckLocationPermissionStatusUseCase mockCheckLocationPermissionStatusUseCase;
  late MockCheckLocationServiceStatusUseCase mockCheckLocationServiceStatusUseCase;
  late MockGetUserByEmailUseCase mockGetUserByEmailUseCase;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late MockPickImageFromGalleryUseCase mockPickImageFromGalleryUseCase;
  late MockDeleteCarByIdUseCase mockDeleteCarByIdUseCase;
  late UserDataCubit cubit;
  late UserEntity testUser;
  late MockLoggingService mockBaseLogger;

  final mockAuthRepository = MockAuthRepository();
  final appLocalisationsCubit = AppLocalisationsCubit();

  mockRequestLocationPermissionUseCase = MockRequestLocationPermissionUseCase();
  mockCheckLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();
  mockCheckLocationServiceStatusUseCase = MockCheckLocationServiceStatusUseCase();
  mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();
  mockGetUserByEmailUseCase = MockGetUserByEmailUseCase();
  mockPickImageFromGalleryUseCase = MockPickImageFromGalleryUseCase();
  mockDeleteCarByIdUseCase = MockDeleteCarByIdUseCase();
  mockBaseLogger = MockLoggingService();

  setUp(() {
    SharedPreferences.setMockInitialValues({'userId': ''});

    mockLocalStorage = MockBaseLocalStorage();

    when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => false);
    when(mockAuthRepository.updateUser(any, any)).thenAnswer((_) async {});

    cubit = UserDataCubit(
      mockLocalStorage,
      mockAuthRepository,
      mockCheckLocationServiceStatusUseCase,
      mockOpenAppSettingsUseCase,
      mockRequestLocationPermissionUseCase,
      mockCheckLocationPermissionStatusUseCase,
      mockGetUserByEmailUseCase,
      mockPickImageFromGalleryUseCase,
      mockDeleteCarByIdUseCase,
      mockBaseLogger,
      appLocalisationsCubit,
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

      expect(cubit.state.user.userId, testUser.userId);
      expect(cubit.state.user.email, testUser.email);
      expect(cubit.state.isLoading, false);
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
        when(mockLocalStorage.update(any)).thenReturn(null);
        when(mockCheckLocationServiceStatusUseCase.call()).thenAnswer((_) async => false);
        when(mockOpenAppSettingsUseCase.call()).thenAnswer((_) async => true);
        cubit.emit(cubit.state.copyWith(user: testUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.requestLocationPermission();
      },
      expect: () => [
        isA<UserDataState>().having(
          (state) => state.user.isLocationPermissionGranted,
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
        cubit.emit(cubit.state.copyWith(user: testUser));
        return cubit;
      },
      act: (cubit) {
        cubit.updateLocationPermissionStatus(true);
      },
      expect: () => [
        isA<UserDataState>().having(
          (state) => state.user.isLocationPermissionGranted,
          'isLocationPermissionGranted',
          true,
        ),
      ],
    );
  });

  group('addCarIdToFavorites', () {
    test('adds new carId and emits updated state without duplicates', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['1', '2'])));
      when(mockLocalStorage.update(any)).thenReturn(null);
      cubit.addCarIdToFavorites('3');
      expect(cubit.state.user.favoriteIds, contains('3'));
      expect(cubit.state.user.favoriteIds.length, 3);
    });

    test('does not add duplicate carId', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['1', '2'])));
      when(mockLocalStorage.update(any)).thenReturn(null);
      cubit.addCarIdToFavorites('1');
      expect(cubit.state.user.favoriteIds.length, 2);
    });
  });

  group('removeCarIdFromFavorites', () {
    test('removes carId and emits updated state', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['1', '2'])));
      when(mockLocalStorage.update(any)).thenReturn(null);
      cubit.removeCarIdFromFavorites('1');
      expect(cubit.state.user.favoriteIds, isNot(contains('1')));
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

      when(mockGetUserByEmailUseCase.call('auth@example.com')).thenReturn(user);
      when(mockLocalStorage.initUser()).thenReturn(user);
      when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => true);

      await cubit.authUser('auth@example.com');
      expect(cubit.state.isUserAuthenticated, true);
      expect(cubit.state.user.email, 'auth@example.com');
      expect(cubit.state.user.firstName, 'Auth');
      expect(cubit.state.user.lastName, 'User');
    });

    test('does nothing if user not found', () {
      final prevState = cubit.state;
      when(mockGetUserByEmailUseCase.call('notfound@example.com')).thenReturn(null);

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
