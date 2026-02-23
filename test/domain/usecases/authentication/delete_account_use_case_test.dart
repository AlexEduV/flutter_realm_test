import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/usecases/authentication/delete_account_use_case.dart';

import '../../../data/data_sources/mock_auth_service_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late DeleteAccountUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = DeleteAccountUseCase(mockAuthRepository);
  });

  test('calls deleteAccount on AuthRepository with correct email', () async {
    const testEmail = 'test@example.com';

    // Arrange: set up the mock to return a completed future
    when(mockAuthRepository.deleteAccount(testEmail)).thenAnswer((_) async {});

    // Act: call the use case
    await useCase(testEmail);

    // Assert: verify the repository method was called with the correct email
    verify(mockAuthRepository.deleteAccount(testEmail)).called(1);
  });

  test('returns a Future<void>', () async {
    const testEmail = 'test@example.com';

    when(mockAuthRepository.deleteAccount(testEmail)).thenAnswer((_) async {});

    final result = useCase(testEmail);

    expect(result, isA<Future<void>>());
    await result; // Ensure it completes without error
  });
}
