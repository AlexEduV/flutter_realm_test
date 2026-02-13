import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/data/repositories/auth_repository_impl.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  late AuthRepositoryImpl repo;

  setUp(() {
    // Set up localisations for error messages
    AppLocalisations.localisations = {
      'forms.warnings.userNotFound': 'User not found',
      'forms.warnings.incorrectPassword': 'Incorrect password',
      'forms.warnings.userAlreadyExists': 'User already exists',
    };
    repo = AuthRepositoryImpl();
  });

  group('login', () {
    test('returns success for correct credentials', () async {
      final result = await repo.login('mock@example.com', 'Password1!');
      expect(result.success, isTrue);
      expect(result.message, isNull);
    });

    test('returns user not found for unknown email', () async {
      final result = await repo.login('unknown@example.com', 'Password1!');
      expect(result.success, isFalse);
      expect(result.message, AppLocalisations.authErrorUserNotFoundMessage);
    });

    test('returns incorrect password for wrong password', () async {
      final result = await repo.login('mock@example.com', 'wrongpassword');
      expect(result.success, isFalse);
      expect(result.message, AppLocalisations.authErrorIncorrectPassword);
    });
  });

  group('register', () {
    test('returns success for new user', () async {
      final result = await repo.register('new@example.com', 'NewPass123!', 'New User');
      expect(result.success, isTrue);
      expect(result.message, isNull);
    });

    test('returns user already exists for duplicate email', () async {
      final result = await repo.register('mock@example.com', 'Password1!', 'user');
      expect(result.success, isFalse);
      expect(result.message, AppLocalisations.authErrorUserAlreadyExists);
    });

    test('actually adds the user to the repository', () async {
      await repo.register('unique@example.com', 'UniquePass!', 'Unique User');
      // Now login should succeed
      final result = await repo.login('unique@example.com', 'UniquePass!');
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
