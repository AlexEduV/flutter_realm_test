import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('homeTabExplore should be 0', () {
      expect(AppConstants.homeTabExplore, 0);
    });

    test('homeTabFavorites should be 1', () {
      expect(AppConstants.homeTabFavorites, 1);
    });

    test('homeTabInbox should be 2', () {
      expect(AppConstants.homeTabInbox, 2);
    });

    test('homeTabSettings should be 3', () {
      expect(AppConstants.homeTabAccount, 3);
    });

    test('all tab constants should be of type int', () {
      expect(AppConstants.homeTabExplore, isA<int>());
      expect(AppConstants.homeTabFavorites, isA<int>());
      expect(AppConstants.homeTabInbox, isA<int>());
      expect(AppConstants.homeTabAccount, isA<int>());
    });
  });
}
