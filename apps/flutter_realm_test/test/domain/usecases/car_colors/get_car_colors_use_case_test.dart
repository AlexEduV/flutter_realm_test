import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';

import 'get_car_colors_use_case_test.mocks.dart';

@GenerateMocks([CarColorRepository])
void main() {
  late MockCarColorRepository mockCarColorRepository;
  late GetCarColorsUseCase useCase;

  setUp(() {
    mockCarColorRepository = MockCarColorRepository();
    useCase = GetCarColorsUseCase(mockCarColorRepository);
  });

  test('should return a map of car colors from the repository', () {
    // Arrange
    final testColors = {'red': const Color(0xFFFF0000), 'blue': const Color(0xFF0000FF)};
    when(mockCarColorRepository.getColors()).thenReturn(testColors);

    // Act
    final result = useCase();

    // Assert
    expect(result, testColors);
    verify(mockCarColorRepository.getColors()).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });

  test('should return an empty map if repository returns empty', () {
    // Arrange
    when(mockCarColorRepository.getColors()).thenReturn({});

    // Act
    final result = useCase();

    // Assert
    expect(result, isEmpty);
    verify(mockCarColorRepository.getColors()).called(1);
    verifyNoMoreInteractions(mockCarColorRepository);
  });
}
