import 'package:test_futter_project/utils/localisation_util.dart';

class AppLocalisations {
  static const String appName = 'Flutter Realm Demo';

  static Future<String> explorePageTitle = LocalisationUtil.getLocalisation('pages.explore.title');

  static const String results = 'Results';

  static const String addCarButtonTooltip = 'Add a car';

  static const String deleteButtonTitle = 'Delete';

  static const String distanceWidgetText = 'km away';

  static const String recommendedSectionTitle = 'Recommended';

  static const String searchPageTitle = 'Search';

  static const String searchTabCars = 'Cars';

  static const String searchTabBikes = 'Bikes';

  static const String searchTabTrucks = 'Trucks';

  static const String emptySearchPlaceholderText = 'No results were found for this search.';

  static const String searchFilterModelTitle = 'Model';

  static const String searchFilterParametersTitle = 'Parameters';

  static const String searchFilterModelPlaceholder = 'All';

  static const String parameterYearName = 'Year';

  static const String parameterBodyTypeName = 'Body Type';

  static const String parameterPriceRangeName = 'Price Range';

  static const String parameterFuelTypeName = 'Fuel Type';

  static const String parameterTransmissionTypeName = 'Transmission Type';

  static const String comingSoonPlaceholderPageTitle = 'Coming Soon';

  static const String comingSoonPlaceholderPageSubTitle = 'This feature is not available yet.';
}
