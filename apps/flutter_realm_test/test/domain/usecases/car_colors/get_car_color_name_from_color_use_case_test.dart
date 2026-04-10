import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';

import 'get_car_colors_use_case_test.mocks.dart';

void main() {
  late MockCarColorRepository mockCarColorRepository;
  late GetCarColorNameFromColorUseCase useCase;

  setUp(() {
    mockCarColorRepository = MockCarColorRepository();
    useCase = GetCarColorNameFromColorUseCase(mockCarColorRepository);
  });

  test('should return color name when color exists', () {
    // Arrange
    const color = Color(0xFF0000FF);
    const colorName = 'blue';
    when(mockCarColorRepository.getColorNameFromColor(color)).thenReturn(colorName);

    // Act
    final result = useCase(color);

    // Assert
    expect(result, colorName);
    verify(mockCarColorRepository.getColorNameFromColor(color)).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });

  test('should return empty string or null when color does not exist', () {
    // Arrange
    const color = Color(0xFF123456);
    when(mockCarColorRepository.getColorNameFromColor(color)).thenReturn('');

    // Act
    final result = useCase(color);

    // Assert
    expect(result, '');
    verify(mockCarColorRepository.getColorNameFromColor(color)).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });

  test('should handle null color input', () {
    // Arrange
    when(mockCarColorRepository.getColorNameFromColor(null)).thenReturn('');

    // Act
    final result = useCase(null);

    // Assert
    expect(result, '');
    verify(mockCarColorRepository.getColorNameFromColor(null)).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });
}
