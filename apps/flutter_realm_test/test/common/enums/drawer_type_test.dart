import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/enums/drawer_type.dart';

void main() {
  group('SearchDrawerType enum', () {
    test('should contain all expected values', () {
      expect(SearchDrawerType.values.length, 3);
      expect(SearchDrawerType.values, contains(SearchDrawerType.empty));
      expect(SearchDrawerType.values, contains(SearchDrawerType.model));
      expect(SearchDrawerType.values, contains(SearchDrawerType.parameters));
    });

    test('should have correct index for each value', () {
      expect(SearchDrawerType.empty.index, 0);
      expect(SearchDrawerType.model.index, 1);
      expect(SearchDrawerType.parameters.index, 2);
    });

    test('should have correct string representation', () {
      expect(SearchDrawerType.empty.toString(), 'SearchDrawerType.empty');
      expect(SearchDrawerType.model.toString(), 'SearchDrawerType.model');
      expect(SearchDrawerType.parameters.toString(), 'SearchDrawerType.parameters');
    });
  });
}
