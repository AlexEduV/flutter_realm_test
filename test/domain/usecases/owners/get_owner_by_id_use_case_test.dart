import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/repositories/owner_repository.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';

import 'get_owner_by_id_use_case_test.mocks.dart';

@GenerateMocks([OwnerRepository])
void main() {
  late MockOwnerRepository mockRepository;
  late GetOwnerByIdUseCase useCase;

  setUp(() {
    mockRepository = MockOwnerRepository();
    useCase = GetOwnerByIdUseCase(mockRepository);
  });

  test('should call getOwnerById on repository with correct id and return OwnerEntity', () {
    final ownerId = 'owner123';
    final owner = OwnerEntity(id: ownerId, firstName: 'Test', lastName: 'Owner', linkedItemIds: []);
    when(mockRepository.getOwnerById(ownerId)).thenReturn(owner);

    final result = useCase.call(ownerId);

    expect(result, equals(owner));
    verify(mockRepository.getOwnerById(ownerId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return null when repository returns null', () {
    final ownerId = 'not_found';
    when(mockRepository.getOwnerById(ownerId)).thenReturn(OwnerEntity.empty());

    final result = useCase.call(ownerId);

    expect(result, OwnerEntity.empty());
    verify(mockRepository.getOwnerById(ownerId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
