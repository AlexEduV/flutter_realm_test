import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/usecases/users/load_users_use_case.dart';

import 'get_max_user_id_use_case_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late LoadUsersUseCase useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = LoadUsersUseCase(mockUserRepository);
  });

  test('should return list of UserEntity from repository', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2',
        password: 'test2',
      ),
    ];
    when(mockUserRepository.loadMockUsers()).thenAnswer((_) async => tUsers);

    // Act
    final result = await useCase();

    // Assert
    expect(result, tUsers);
    verify(mockUserRepository.loadMockUsers()).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return empty list when repository returns empty', () async {
    // Arrange
    when(mockUserRepository.loadMockUsers()).thenAnswer((_) async => []);

    // Act
    final result = await useCase();

    // Assert
    expect(result, isEmpty);
    verify(mockUserRepository.loadMockUsers()).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
