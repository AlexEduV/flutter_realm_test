import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../domain/repositories/base_local_storage_test.mocks.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<OwnerRepository>(),
  MockSpec<UsersRemoteDataSource>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepositoryImpl repo;

  final mockLocalStorage = MockBaseLocalStorage();
  final mockOwnerRepository = MockOwnerRepository();
  final mockUsersRemoteDataSource = MockUsersRemoteDataSource();

  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() async {
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
    final prefs = await SharedPreferences.getInstance();

    final localisations = {
      'forms.warnings.userNotFound': 'User not found',
      'forms.warnings.incorrectPassword': 'Incorrect password',
      'forms.warnings.userAlreadyExists': 'User already exists',
    };

    appLocalisationsCubit.load(localisations);

    when(mockLocalStorage.initUser()).thenReturn(initUsers.first);
    when(mockUsersRemoteDataSource.getMaxUserId()).thenReturn(1);
    when(mockUsersRemoteDataSource.saveMockUsers(any)).thenAnswer((_) async {});

    repo = AuthRepositoryImpl(
      mockLocalStorage,
      prefs,
      mockUsersRemoteDataSource,
      mockOwnerRepository,
    );
    repo.users = initUsers;
  });

  setUpAll(() {
    serviceLocator.registerLazySingleton(() => appLocalisationsCubit);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
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
      final result = await repo.login(email: 'unique@example.com', password: 'UniquePass!');
      expect(result.success, isTrue);
    });
  });

  group('logOut', () {
    test('completes without error', () async {
      await repo.logOut();
      expect(true, isTrue);
    });
  });
}
