class AppConstants {
  static const int homeTabExplore = 0;
  static const int homeTabFavorites = 1;
  static const int homeTabInbox = 2;
  static const int homeTabAccount = 3;

  static const bool showSemantics = false;

  static final bool kIsTest = () {
    var inTest = false;
    assert(() {
      inTest = true;
      return true;
    }());
    return inTest;
  }();
}
