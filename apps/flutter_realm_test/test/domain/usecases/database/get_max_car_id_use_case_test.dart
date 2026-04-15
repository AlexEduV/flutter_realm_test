import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/database/get_current_max_car_id_use_case.dart';

import '../../repositories/car_repository_test.mocks.dart';

void main() {
  group('GetMaxCarIdUseCase', () {
    late MockCarRepository mockCarRepository;
    late GetCurrentMaxCarIdUseCase useCase;

    setUp(() {
      mockCarRepository = MockCarRepository();
      useCase = GetCurrentMaxCarIdUseCase(mockCarRepository);
    });

    test('calls getMaxCarId on repository and returns the result', () {
      when(mockCarRepository.getMaxCarId()).thenReturn(1);

      final result = useCase.call();

      expect(result, 1);
      verify(mockCarRepository.getMaxCarId()).called(1);
    });
  });
}
