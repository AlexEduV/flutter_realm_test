import 'dart:io';

class AppConstants {
  static const int homeTabExplore = 0;
  static const int homeTabFavorites = 1;
  static const int homeTabInbox = 2;
  static const int homeTabAccount = 3;

  static const int itemSetupTabType = 0;
  static const int itemSetupTabInfo = 1;
  static const int itemSetupTabPickers = 2;

  static const bool showSemantics = false;

  static final bool kIsTest = Platform.environment.containsKey('FLUTTER_TEST');
}
