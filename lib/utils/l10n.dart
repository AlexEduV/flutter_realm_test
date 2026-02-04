class AppLocalisations {
  static Map<String, String> localisations = {};

  static String get(String key) => localisations[key] ?? '';

  //todo: maybe move to slang for strong typing
  static final String appName = get('app.name');

  static final String explorePageTitle = get('pages.explore.title');

  static final String results = get('pages.results.title');

  static final String addCarButtonTooltip = get('actions.addCar.tooltip');

  static final String deleteButtonTitle = get('actions.delete.title');

  static final String distanceWidgetText = get('widgets.distance.text');

  static final String recommendedSectionTitle = get('pages.recommended.sectionTitle');

  static final String searchPageTitle = get('pages.search.title');

  static final String searchTabCars = get('pages.search.tabs.cars');

  static final String searchTabBikes = get('pages.search.tabs.bikes');

  static final String searchTabTrucks = get('pages.search.tabs.trucks');

  static final String emptySearchPlaceholderText = get('pages.search.emptyPlaceholder');

  static final String searchFilterModelTitle = get('filters.model.title');

  static final String searchFilterParametersTitle = get('filters.parameters.title');

  static final String searchFilterModelPlaceholder = get('filters.model.placeholder');

  static final String parameterYearName = get('filters.parameters.year');

  static final String parameterBodyTypeName = get('filters.parameters.bodyType');

  static final String parameterPriceRangeName = get('filters.parameters.priceRange');

  static final String parameterFuelTypeName = get('filters.parameters.fuelType');

  static final String parameterTransmissionTypeName = get('filters.parameters.transmissionType');

  static final String comingSoonPlaceholderPageTitle = get('pages.comingSoon.title');

  static final String comingSoonPlaceholderPageSubTitle = get('pages.comingSoon.subtitle');
}
