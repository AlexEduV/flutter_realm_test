import 'dart:io';

class AppConstants {
  static const int homeTabExplore = 0;
  static const int homeTabFavorites = 1;
  static const int homeTabInbox = 2;
  static const int homeTabAccount = 3;

  static const bool showSemantics = false;

  static const bool showNetworkLogs = true;

  static final bool kIsTest = Platform.environment.containsKey('FLUTTER_TEST');
}
