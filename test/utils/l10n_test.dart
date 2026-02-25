import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    // Reset before each test
    AppLocalisations.localisations = {
      'app.name': 'Flutter Realm Demo',
      'pages.explore.title': 'Explore',
      'pages.search.resultsSection.title': 'Results',
      'pages.favorites.title': 'Favorites',
      'actions.addCar.tooltip': 'Add a car',
      'actions.delete.title': 'Delete',
      'widgets.distance.text': 'km away',
      'pages.explore.recommendedSection.title': 'Recommended',
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
      'pages.vehicleDetails.sectionTitle': 'Vehicle Details',
      'pages.vehicleDetails.specifications.body': 'Body',
      'pages.vehicleDetails.specifications.engine': 'Engine',
      'pages.vehicleDetails.specifications.transmission': 'Transmission',
      'pages.vehicleDetails.specifications.mileage': 'Mileage',
      'pages.vehicleDetails.specifications.color': 'Color',
      'pages.vehicleDetails.specifications.year': 'Year',
      'pages.vehicleDetails.ownerSection.personTypeOwner': 'Owner',
      'pages.vehicleDetails.ownerSection.contactButtonTitle': 'Contact',
      'forms.ui.welcomeLoginTitle': 'Welcome Back',
      'forms.ui.welcomeRegisterTitle': 'Join us',
      'forms.ui.forgotPasswordButtonText': 'Forgot password?',
      'forms.ui.loginButtonTitle': 'Log in',
      'forms.ui.signUpButtonTitle': 'Sign up',
      'forms.ui.orDividerTitle': 'Or',
      'forms.validationMessage': 'This field is required.',
      'forms.fieldParams.email.label': 'Email',
      'forms.fieldParams.email.hintText': 'Enter your email:',
      'forms.fieldParams.email.regexErrorMessage': 'The email is not valid.',
      'forms.fieldParams.password.label': 'Password',
      'forms.fieldParams.password.hintText': 'Enter your password:',
      'forms.fieldParams.password.regexErrorMessage': 'The password is not valid.',
      'forms.fieldParams.fullName.label': 'Full name',
      'forms.fieldParams.fullName.hintText': 'Enter your full name:',
      'forms.fieldParams.fullName.regexErrorMessage': 'The full name is not valid.',
      'forms.warnings.userNotFound': 'The user not found.',
      'forms.warnings.incorrectPassword': 'Incorrect password.',
      'forms.warnings.userAlreadyExists': 'User already exists.',
    };
  });

  group('AppLocalisations.get', () {
    test('returns value for existing key', () {
      expect(AppLocalisations.get('app.name'), 'Flutter Realm Demo');
      expect(AppLocalisations.get('pages.explore.title'), 'Explore');
    });

    test('returns empty string for missing key', () {
      expect(AppLocalisations.get('nonexistent.key'), '');
    });
  });

  group('AppLocalisations static fields', () {
    test('returns correct values for static fields', () {
      expect(AppLocalisations.appName, 'Flutter Realm Demo');
      expect(AppLocalisations.explorePageTitle, 'Explore');
      expect(AppLocalisations.results, 'Results');
      expect(AppLocalisations.favoritesPageTitle, 'Favorites');
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
      expect(AppLocalisations.vehicleSpecificationsSectionTitle, 'Vehicle Details');
      expect(AppLocalisations.vehicleSpecificationBody, 'Body');
      expect(AppLocalisations.vehicleSpecificationEngine, 'Engine');
      expect(AppLocalisations.vehicleSpecificationTransmission, 'Transmission');
      expect(AppLocalisations.vehicleSpecificationMileage, 'Mileage');
      expect(AppLocalisations.vehicleSpecificationColor, 'Color');
      expect(AppLocalisations.vehicleSpecificationYear, 'Year');
      expect(AppLocalisations.ownerSectionPersonTypeOwner, 'Owner');
      expect(AppLocalisations.ownerSectionContactButtonTitle, 'Contact');
      expect(AppLocalisations.loginPageLoginWelcomeText, 'Welcome Back');
      expect(AppLocalisations.loginPageRegistrationWelcomeText, 'Join us');
      expect(AppLocalisations.forgotPasswordButtonTitle, 'Forgot password?');
      expect(AppLocalisations.loginButtonTitle, 'Log in');
      expect(AppLocalisations.signUpButtonTitle, 'Sign up');
      expect(AppLocalisations.orDividerTitle, 'Or');
      expect(AppLocalisations.fieldParamsValidationMessage, 'This field is required.');
      expect(AppLocalisations.fieldParamsEmailLabel, 'Email');
      expect(AppLocalisations.fieldParamsEmailHintText, 'Enter your email:');
      expect(AppLocalisations.fieldParamsEmailRegexErrorMessage, 'The email is not valid.');
      expect(AppLocalisations.fieldParamsPasswordLabel, 'Password');
      expect(AppLocalisations.fieldParamsPasswordHintText, 'Enter your password:');
      expect(AppLocalisations.fieldParamsPasswordRegexErrorMessage, 'The password is not valid.');
      expect(AppLocalisations.fieldParamsFullNameLabel, 'Full name');
      expect(AppLocalisations.fieldParamsFullNameHintText, 'Enter your full name:');
      expect(AppLocalisations.fieldParamsFullNameRegexErrorMessage, 'The full name is not valid.');
      expect(AppLocalisations.authErrorUserNotFoundMessage, 'The user not found.');
      expect(AppLocalisations.authErrorIncorrectPassword, 'Incorrect password.');
      expect(AppLocalisations.authErrorUserAlreadyExists, 'User already exists.');
    });
  });
}
