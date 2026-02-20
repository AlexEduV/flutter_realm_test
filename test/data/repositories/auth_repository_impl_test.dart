import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_futter_project/domain/entities/user_entity_short.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../domain/repositories/base_local_storage_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepositoryImpl repo;

  final mockLocalStorage = MockBaseLocalStorage();

  setUp(() {
    final initUsers = {
      '1': const UserEntityShort(
        userId: '1',
        email: 'mock@example.com',
        password: 'Password1!',
        firstName: 'Alex',
        lastName: 'Smith',
      ),
      '2': const UserEntityShort(
        userId: '2',
        email: 'admin@example.com',
        password: 'AdminPass123!',
        firstName: 'admin',
        lastName: '',
      ),
    };

    SharedPreferences.setMockInitialValues(initUsers);

    // Set up localisations for error messages
    AppLocalisations.localisations = {
      'forms.warnings.userNotFound': 'User not found',
      'forms.warnings.incorrectPassword': 'Incorrect password',
      'forms.warnings.userAlreadyExists': 'User already exists',
    };
    repo = AuthRepositoryImpl(mockLocalStorage);
    repo.users = initUsers;
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
      expect(result.message, AppLocalisations.authErrorUserNotFoundMessage);
    });

    test('returns incorrect password for wrong password', () async {
      final result = await repo.login(email: 'mock@example.com', password: 'wrongpassword');
      expect(result.success, isFalse);
      expect(result.message, AppLocalisations.authErrorIncorrectPassword);
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
      expect(result.message, AppLocalisations.authErrorUserAlreadyExists);
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
