import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';
import 'package:test_futter_project/domain/repositories/auto_complete_repository.dart';
import 'package:test_futter_project/domain/usecases/auto_complete/get_auto_complete_manufacturers_by_type_use_case.dart';

import 'get_auto_complete_manufacturers_by_type_use_case_test.mocks.dart';

@GenerateMocks([AutoCompleteRepository])
void main() {
  late MockAutoCompleteRepository mockRepository;
  late GetAutoCompleteManufacturersByTypeUseCase useCase;

  setUp(() {
    mockRepository = MockAutoCompleteRepository();
    useCase = GetAutoCompleteManufacturersByTypeUseCase(mockRepository);
  });

  test('should return a list of CarAutoCompleteEntity for the given CarType', () async {
    // Arrange
    final carType = CarType.car;
    final testEntities = [
      CarAutoCompleteEntity(manufacturerId: 1, manufacturer: 'Toyota', models: []),
      CarAutoCompleteEntity(manufacturerId: 2, manufacturer: 'Honda', models: ['Civic']),
    ];
    when(
      mockRepository.getAutoCompleteModelListByType(carType),
    ).thenAnswer((_) async => testEntities);

    // Act
    final result = await useCase(carType);

    // Assert
    expect(result, testEntities);
    verify(mockRepository.getAutoCompleteModelListByType(carType)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return an empty list if repository returns empty', () async {
    // Arrange
    final carType = CarType.truck;
    when(mockRepository.getAutoCompleteModelListByType(carType)).thenAnswer((_) async => []);

    // Act
    final result = await useCase(carType);

    // Assert
    expect(result, isEmpty);
    verify(mockRepository.getAutoCompleteModelListByType(carType)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
