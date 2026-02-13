class AppLocalisations {
  static Map<String, String> localisations = {};

  static String get(String key) => localisations[key] ?? '';

  //todo: maybe move to slang for strong typing
  static final String appName = get('app.name');

  static final String explorePageTitle = get('pages.explore.title');

  static final String results = get('pages.results.title');

  static final String favoritesPageTitle = get('pages.favorites.title');

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

  static final String parameterBodyTypeName = get('filters.parameters.bodyTypes.title');

  static final String parameterPriceRangeName = get('filters.parameters.priceRange');

  static final String parameterFuelTypeName = get('filters.parameters.fuelTypes.title');

  static final String parameterTransmissionTypeName = get(
    'filters.parameters.transmissionTypes.title',
  );

  static final String comingSoonPlaceholderPageTitle = get('pages.comingSoon.title');

  static final String comingSoonPlaceholderPageSubTitle = get('pages.comingSoon.subtitle');

  static final String bodyTypeSedan = get('filters.parameters.bodyTypes.sedan');

  static final String bodyTypeHatchback = get('filters.parameters.bodyTypes.hatchback');

  static final String bodyTypeUniversal = get('filters.parameters.bodyTypes.universal');

  static final String bodyTypeMinivan = get('filters.parameters.bodyTypes.minivan');

  static final String bodyTypeCoupe = get('filters.parameters.bodyTypes.coupe');

  static final String bodyTypeCrossover = get('filters.parameters.bodyTypes.crossover');

  static final String bodyTypeSemi = get('filters.parameters.bodyTypes.semi');

  static final String bodyTypeBike = get('filters.parameters.bodyTypes.bike');

  static final String fuelTypeDiesel = get('filters.parameters.fuelTypes.diesel');

  static final String fuelTypeGasoline = get('filters.parameters.fuelTypes.gasoline');

  static final String fuelTypeEv = get('filters.parameters.fuelTypes.ev');

  static final String fuelTypeHybrid = get('filters.parameters.fuelTypes.hybrid');

  static final String transmissionTypeManual = get('filters.parameters.transmissionTypes.manual');

  static final String transmissionTypeAutomatic = get(
    'filters.parameters.transmissionTypes.automatic',
  );

  static final String transmissionTypeHybrid = get('filters.parameters.transmissionTypes.hybrid');

  static final String vehicleSpecificationsSectionTitle = get('pages.vehicleDetails.sectionTitle');
  static final String vehicleSpecificationBody = get('pages.vehicleDetails.specifications.body');
  static final String vehicleSpecificationEngine = get(
    'pages.vehicleDetails.specifications.engine',
  );
  static final String vehicleSpecificationTransmission = get(
    'pages.vehicleDetails.specifications.transmission',
  );
  static final String vehicleSpecificationMileage = get(
    'pages.vehicleDetails.specifications.mileage',
  );
  static final String vehicleSpecificationColor = get('pages.vehicleDetails.specifications.color');
  static final String vehicleSpecificationYear = get('pages.vehicleDetails.specifications.year');

  static final String ownerSectionPersonTypeOwner = get(
    'pages.vehicleDetails.ownerSection.personTypeOwner',
  );
  static final String ownerSectionContactButtonTitle = get(
    'pages.vehicleDetails.ownerSection.contactButtonTitle',
  );

  static final String loginPageLoginWelcomeText = 'Welcome \nBack';
  static final String loginPageRegistrationWelcomeText = 'Join us';

  static final String forgotPasswordButtonTitle = 'Forgot Password?';

  static final String loginButtonTitle = 'Log in';
  static final String signUpButtonTitle = 'Sign up';

  static final String orDividerTitle = 'Or';

  static final fieldParamsValidationMessage = 'This field is required.';

  static final fieldParamsEmailLabel = 'Email';
  static final fieldParamsEmailHintText = 'Enter your email:';
  static final fieldParamsEmailRegexErrorMessage = 'The email is not valid.';

  static final fieldParamsPasswordLabel = 'Password';
  static final fieldParamsPasswordHintText = 'Enter your password:';
  static final fieldParamsPasswordRegexErrorMessage = 'The password is not valid.';

  static final fieldParamsFullNameLabel = 'Full Name';
  static final fieldParamsFullNameHintText = 'Enter your full name:';
  static final fieldParamsFullNameRegexErrorMessage = 'The full name is not valid.';

  static final authErrorUserNotFoundMessage = 'User not found';
  static final authErrorIncorrectPassword = 'Incorrect password';
  static final authErrorUserAlreadyExists = 'User already exists';
}
