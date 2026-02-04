import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('home route should be "/"', () {
      expect(AppRoutes.home, '/');
    });

    test('search route should be "search"', () {
      expect(AppRoutes.search, 'search');
    });

    test('all routes should be of type String', () {
      expect(AppRoutes.home, isA<String>());
      expect(AppRoutes.search, isA<String>());
    });
  });
}
