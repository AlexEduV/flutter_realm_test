import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/constants/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('home', () => expect(AppRoutes.home, '/'));
    test('search', () => expect(AppRoutes.search, 'search'));
    test('details', () => expect(AppRoutes.details, 'details'));
    test('inbox', () => expect(AppRoutes.inbox, 'inbox'));
    test('forgotPassword', () => expect(AppRoutes.forgotPassword, 'forgotPassword'));
    test('articleDetails', () => expect(AppRoutes.articleDetails, 'articleDetails'));
    test('personalDetails', () => expect(AppRoutes.personalDetails, 'personalDetails'));
    test('locationSettings', () => expect(AppRoutes.locationSettings, 'locationSettings'));
    test('myItems', () => expect(AppRoutes.myItems, 'myItems'));
    test('recentlyViewed', () => expect(AppRoutes.recentlyViewed, 'recentlyViewed'));
    test('clearUserData', () => expect(AppRoutes.clearUserData, 'clearUserData'));
  });
}
