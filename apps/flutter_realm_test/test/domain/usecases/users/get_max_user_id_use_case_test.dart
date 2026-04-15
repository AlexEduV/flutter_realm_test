import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/usecases/users/get_max_user_id_use_case.dart';

import 'get_max_user_id_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late GetMaxUserIdUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetMaxUserIdUseCase(mockUserRepository);
  });

  test('should return max user id from repository', () {
    // Arrange
    const tMaxUserId = 42;
    when(mockUserRepository.getMaxUserId()).thenReturn(tMaxUserId);

    // Act
    final result = useCase();

    // Assert
    expect(result, tMaxUserId);
    verify(mockUserRepository.getMaxUserId()).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
