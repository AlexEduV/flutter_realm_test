import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/user_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/users_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import '../../domain/repositories/app_local_storage_test.mocks.dart';
import 'user_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UsersRemoteDataSource>()])
void main() {
  late MockUsersRemoteDataSource mockRemoteDataSource;
  late MockAppLocalStorage mockAppLocalStorage;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockUsersRemoteDataSource();
    mockAppLocalStorage = MockAppLocalStorage();
    repository = UserRepositoryImpl(mockRemoteDataSource, mockAppLocalStorage);
  });

  test('getMaxUserId should delegate to remote data source', () {
    // Arrange
    const tMaxUserId = 99;
    when(mockRemoteDataSource.getMaxUserId()).thenReturn(tMaxUserId);

    // Act
    final result = repository.getMaxUserId();

    // Assert
    expect(result, tMaxUserId);
    verify(mockRemoteDataSource.getMaxUserId()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getUserByEmail should delegate to remote data source', () {
    // Arrange
    const tEmail = 'test@example.com';
    final tUser = UserEntity.initial(
      userId: '1',
      firstName: 'Test',
      lastName: 'User',
      email: 'mock@mock.com',
      password: 'test',
    );
    when(mockRemoteDataSource.getUserByEmail(tEmail)).thenReturn(tUser);

    // Act
    final result = repository.getUserByEmail(tEmail);

    // Assert
    expect(result, tUser);
    verify(mockRemoteDataSource.getUserByEmail(tEmail)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getUserById should delegate to remote data source', () {
    // Arrange
    const tId = '123';
    final tUser = UserEntity.initial(
      userId: tId,
      firstName: 'Test',
      lastName: 'User',
      email: 'mock@mock.com',
      password: 'test',
    );
    when(mockRemoteDataSource.getUserById(tId)).thenReturn(tUser);

    // Act
    final result = repository.getUserById(tId);

    // Assert
    expect(result, tUser);
    verify(mockRemoteDataSource.getUserById(tId)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('loadSeedUsers should delegate to remote data source', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock1@mock.com',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2@mock.com',
        password: 'test',
      ),
    ];
    when(mockRemoteDataSource.loadSeedUsers()).thenAnswer((_) async => tUsers);

    // Act
    final result = await repository.loadSeedUsers();

    // Assert
    expect(result, tUsers);
    verify(mockRemoteDataSource.loadSeedUsers()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('saveSeedUsers should delegate to remote data source', () async {
    // Arrange
    final tUsers = [
      UserEntity.initial(
        userId: '1',
        firstName: 'User',
        lastName: 'One',
        email: 'mock1@mock.com',
        password: 'test',
      ),
      UserEntity.initial(
        userId: '2',
        firstName: 'User',
        lastName: 'Two',
        email: 'mock2@mock.com',
        password: 'test',
      ),
    ];
    when(mockRemoteDataSource.saveSeedUsers(tUsers)).thenAnswer((_) async => {});

    // Act
    await repository.saveSeedUsers(tUsers);

    // Assert
    verify(mockRemoteDataSource.saveSeedUsers(tUsers)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
