import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/last_seen_car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/auth_repository.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

import 'user_data_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TimeService>(),
  MockSpec<AuthRepository>(),
  MockSpec<UserRepository>(),
  MockSpec<ImagePickerRepository>(),
  MockSpec<CarRepository>(),
  MockSpec<OpenAppSettingsUseCase>(),
  MockSpec<CheckLocationServiceStatusUseCase>(),
  MockSpec<RequestLocationPermissionUseCase>(),
  MockSpec<CheckLocationPermissionStatusUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTimeService mockTimeService;
  late MockUserRepository mockUserRepository;
  late MockImagePickerRepository mockImagePickerRepository;
  late MockCarRepository mockCarRepository;
  late MockRequestLocationPermissionUseCase mockRequestLocationPermissionUseCase;
  late MockCheckLocationPermissionStatusUseCase mockCheckLocationPermissionStatusUseCase;
  late MockCheckLocationServiceStatusUseCase mockCheckLocationServiceStatusUseCase;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late UserDataCubit cubit;
  late UserEntity testUser;

  final mockAuthRepository = MockAuthRepository();
  final appLocalisationsCubit = AppLocalisationsCubit();

  mockRequestLocationPermissionUseCase = MockRequestLocationPermissionUseCase();
  mockCheckLocationPermissionStatusUseCase = MockCheckLocationPermissionStatusUseCase();
  mockCheckLocationServiceStatusUseCase = MockCheckLocationServiceStatusUseCase();
  mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();

  setUp(() {
    SharedPreferences.setMockInitialValues({'userId': ''});

    mockTimeService = MockTimeService();
    mockUserRepository = MockUserRepository();
    mockImagePickerRepository = MockImagePickerRepository();
    mockCarRepository = MockCarRepository();

    when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => false);
    when(mockAuthRepository.updateUser(any)).thenAnswer((_) async {});

    cubit = UserDataCubit(
      mockTimeService,
      mockUserRepository,
      mockAuthRepository,
      mockImagePickerRepository,
      mockCarRepository,
      mockCheckLocationServiceStatusUseCase,
      mockOpenAppSettingsUseCase,
      mockRequestLocationPermissionUseCase,
      mockCheckLocationPermissionStatusUseCase,
      appLocalisationsCubit,
    );
    testUser = const UserEntity(
      userId: 'u1',
      firstName: 'John',
      lastName: 'Doe',
      isLocationPermissionGranted: null,
      favoriteIds: [],
      email: 'mock@gmail.com',
      password: '',
      lastSeenCar: null,
      region: 'uk',
      createdIds: [],
      avatarImageSrc: null,
      viewedIds: [],
    );
    when(mockUserRepository.initUser()).thenReturn(testUser);
  });

  setUpAll(() {
    serviceLocator.registerLazySingleton<AuthRepository>(() => mockAuthRepository);
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    serviceLocator.registerLazySingleton<CheckLocationPermissionStatusUseCase>(
      () => mockCheckLocationPermissionStatusUseCase,
    );
    when(mockCheckLocationPermissionStatusUseCase.call()).thenAnswer((_) async => true);
  });

  tearDownAll(() {
    serviceLocator.unregister<AuthRepository>();
    serviceLocator.unregister<CheckLocationPermissionStatusUseCase>();
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('UserDataCubit', () {
    test('init sets user from local storage', () async {
      when(mockUserRepository.initUser()).thenReturn(testUser);

      await cubit.init();

      expect(cubit.state.user.userId, testUser.userId);
      expect(cubit.state.user.email, testUser.email);
      expect(cubit.state.isLoading, false);
    });

    blocTest<UserDataCubit, UserDataState>(
      'requestLocationPermission emits denied status when permission not granted',
      build: () {
        when(mockRequestLocationPermissionUseCase.call()).thenAnswer((_) async => false);
        when(mockUserRepository.updateUser(any)).thenReturn(null);
        cubit.emit(cubit.state.copyWith(user: testUser));
        return cubit;
      },
      act: (cubit) async {
        await cubit.requestLocationPermission();
      },
      expect: () => [
        isA<UserDataState>().having(
          (state) => state.user.isLocationPermissionGranted,
          'isLocationPermissionGranted',
          false,
        ),
      ],
    );

    blocTest<UserDataCubit, UserDataState>(
      'requestLocationPermission updates permission status and opens location settings if service not enabled',
      build: () {
        when(mockRequestLocationPermissionUseCase.call()).thenAnswer((_) async => true);
        when(mockUserRepository.updateUser(any)).thenReturn(null);
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
        when(mockUserRepository.updateUser(any)).thenReturn(null);
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
      when(mockUserRepository.updateUser(any)).thenReturn(null);
      cubit.addCarIdToFavorites('3');
      expect(cubit.state.user.favoriteIds, contains('3'));
      expect(cubit.state.user.favoriteIds.length, 3);
    });

    test('does not add duplicate carId', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['1', '2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);
      cubit.addCarIdToFavorites('1');
      expect(cubit.state.user.favoriteIds.length, 2);
    });
  });

  group('removeCarIdFromFavorites', () {
    test('removes carId and emits updated state', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['1', '2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);
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

      when(mockUserRepository.getUserByEmail('auth@example.com')).thenReturn(user);
      when(mockUserRepository.initUser()).thenReturn(user);
      when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => true);

      await cubit.authUser('auth@example.com');
      expect(cubit.state.isUserAuthenticated, true);
      expect(cubit.state.user.email, 'auth@example.com');
      expect(cubit.state.user.firstName, 'Auth');
      expect(cubit.state.user.lastName, 'User');
    });

    test('does nothing if user not found', () {
      final prevState = cubit.state;
      when(mockUserRepository.getUserByEmail('notfound@example.com')).thenReturn(null);

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

  group('setFirstName', () {
    test('updates firstName and emits new state', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.setFirstName('Jane');

      expect(cubit.state.user.firstName, 'Jane');
    });
  });

  group('setLastName', () {
    test('updates lastName and emits new state', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.setLastName('Smith');

      expect(cubit.state.user.lastName, 'Smith');
    });
  });

  group('setEmail', () {
    test('updates email and emits new state', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.setEmail('new@email.com');

      expect(cubit.state.user.email, 'new@email.com');
    });
  });

  group('setPassword', () {
    test('updates password and emits new state', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.setPassword('newSecret!1');

      expect(cubit.state.user.password, 'newSecret!1');
    });
  });

  group('setLastSeenCar', () {
    test('sets lastSeenCar with given carId and current timestamp', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      final fixedNow = DateTime(2024, 1, 1, 12);
      when(mockTimeService.now()).thenReturn(fixedNow);
      cubit.setLastSeenCar('car42');

      final lastSeen = cubit.state.user.lastSeenCar;
      expect(lastSeen, isNotNull);
      expect(lastSeen!.carId, 'car42');
      expect(lastSeen.seenAt, fixedNow);
    });
  });

  group('checkLastSeenCarExpiration', () {
    test('does nothing when lastSeenCar is null', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith()));
      final stateBefore = cubit.state;

      cubit.checkLastSeenCarExpiration(days: 7);

      expect(cubit.state, stateBefore);
    });

    test('does not clear recent car that is within expiry window', () {
      final fixedNow = DateTime(2024, 1, 10);
      when(mockTimeService.now()).thenReturn(fixedNow);
      final recentCar = LastSeenCarEntity(carId: 'car1', seenAt: DateTime(2024, 1, 8));
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(lastSeenCar: recentCar)));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.checkLastSeenCarExpiration(days: 7);

      expect(cubit.state.user.lastSeenCar, isNotNull);
      expect(cubit.state.user.lastSeenCar!.carId, 'car1');
    });
  });

  group('updateAvatarImage', () {
    test('does nothing when picker returns null', () async {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockImagePickerRepository.pickImage()).thenAnswer((_) async => null);
      final stateBefore = cubit.state;

      await cubit.updateAvatarImage();

      expect(cubit.state, stateBefore);
    });

    test('updates avatarImageSrc when picker returns a path', () async {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockImagePickerRepository.pickImage()).thenAnswer((_) async => '/path/to/image.png');
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      await cubit.updateAvatarImage();

      expect(cubit.state.user.avatarImageSrc, '/path/to/image.png');
    });
  });

  group('addCarIdToCreated', () {
    test('adds a new carId and emits updated state', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(createdIds: ['c1'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.addCarIdToCreated('c2');

      expect(cubit.state.user.createdIds, containsAll(['c1', 'c2']));
      expect(cubit.state.user.createdIds.length, 2);
    });

    test('deduplicates when same carId is added twice', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(createdIds: ['c1'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.addCarIdToCreated('c1');

      expect(cubit.state.user.createdIds.length, 1);
    });
  });

  group('removeCarIdFromCreated', () {
    test('removes carId, emits updated state, and calls delete use case', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(createdIds: ['c1', 'c2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.removeCarIdFromCreated('c1');

      expect(cubit.state.user.createdIds, isNot(contains('c1')));
      expect(cubit.state.user.createdIds, contains('c2'));
      verify(mockCarRepository.deleteCarById('c1')).called(1);
    });
  });

  group('addCarToRecentlyViewed', () {
    test('does nothing for empty carId', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: [])));
      final stateBefore = cubit.state;

      cubit.addCarToRecentlyViewed('');

      expect(cubit.state, stateBefore);
    });

    test('does nothing if carId is the same as the last viewed', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: ['car1'])));
      final stateBefore = cubit.state;

      cubit.addCarToRecentlyViewed('car1');

      expect(cubit.state, stateBefore);
    });

    test('appends new carId to the list', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: ['car1'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.addCarToRecentlyViewed('car2');

      expect(cubit.state.user.viewedIds, ['car1', 'car2']);
    });

    test('trims list to 20 most recent entries when limit is exceeded', () {
      final existing = List.generate(20, (i) => 'car$i');
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: existing)));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.addCarToRecentlyViewed('carNew');

      expect(cubit.state.user.viewedIds.length, 20);
      expect(cubit.state.user.viewedIds.last, 'carNew');
      expect(cubit.state.user.viewedIds, isNot(contains('car0')));
    });
  });

  group('clearFavorites', () {
    test('does nothing when favorites are already empty', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: [])));
      final stateBefore = cubit.state;

      cubit.clearFavorites();

      expect(cubit.state, stateBefore);
    });

    test('clears favoriteIds and emits updated state', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(favoriteIds: ['c1', 'c2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.clearFavorites();

      expect(cubit.state.user.favoriteIds, isEmpty);
    });
  });

  group('clearRecentItems', () {
    test('does nothing when viewedIds are already empty', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: [])));
      final stateBefore = cubit.state;

      cubit.clearRecentItems();

      expect(cubit.state, stateBefore);
    });

    test('clears viewedIds and emits updated state', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(viewedIds: ['v1', 'v2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.clearRecentItems();

      expect(cubit.state.user.viewedIds, isEmpty);
    });
  });

  group('clearMyItems', () {
    test('does nothing when createdIds are already empty', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(createdIds: [])));
      final stateBefore = cubit.state;

      cubit.clearMyItems();

      expect(cubit.state, stateBefore);
      verifyNever(mockCarRepository.deleteCarById(any));
    });

    test('deletes each car and clears createdIds', () {
      cubit.emit(cubit.state.copyWith(user: testUser.copyWith(createdIds: ['c1', 'c2'])));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.clearMyItems();

      expect(cubit.state.user.createdIds, isEmpty);
      verify(mockCarRepository.deleteCarById('c1')).called(1);
      verify(mockCarRepository.deleteCarById('c2')).called(1);
    });
  });

  group('clearAllData', () {
    test('clears favorites, created items, and recent items', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: ['f1'], createdIds: ['c1'], viewedIds: ['v1']),
        ),
      );
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.clearAllData();

      expect(cubit.state.user.favoriteIds, isEmpty);
      expect(cubit.state.user.createdIds, isEmpty);
      expect(cubit.state.user.viewedIds, isEmpty);
    });

    test('isDataClear is true after clearAllData', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: ['f1'], createdIds: ['c1'], viewedIds: ['v1']),
        ),
      );
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.clearAllData();

      expect(cubit.state.isDataClear, isTrue);
    });
  });

  group('updateRegion', () {
    test('does nothing when region is null', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      final stateBefore = cubit.state;

      cubit.updateRegion(null);

      expect(cubit.state, stateBefore);
    });

    test('does nothing when region is the same as current', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      final stateBefore = cubit.state;

      cubit.updateRegion(testUser.region);

      expect(cubit.state, stateBefore);
    });

    test('updates region and emits state when region changes', () {
      cubit.emit(cubit.state.copyWith(user: testUser));
      when(mockUserRepository.updateUser(any)).thenReturn(null);

      cubit.updateRegion('de');

      expect(cubit.state.user.region, 'de');
    });
  });

  group('openLocationSettings', () {
    test('returns true when settings can be opened', () async {
      when(mockOpenAppSettingsUseCase.call()).thenAnswer((_) async => true);

      final result = await cubit.openLocationSettings();

      expect(result, isTrue);
    });

    test('returns false when settings cannot be opened', () async {
      when(mockOpenAppSettingsUseCase.call()).thenAnswer((_) async => false);

      final result = await cubit.openLocationSettings();

      expect(result, isFalse);
    });
  });

  group('requestLocationPermission (service enabled)', () {
    test('does not open app settings when location service is already enabled', () async {
      when(mockRequestLocationPermissionUseCase.call()).thenAnswer((_) async => true);
      when(mockUserRepository.updateUser(any)).thenReturn(null);
      when(mockCheckLocationServiceStatusUseCase.call()).thenAnswer((_) async => true);
      cubit.emit(cubit.state.copyWith(user: testUser));

      clearInteractions(mockOpenAppSettingsUseCase);
      await cubit.requestLocationPermission();

      expect(cubit.state.user.isLocationPermissionGranted, isTrue);
      verifyNever(mockOpenAppSettingsUseCase.call());
    });
  });

  group('UserDataState.isDataClear', () {
    test('returns true when all lists are empty', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: [], createdIds: [], viewedIds: []),
        ),
      );
      expect(cubit.state.isDataClear, isTrue);
    });

    test('returns false when favorites are not empty', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: ['f1'], createdIds: [], viewedIds: []),
        ),
      );
      expect(cubit.state.isDataClear, isFalse);
    });

    test('returns false when viewedIds are not empty', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: [], createdIds: [], viewedIds: ['v1']),
        ),
      );
      expect(cubit.state.isDataClear, isFalse);
    });

    test('returns false when createdIds are not empty', () {
      cubit.emit(
        cubit.state.copyWith(
          user: testUser.copyWith(favoriteIds: [], createdIds: ['c1'], viewedIds: []),
        ),
      );
      expect(cubit.state.isDataClear, isFalse);
    });
  });
}
