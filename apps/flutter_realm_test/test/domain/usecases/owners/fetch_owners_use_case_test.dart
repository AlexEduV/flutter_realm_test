import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/usecases/owners/fetch_owners_use_case.dart';

import 'get_owner_by_id_use_case_test.mocks.dart';

void main() {
  late MockOwnerRepository mockRepository;
  late FetchOwnersUseCase useCase;

  setUp(() {
    mockRepository = MockOwnerRepository();
    useCase = FetchOwnersUseCase(mockRepository);
  });

  group('FetchOwnersUseCase', () {
    test('returns list of owners from repository', () async {
      final owners = [
        OwnerEntity(id: '1', firstName: 'Alice', lastName: 'Smith', linkedItemIds: []),
        OwnerEntity(id: '2', firstName: 'Bob', lastName: 'Jones', linkedItemIds: ['car1']),
      ];
      when(mockRepository.fetchOwners()).thenAnswer((_) async => owners);

      final result = await useCase();

      expect(result, equals(owners));
      verify(mockRepository.fetchOwners()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('returns empty list when repository returns no owners', () async {
      when(mockRepository.fetchOwners()).thenAnswer((_) async => []);

      final result = await useCase();

      expect(result, isEmpty);
      verify(mockRepository.fetchOwners()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('propagates exception thrown by repository', () async {
      when(mockRepository.fetchOwners()).thenThrow(Exception('network error'));

      expect(() => useCase(), throwsException);
      verify(mockRepository.fetchOwners()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
