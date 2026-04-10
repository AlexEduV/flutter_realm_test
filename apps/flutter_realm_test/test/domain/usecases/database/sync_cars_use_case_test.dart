import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('SyncCarsUseCase', () {
    late MockCarRepository mockCarRepository;
    late SyncCarsUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = SyncCarsUseCase(mockCarRepository);
    });

    test('calls syncCars on repository', () async {
      when(mockCarRepository.syncCars()).thenAnswer((_) async {});

      await useCase.call();

      verify(mockCarRepository.syncCars()).called(1);
    });
  });
}
