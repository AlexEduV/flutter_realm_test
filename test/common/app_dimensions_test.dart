import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_dimensions.dart';

void main() {
  group('AppDimensions', () {
    test('contentPadding', () => expect(AppDimensions.contentPadding, 12.0));

    test('majorS', () => expect(AppDimensions.majorS, 28.0));
    test('majorM', () => expect(AppDimensions.majorM, 32.0));

    test('normalXL', () => expect(AppDimensions.normalXL, 24.0));
    test('normalL', () => expect(AppDimensions.normalL, 18.0));
    test('normalM', () => expect(AppDimensions.normalM, 16.0));
    test('normalS', () => expect(AppDimensions.normalS, 12.0));
    test('normalXS', () => expect(AppDimensions.normalXS, 10.0));

    test('minorL', () => expect(AppDimensions.minorL, 8.0));
    test('minorM', () => expect(AppDimensions.minorM, 6.0));
    test('minorS', () => expect(AppDimensions.minorS, 4.0));
    test('minorXS', () => expect(AppDimensions.minorXS, 2.0));

    test('appBarIconSize', () => expect(AppDimensions.appBarIconSize, AppDimensions.majorM / 1.2));

    test(
      'bottomAppBarIconEnlargedSize',
      () => expect(AppDimensions.bottomAppBarIconEnlargedSize, 26.0),
    );
    test('bottomAppBarIconSize', () => expect(AppDimensions.bottomAppBarIconSize, 24.0));

    test('placeholderPageIconSize', () => expect(AppDimensions.placeholderPageIconSize, 64.0));

    test('favoriteButtonSize', () => expect(AppDimensions.favoriteButtonSize, 36.0));
    test('favoriteItemPictureSize', () => expect(AppDimensions.favoriteItemPictureSize, 100.0));

    test('detailsPageItemIconSize', () => expect(AppDimensions.detailsPageItemIconSize, 24.0));

    test(
      'splashButtonProgressBarSize',
      () => expect(AppDimensions.splashButtonProgressBarSize, 23.0),
    );

    test('lastSeenSectionImageSize', () => expect(AppDimensions.lastSeenSectionImageSize, 50.0));

    test('inboxItemHeight', () => expect(AppDimensions.inboxItemHeight, 72.0));

    test('smallProgressBarSize', () => expect(AppDimensions.smallProgressBarSize, 24.0));

    test('exploreAppBarBaseSize', () => expect(AppDimensions.exploreAppBarBaseSize, 115.0));
    test(
      'exploreArticleItemBaseSize',
      () => expect(AppDimensions.exploreArticleItemBaseSize, 120.0),
    );

    test('avatarImageAddIconSize', () => expect(AppDimensions.avatarImageAddIconSize, 17.0));
    test('avatarImageSize', () => expect(AppDimensions.avatarImageSize, 50.0));

    test('regionFlagIconSize', () => expect(AppDimensions.regionFlagIconSize, 32.0));

    test('hotLabelIconSize', () => expect(AppDimensions.hotLabelIconSize, 20.0));
  });
}
