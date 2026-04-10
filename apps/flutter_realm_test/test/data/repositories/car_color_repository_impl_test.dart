import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/repositories/car_color_repository_impl.dart';
import 'package:test_futter_project/domain/data_sources/local/car_colors_local_data_source.dart';

import 'car_color_repository_impl_test.mocks.dart';

@GenerateMocks([CarColorLocalDataSource])
void main() {
  late MockCarColorLocalDataSource mockDataSource;
  late CarColorRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCarColorLocalDataSource();
    repository = CarColorRepositoryImpl(mockDataSource);
  });

  group('getColors', () {
    test('delegates to CarColorLocalDataSource.getColors', () {
      final colors = {'red': const Color(0xFFFF0000)};
      when(mockDataSource.getColors()).thenReturn(colors);

      expect(repository.getColors(), colors);
      verify(mockDataSource.getColors()).called(1);
    });
  });

  group('getColorByName', () {
    final colors = {'red': const Color(0xFFFF0000), 'blue': const Color(0xFF0000FF)};

    setUp(() {
      when(mockDataSource.getColors()).thenReturn(colors);
    });

    test('returns correct color for exact match', () {
      expect(repository.getColorByName('red'), const Color(0xFFFF0000));
    });

    test('returns correct color for case-insensitive match', () {
      expect(repository.getColorByName('RED'), const Color(0xFFFF0000));
      expect(repository.getColorByName('Blue'), const Color(0xFF0000FF));
    });

    test('returns first color as fallback if no match', () {
      expect(repository.getColorByName('green'), const Color(0xFFFF0000));
    });

    test('returns null if colors map is empty', () {
      when(mockDataSource.getColors()).thenReturn({});
      expect(repository.getColorByName('red'), isNull);
    });
  });

  group('getColorNameFromColor', () {
    final colors = {'redColor': const Color(0xFFFF0000), 'blueColor': const Color(0xFF0000FF)};

    setUp(() {
      when(mockDataSource.getColors()).thenReturn(colors);
    });

    test('returns correct name for exact color match', () {
      // Assuming camelCaseToTitle() turns 'redColor' into 'Red Color'
      expect(repository.getColorNameFromColor(const Color(0xFFFF0000)), 'Red Color');
      expect(repository.getColorNameFromColor(const Color(0xFF0000FF)), 'Blue Color');
    });

    test('returns empty string if no match', () {
      expect(repository.getColorNameFromColor(const Color(0xFF00FF00)), '');
    });

    test('returns empty string if color is null', () {
      expect(repository.getColorNameFromColor(null), '');
    });

    test('returns empty string if colors map is empty', () {
      when(mockDataSource.getColors()).thenReturn({});
      expect(repository.getColorNameFromColor(const Color(0xFFFF0000)), '');
    });
  });
}
