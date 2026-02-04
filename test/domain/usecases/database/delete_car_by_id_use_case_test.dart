import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/usecases/database/delete_car_by_id_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('DeleteCarByIdUseCase', () {
    late MockCarRepository mockCarRepository;
    late DeleteCarByIdUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = DeleteCarByIdUseCase(mockCarRepository);
    });

    test('calls deleteCarById on repository with correct ObjectId', () {
      final objectId = ObjectId();

      useCase.call(objectId);

      verify(mockCarRepository.deleteCarById(objectId)).called(1);
    });
  });
}
