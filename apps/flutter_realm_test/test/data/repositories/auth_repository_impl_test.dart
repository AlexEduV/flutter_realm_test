import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/owners/fetch_owners_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_max_user_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/save_users_use_case.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../domain/repositories/base_local_storage_test.mocks.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([FetchOwnersUseCase, GetMaxUserIdUseCase, SaveUsersUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepositoryImpl repo;

  final mockLocalStorage = MockBaseLocalStorage();
  final mockFetchOwnersUseCase = MockFetchOwnersUseCase();
  final mockGetMaxUserIdUseCase = MockGetMaxUserIdUseCase();
  final mockSaveUsersUseCase = MockSaveUsersUseCase();

  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    final initUsers = [
      UserEntity.initial(
        userId: '1',
        email: 'mock@example.com',
        password: 'Password1!',
        firstName: 'Alex',
        lastName: 'Smith',
      ),
      UserEntity.initial(
        userId: '2',
        email: 'admin@example.com',
        password: 'AdminPass123!',
        firstName: 'admin',
        lastName: '',
      ),
    ];

    SharedPreferences.setMockInitialValues({'mock_users': initUsers});

    // Set up localisations for error messages
    final localisations = {
      'forms.warnings.userNotFound': 'User not found',
      'forms.warnings.incorrectPassword': 'Incorrect password',
      'forms.warnings.userAlreadyExists': 'User already exists',
    };

    appLocalisationsCubit.load(localisations);

    repo = AuthRepositoryImpl(mockLocalStorage, mockFetchOwnersUseCase);
    repo.users = initUsers;

    when(mockLocalStorage.initUser()).thenReturn(initUsers.first);
    when(mockGetMaxUserIdUseCase.call()).thenReturn(1);
  });

  setUpAll(() {
    serviceLocator.registerLazySingleton(() => appLocalisationsCubit);
    serviceLocator.registerLazySingleton<GetMaxUserIdUseCase>(() => mockGetMaxUserIdUseCase);
    serviceLocator.registerLazySingleton<SaveUsersUseCase>(() => mockSaveUsersUseCase);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
    serviceLocator.unregister<GetMaxUserIdUseCase>();
    serviceLocator.unregister<SaveUsersUseCase>();
  });

  group('login', () {
    test('returns success for correct credentials', () async {
      final result = await repo.login(email: 'mock@example.com', password: 'Password1!');
      expect(result.success, isTrue);
      expect(result.message, isNull);
    });

    test('returns user not found for unknown email', () async {
      final result = await repo.login(email: 'unknown@example.com', password: 'Password1!');
      expect(result.success, isFalse);
      expect(
        result.message,
        serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserNotFoundMessage,
        ),
      );
    });

    test('returns incorrect password for wrong password', () async {
      final result = await repo.login(email: 'mock@example.com', password: 'wrongpassword');
      expect(result.success, isFalse);
      expect(
        result.message,
        serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorIncorrectPassword,
        ),
      );
    });
  });

  group('register', () {
    test('returns success for new user', () async {
      final result = await repo.register(
        email: 'new@example.com',
        password: 'NewPass123!',
        firstName: 'User',
        lastName: 'Test',
      );
      expect(result.success, isTrue);
      expect(result.message, isNull);
    });

    test('returns user already exists for duplicate email', () async {
      final result = await repo.register(
        email: 'mock@example.com',
        password: 'Password1!',
        firstName: 'Test',
        lastName: 'User',
      );
      expect(result.success, isFalse);
      expect(
        result.message,
        serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
          L10nKeys.authErrorUserAlreadyExists,
        ),
      );
    });

    test('actually adds the user to the repository', () async {
      await repo.register(
        email: 'unique@example.com',
        password: 'UniquePass!',
        firstName: 'Unique',
        lastName: 'User',
      );
      // Now login should succeed
      final result = await repo.login(email: 'unique@example.com', password: 'UniquePass!');
      expect(result.success, isTrue);
    });
  });

  group('logOut', () {
    test('completes without error', () async {
      await repo.logOut();
      // No exception means pass
      expect(true, isTrue);
    });
  });
}
