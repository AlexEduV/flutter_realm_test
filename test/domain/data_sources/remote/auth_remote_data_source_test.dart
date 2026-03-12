import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_auth_remote_data_source.dart';
import 'package:test_futter_project/domain/models/auth_result.dart';

import '../../../data/data_sources/remote/auth_remote_data_source_test.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockService;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    mockService = MockAuthRemoteDataSource(repository);
  });

  test('login returns AuthResult from service', () async {
    final result = AuthResult(success: true, message: 'Logged in');

    when(mockService.login('test@example.com', 'password')).thenAnswer((_) async => result);

    final response = await repository.login(email: 'test@example.com', password: 'password');

    expect(response, result);
    verify(mockService.login('test@example.com', 'password')).called(1);
  });
}
