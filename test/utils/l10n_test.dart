import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    // Populate the localisations map before each test
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
      'filters.parameters.title': 'Parameters',
      'filters.model.placeholder': 'All',
      'filters.parameters.year': 'Year',
      'filters.parameters.bodyType': 'Body Type',
      'filters.parameters.priceRange': 'Price Range',
      'filters.parameters.fuelType': 'Fuel Type',
      'filters.parameters.transmissionType': 'Transmission Type',
      'pages.comingSoon.title': 'Coming Soon',
      'pages.comingSoon.subtitle': 'This feature is not available yet.',
    };
  });

  group('AppLocalisations', () {
    test('get returns correct value for existing key', () {
      expect(AppLocalisations.get('app.name'), 'Flutter Realm Demo');
      expect(AppLocalisations.get('pages.explore.title'), 'Explore');
      expect(AppLocalisations.get('filters.parameters.year'), 'Year');
    });

    test('get returns empty string for missing key', () {
      expect(AppLocalisations.get('non.existent.key'), '');
    });

    test('static fields return correct values', () {
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
      expect(AppLocalisations.searchFilterParametersTitle, 'Parameters');
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
    });
  });
}
