import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/owner_repository_impl.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import '../../common/fakes/common_mocks.mocks.dart';

void main() {
  late MockOwnersRemoteDataSource mockRemoteDataSource;
  late MockUsersRemoteDataSource mockUsersRemoteDataSource;
  late OwnerRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockOwnersRemoteDataSource();
    mockUsersRemoteDataSource = MockUsersRemoteDataSource();
    when(mockUsersRemoteDataSource.users).thenReturn([]);
    when(mockUsersRemoteDataSource.saveSeedUsers(any)).thenAnswer((_) async {});
    repository = OwnerRepositoryImpl(mockRemoteDataSource, mockUsersRemoteDataSource);
  });

  test('fetchOwners calls remote data source, syncs users, and returns owners', () async {
    final owners = [
      OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []),
      OwnerEntity(id: 'o2', firstName: 'Jane', lastName: 'Smith', linkedItemIds: []),
    ];
    when(mockRemoteDataSource.fetchOwners()).thenAnswer((_) async => owners);

    final result = await repository.fetchOwners();

    expect(result, owners);
    verify(mockRemoteDataSource.fetchOwners()).called(1);
    verify(mockUsersRemoteDataSource.saveSeedUsers(any)).called(1);
  });

  test('fetchOwners does not add duplicate users', () async {
    final existingUser = UserEntity.initial(
      userId: 'o1',
      email: '',
      password: '',
      firstName: 'John',
      lastName: 'Doe',
    );
    when(mockUsersRemoteDataSource.users).thenReturn([existingUser]);

    final owners = [OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: [])];
    when(mockRemoteDataSource.fetchOwners()).thenAnswer((_) async => owners);

    await repository.fetchOwners();

    verify(mockUsersRemoteDataSource.saveSeedUsers(any)).called(1);
    verifyNever(mockUsersRemoteDataSource.users = any);
  });

  test('getOwnerById calls remote data source and returns owner', () {
    final owner = OwnerEntity(id: 'o1', firstName: 'John', lastName: 'Doe', linkedItemIds: []);
    when(mockRemoteDataSource.getOwnerById('o1')).thenReturn(owner);

    final result = repository.getOwnerById('o1');

    expect(result, owner);
    verify(mockRemoteDataSource.getOwnerById('o1')).called(1);
  });
}
