import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_auth_service.dart';
import 'package:test_futter_project/domain/data_sources/auth_service.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';
import 'package:test_futter_project/domain/repositories/auth_repository.dart';

import 'mock_auth_service_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockRepo;
  late AuthService authService;

  setUp(() {
    mockRepo = MockAuthRepository();
    authService = MockAuthService(mockRepo);
  });

  group('MockAuthService', () {
    test('login delegates to repository', () async {
      final result = AuthResult(success: true, message: 'Logged in');
      when(
        mockRepo.login(email: 'test@mail.com', password: 'pass'),
      ).thenAnswer((_) async => result);

      final response = await authService.login('test@mail.com', 'pass');

      expect(response, result);
      verify(mockRepo.login(email: 'test@mail.com', password: 'pass')).called(1);
    });

    test('register delegates to repository', () async {
      final result = AuthResult(success: true, message: 'Registered');
      when(
        mockRepo.register(email: 'a@mail.com', password: 'pw', firstName: 'Jane', lastName: 'Doe'),
      ).thenAnswer((_) async => result);

      final response = await authService.register('a@mail.com', 'pw', 'Jane', 'Doe');

      expect(response, result);
      verify(
        mockRepo.register(email: 'a@mail.com', password: 'pw', firstName: 'Jane', lastName: 'Doe'),
      ).called(1);
    });

    test('logOut delegates to repository', () {
      when(mockRepo.logOut()).thenAnswer((_) async {});

      authService.logOut();

      verify(mockRepo.logOut()).called(1);
    });

    //todo: the functionality is not implemented yet
    // test('changePassword is not implemented', () {
    //   expect(
    //     () => authService.changePassword('old', 'new'),
    //     throwsA(isA<UnimplementedError>()), // or whatever error is thrown
    //   );
    // });
  });
}
