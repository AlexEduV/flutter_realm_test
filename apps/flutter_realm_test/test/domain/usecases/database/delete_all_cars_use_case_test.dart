import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/database/delete_all_cars_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('DeleteAllCarsUseCase', () {
    late MockCarRepository mockCarRepository;
    late DeleteAllCarsUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = DeleteAllCarsUseCase(mockCarRepository);
    });

    test('calls deleteAll on repository', () {
      useCase.call();

      verify(mockCarRepository.deleteAll()).called(1);
    });
  });
}
