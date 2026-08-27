import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:test_flutter_project/common/enums/auth_error_code.dart';
import 'package:test_flutter_project/data/data_sources/remote/shared_preferences_storage.dart';
import 'package:test_flutter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';

import '../../common/fakes/common_mocks.mocks.dart';
import 'auth_repository_impl_test.mocks.dart';
import 'inbox_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<OwnerRepository>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepositoryImpl repo;

  final mockLocalStorage = MockAppLocalStorage();
  final mockOwnerRepository = MockOwnerRepository();
  final mockUsersRemoteDataSource = MockUsersRemoteDataSource();
  final mockMessagesRemoteDataSource = MockMessagesRemoteDataSource();

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

    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    final prefs = SharedPreferencesAsync();
    final cloudStorage = SharedPreferencesStorage(prefs);

    when(mockLocalStorage.initUser()).thenReturn(initUsers.first);
    when(mockUsersRemoteDataSource.getMaxUserId()).thenReturn(1);
    when(mockUsersRemoteDataSource.saveSeedUsers(any)).thenAnswer((_) async {});
    when(mockUsersRemoteDataSource.users).thenReturn(initUsers);

    repo = AuthRepositoryImpl(
      mockLocalStorage,
      cloudStorage,
      mockUsersRemoteDataSource,
      mockMessagesRemoteDataSource,
      mockOwnerRepository,
    );

    await repo.init();
  });

  group('login', () {
    test('returns success for correct credentials', () async {
      final result = await repo.login(email: 'mock@example.com', password: 'Password1!');
      expect(result, isA<AuthSuccess>());
    });

    test('returns user not found for unknown email', () async {
      final result = await repo.login(email: 'unknown@example.com', password: 'Password1!');
      expect(result, const AuthFailure(AuthErrorCode.userNotFound));
    });

    test('returns incorrect password for wrong password', () async {
      final result = await repo.login(email: 'mock@example.com', password: 'wrongpassword');
      expect(result, const AuthFailure(AuthErrorCode.incorrectPassword));
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
      expect(result, isA<AuthSuccess>());
    });

    test('returns user already exists for duplicate email', () async {
      final result = await repo.register(
        email: 'mock@example.com',
        password: 'Password1!',
        firstName: 'Test',
        lastName: 'User',
      );
      expect(result, const AuthFailure(AuthErrorCode.userAlreadyExists));
    });

    test('actually adds the user to the repository', () async {
      await repo.register(
        email: 'unique@example.com',
        password: 'UniquePass!',
        firstName: 'Unique',
        lastName: 'User',
      );
      final result = await repo.login(email: 'unique@example.com', password: 'UniquePass!');
      expect(result, isA<AuthSuccess>());
    });
  });

  group('logOut', () {
    test('completes without error', () async {
      await repo.logOut();
      expect(true, isTrue);
    });
  });
}
