import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/car_color_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/car_colors_local_data_source.dart';

import 'car_color_repository_impl_test.mocks.dart';

@GenerateMocks([CarColorLocalDataSource])
void main() {
  late MockCarColorLocalDataSource mockLocalDataSource;
  late CarColorRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockCarColorLocalDataSource();
    repository = CarColorRepositoryImpl(mockLocalDataSource);
  });

  test('getColors delegates to local data source and returns result', () {
    // Arrange
    final expectedColors = {'red': const Color(0xFFFF0000), 'blue': const Color(0xFF0000FF)};
    when(mockLocalDataSource.getColors()).thenReturn(expectedColors);

    // Act
    final result = repository.getColors();

    // Assert
    expect(result, expectedColors);
    verify(mockLocalDataSource.getColors()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('getColors returns empty map if local data source returns empty', () {
    // Arrange
    when(mockLocalDataSource.getColors()).thenReturn({});

    // Act
    final result = repository.getColors();

    // Assert
    expect(result, isEmpty);
    verify(mockLocalDataSource.getColors()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
