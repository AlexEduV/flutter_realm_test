import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    // Reset before each test
    AppLocalisations.localisations = {
      'app.name': 'Flutter Realm Demo',
      'pages.explore.title': 'Explore',
      'pages.results.title': 'Results',
      'actions.addCar.tooltip': 'Add a car',
      'actions.delete.title': 'Delete',
      'widgets.distance.text': 'km away',
      'pages.recommended.sectionTitle': 'Recommended',
      'pages.search.title': 'Search',
      'pages.search.tabs.cars': 'Cars',
      'pages.search.tabs.bikes': 'Bikes',
      'pages.search.tabs.trucks': 'Trucks',
      'pages.search.emptyPlaceholder': 'No results were found for this search.',
      'filters.model.title': 'Model',
      'filters.parameters.title': 'Filters',
      'filters.model.placeholder': 'All',
      'filters.parameters.year': 'Year',
      'filters.parameters.bodyTypes.title': 'Body Type',
      'filters.parameters.priceRange': 'Price Range',
      'filters.parameters.fuelTypes.title': 'Fuel Type',
      'filters.parameters.transmissionTypes.title': 'Transmission Type',
      'pages.comingSoon.title': 'Coming Soon',
      'pages.comingSoon.subtitle': 'This feature is not available yet.',
      'filters.parameters.bodyTypes.sedan': 'Sedan',
      'filters.parameters.bodyTypes.hatchback': 'Hatchback',
      'filters.parameters.bodyTypes.universal': 'Universal',
      'filters.parameters.bodyTypes.minivan': 'Minivan',
      'filters.parameters.bodyTypes.coupe': 'Coupe',
      'filters.parameters.bodyTypes.crossover': 'Crossover',
      'filters.parameters.bodyTypes.semi': 'Semi',
      'filters.parameters.bodyTypes.bike': 'Bike',
      'filters.parameters.fuelTypes.diesel': 'Diesel',
      'filters.parameters.fuelTypes.gasoline': 'Gasoline',
      'filters.parameters.fuelTypes.ev': 'EV',
      'filters.parameters.fuelTypes.hybrid': 'Hybrid',
      'filters.parameters.transmissionTypes.manual': 'Manual',
      'filters.parameters.transmissionTypes.automatic': 'Automatic',
      'filters.parameters.transmissionTypes.hybrid': 'Hybrid',
    };
  });

  test('returns correct value for existing keys', () {
    expect(AppLocalisations.appName, 'Flutter Realm Demo');
    expect(AppLocalisations.explorePageTitle, 'Explore');
    expect(AppLocalisations.results, 'Results');
    expect(AppLocalisations.addCarButtonTooltip, 'Add a car');
    expect(AppLocalisations.deleteButtonTitle, 'Delete');
    expect(AppLocalisations.distanceWidgetText, 'km away');
    expect(AppLocalisations.recommendedSectionTitle, 'Recommended');
    expect(AppLocalisations.searchPageTitle, 'Search');
    expect(AppLocalisations.searchTabCars, 'Cars');
    expect(AppLocalisations.searchTabBikes, 'Bikes');
    expect(AppLocalisations.searchTabTrucks, 'Trucks');
    expect(AppLocalisations.emptySearchPlaceholderText, 'No results were found for this search.');
    expect(AppLocalisations.searchFilterModelTitle, 'Model');
    expect(AppLocalisations.searchFilterParametersTitle, 'Filters');
    expect(AppLocalisations.searchFilterModelPlaceholder, 'All');
    expect(AppLocalisations.parameterYearName, 'Year');
    expect(AppLocalisations.parameterBodyTypeName, 'Body Type');
    expect(AppLocalisations.parameterPriceRangeName, 'Price Range');
    expect(AppLocalisations.parameterFuelTypeName, 'Fuel Type');
    expect(AppLocalisations.parameterTransmissionTypeName, 'Transmission Type');
    expect(AppLocalisations.comingSoonPlaceholderPageTitle, 'Coming Soon');
    expect(
      AppLocalisations.comingSoonPlaceholderPageSubTitle,
      'This feature is not available yet.',
    );
    expect(AppLocalisations.bodyTypeSedan, 'Sedan');
    expect(AppLocalisations.bodyTypeHatchback, 'Hatchback');
    expect(AppLocalisations.bodyTypeUniversal, 'Universal');
    expect(AppLocalisations.bodyTypeMinivan, 'Minivan');
    expect(AppLocalisations.bodyTypeCoupe, 'Coupe');
    expect(AppLocalisations.bodyTypeCrossover, 'Crossover');
    expect(AppLocalisations.bodyTypeSemi, 'Semi');
    expect(AppLocalisations.bodyTypeBike, 'Bike');
    expect(AppLocalisations.fuelTypeDiesel, 'Diesel');
    expect(AppLocalisations.fuelTypeGasoline, 'Gasoline');
    expect(AppLocalisations.fuelTypeEv, 'EV');
    expect(AppLocalisations.fuelTypeHybrid, 'Hybrid');
    expect(AppLocalisations.transmissionTypeManual, 'Manual');
    expect(AppLocalisations.transmissionTypeAutomatic, 'Automatic');
    expect(AppLocalisations.transmissionTypeHybrid, 'Hybrid');
  });
}
