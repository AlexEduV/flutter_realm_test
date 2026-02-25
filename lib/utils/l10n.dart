class AppLocalisations {
  static Map<String, String> localisations = {};

  static String get(String key) => localisations[key] ?? '';

  //todo: maybe move to slang for strong typing
  static final String appName = get('app.name');

  static final String explorePageTitle = get('pages.explore.title');

  static final String results = get('pages.search.resultsSection.title');

  static final String favoritesPageTitle = get('pages.favorites.title');

  static final String favoritesEmptyPlaceholder = get('pages.favorites.emptyPlaceholder');

  static final String addCarButtonTooltip = get('actions.addCar.tooltip');

  static final String deleteButtonTitle = get('actions.delete.title');

  static final String distanceWidgetText = get('widgets.distance.text');

  static final String recommendedSectionTitle = get('pages.explore.recommendedSection.title');

  static final String lastSeenSectionTitle = get('pages.explore.lastSeenSection.title');

  static final String searchPageTitle = get('pages.search.title');

  static final String searchTabCars = get('pages.search.tabs.cars');

  static final String searchTabBikes = get('pages.search.tabs.bikes');

  static final String searchTabTrucks = get('pages.search.tabs.trucks');

  static final String emptySearchPlaceholderText = get('pages.search.emptyPlaceholder');

  static final String searchFilterModelTitle = get('filters.model.title');

  static final String searchFilterParametersTitle = get('filters.parameters.title');

  static final String searchFilterModelPlaceholder = get('filters.model.placeholder');

  static final String parameterYearName = get('filters.parameters.year');

  static final String parameterColorName = get('filters.parameters.color');

  static final String parameterBodyTypeName = get('filters.parameters.bodyTypes.title');

  static final String parameterPriceRangeName = get('filters.parameters.priceRange');

  static final String parameterFuelTypeName = get('filters.parameters.fuelTypes.title');

  static final String parameterTransmissionTypeName = get(
    'filters.parameters.transmissionTypes.title',
  );

  static final String filterValidationMessage = get('filters.parameters.filterValidationMessage');

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

  static final String loginPageLoginWelcomeText = get('forms.ui.welcomeLoginTitle');
  static final String loginPageRegistrationWelcomeText = get('forms.ui.welcomeRegisterTitle');

  static final String forgotPasswordButtonTitle = get('forms.ui.forgotPasswordButtonText');

  static final String loginButtonTitle = get('forms.ui.loginButtonTitle');
  static final String signUpButtonTitle = get('forms.ui.signUpButtonTitle');

  static final String orDividerTitle = get('forms.ui.orDividerTitle');

  static final String fieldParamsValidationMessage = get('forms.validationMessage');

  static final String fieldParamsEmailLabel = get('forms.fieldParams.email.label');
  static final String fieldParamsEmailHintText = get('forms.fieldParams.email.hintText');
  static final String fieldParamsEmailRegexErrorMessage = get(
    'forms.fieldParams.email.regexErrorMessage',
  );

  static final String fieldParamsPasswordLabel = get('forms.fieldParams.password.label');
  static final String fieldParamsPasswordHintText = get('forms.fieldParams.password.hintText');
  static final String fieldParamsPasswordRegexErrorMessage = get(
    'forms.fieldParams.password.regexErrorMessage',
  );

  static final String fieldParamsFullNameLabel = get('forms.fieldParams.fullName.label');
  static final String fieldParamsFullNameHintText = get('forms.fieldParams.fullName.hintText');
  static final String fieldParamsFullNameRegexErrorMessage = get(
    'forms.fieldParams.fullName.regexErrorMessage',
  );

  static final String authErrorUserNotFoundMessage = get('forms.warnings.userNotFound');
  static final String authErrorIncorrectPassword = get('forms.warnings.incorrectPassword');
  static final String authErrorUserAlreadyExists = get('forms.warnings.userAlreadyExists');

  static final String authPasswordStrengthLengthHint = get('forms.hints.passwordMinLength');
  static final String authPasswordStrengthLowercaseHint = get('forms.hints.passwordLowercaseChar');
  static final String authPasswordStrengthUppercaseHint = get('forms.hints.passwordUpperCaseChar');
  static final String authPasswordStrengthDigitHint = get('forms.hints.passwordDigitChar');
  static final String authPasswordStrengthSpecialCharacterHint = get(
    'forms.hints.passwordSpecialChar',
  );

  static final String inboxPageLoggedOutText = get('pages.inbox.loggedOutPlaceholderText');
  static final String inboxPageEmptyText = get('pages.inbox.emptyPlaceholderText');
  static final String inboxPageTitle = get('pages.inbox.title');

  static final String accountPageTitle = get('pages.account.title');
  static final String accountItemPersonalDetails = get('pages.account.items.personalDetails');
  static final String accountItemLocation = get('pages.account.items.location');
  static final String accountItemMyItems = get('pages.account.items.myItems');
  static final String accountItemViewedItems = get('pages.account.items.recentlyViewed');
  static final String accountItemClearData = get('pages.account.items.clearData');
  static final String accountItemLogout = get('pages.account.items.logOut');
  static final String accountItemDeleteAccount = get('pages.account.items.deleteAccount');
}
