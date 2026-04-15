import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_by_name_use_case.dart';

import 'get_car_colors_use_case_test.mocks.dart';

void main() {
  late MockCarColorRepository mockCarColorRepository;
  late GetCarColorByNameUseCase useCase;

  setUp(() {
    mockCarColorRepository = MockCarColorRepository();
    useCase = GetCarColorByNameUseCase(mockCarColorRepository);
  });

  test('should return Color when color name exists', () {
    // Arrange
    const colorName = 'red';
    const color = Color(0xFFFF0000);
    when(mockCarColorRepository.getColorByName(colorName)).thenReturn(color);

    // Act
    final result = useCase(colorName);

    // Assert
    expect(result, color);
    verify(mockCarColorRepository.getColorByName(colorName)).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });

  test('should return null when color name does not exist', () {
    // Arrange
    const colorName = 'unknown';
    when(mockCarColorRepository.getColorByName(colorName)).thenReturn(null);

    // Act
    final result = useCase(colorName);

    // Assert
    expect(result, isNull);
    verify(mockCarColorRepository.getColorByName(colorName)).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });
}
