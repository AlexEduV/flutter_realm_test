class AppLocalisations {
  static Map<String, String> localisations = {};

  static String get(String key) => localisations[key] ?? '';

  //todo: maybe move to slang for strong typing
  static String appName = get('app.name');

  static String locale = get('app.locale');

  static String explorePageTitle = get('pages.explore.title');

  static String results = get('pages.search.resultsSection.title');

  static String favoritesPageTitle = get('pages.favorites.title');

  static String favoritesEmptyPlaceholder = get('pages.favorites.emptyPlaceholder');

  static String addCarButtonTooltip = get('actions.addCar.tooltip');

  static String deleteButtonTitle = get('actions.delete.title');

  static String distanceWidgetText = get('widgets.distance.text');

  static String recommendedSectionTitle = get('pages.explore.recommendedSection.title');

  static String lastSeenSectionTitle = get('pages.explore.lastSeenSection.title');

  static String searchPageTitle = get('pages.search.title');

  static final String searchTabCars = get('pages.search.tabs.cars');

  static final String searchTabBikes = get('pages.search.tabs.bikes');

  static String searchTabTrucks = get('pages.search.tabs.trucks');

  static String emptySearchPlaceholderText = get('pages.search.emptyPlaceholder');

  static String searchFilterModelTitle = get('filters.model.title');

  static String searchFilterParametersTitle = get('filters.parameters.title');

  static String searchFilterModelPlaceholder = get('filters.model.placeholder');

  static String parameterYearName = get('filters.parameters.year');

  static String parameterColorName = get('filters.parameters.color');

  static String parameterBodyTypeName = get('filters.parameters.bodyTypes.title');

  static String parameterPriceRangeName = get('filters.parameters.priceRange');

  static String parameterFuelTypeName = get('filters.parameters.fuelTypes.title');

  static String parameterTransmissionTypeName = get('filters.parameters.transmissionTypes.title');

  static String filterValidationMessage = get('filters.parameters.filterValidationMessage');

  static String comingSoonPlaceholderPageTitle = get('pages.comingSoon.title');

  static String comingSoonPlaceholderPageSubTitle = get('pages.comingSoon.subtitle');

  static String bodyTypeSedan = get('filters.parameters.bodyTypes.sedan');

  static String bodyTypeHatchback = get('filters.parameters.bodyTypes.hatchback');

  static String bodyTypeUniversal = get('filters.parameters.bodyTypes.universal');

  static String bodyTypeMinivan = get('filters.parameters.bodyTypes.minivan');

  static String bodyTypeCoupe = get('filters.parameters.bodyTypes.coupe');

  static String bodyTypeCrossover = get('filters.parameters.bodyTypes.crossover');

  static String bodyTypeSemi = get('filters.parameters.bodyTypes.semi');

  static String bodyTypeBike = get('filters.parameters.bodyTypes.bike');

  static String fuelTypeDiesel = get('filters.parameters.fuelTypes.diesel');

  static String fuelTypeGasoline = get('filters.parameters.fuelTypes.gasoline');

  static String fuelTypeEv = get('filters.parameters.fuelTypes.ev');

  static String fuelTypeHybrid = get('filters.parameters.fuelTypes.hybrid');

  static String transmissionTypeManual = get('filters.parameters.transmissionTypes.manual');

  static String transmissionTypeAutomatic = get('filters.parameters.transmissionTypes.automatic');

  static String transmissionTypeHybrid = get('filters.parameters.transmissionTypes.hybrid');

  static String vehicleSpecificationsSectionTitle = get('pages.vehicleDetails.sectionTitle');
  static String vehicleSpecificationBody = get('pages.vehicleDetails.specifications.body');
  static String vehicleSpecificationEngine = get('pages.vehicleDetails.specifications.engine');
  static String vehicleSpecificationTransmission = get(
    'pages.vehicleDetails.specifications.transmission',
  );
  static String vehicleSpecificationMileage = get('pages.vehicleDetails.specifications.mileage');
  static String vehicleSpecificationColor = get('pages.vehicleDetails.specifications.color');
  static String vehicleSpecificationYear = get('pages.vehicleDetails.specifications.year');

  static String ownerSectionPersonTypeOwner = get(
    'pages.vehicleDetails.ownerSection.personTypeOwner',
  );
  static String ownerSectionContactButtonTitle = get(
    'pages.vehicleDetails.ownerSection.contactButtonTitle',
  );

  static String loginPageLoginWelcomeText = get('forms.ui.welcomeLoginTitle');
  static String loginPageRegistrationWelcomeText = get('forms.ui.welcomeRegisterTitle');

  static String forgotPasswordButtonTitle = get('forms.ui.forgotPasswordButtonText');

  static String loginButtonTitle = get('forms.ui.loginButtonTitle');
  static String signUpButtonTitle = get('forms.ui.signUpButtonTitle');

  static String orDividerTitle = get('forms.ui.orDividerTitle');

  static String fieldParamsValidationMessage = get('forms.validationMessage');

  static String fieldParamsEmailLabel = get('forms.fieldParams.email.label');
  static String fieldParamsEmailHintText = get('forms.fieldParams.email.hintText');
  static String fieldParamsEmailRegexErrorMessage = get(
    'forms.fieldParams.email.regexErrorMessage',
  );

  static String fieldParamsPasswordLabel = get('forms.fieldParams.password.label');
  static String fieldParamsPasswordHintText = get('forms.fieldParams.password.hintText');
  static String fieldParamsPasswordRegexErrorMessage = get(
    'forms.fieldParams.password.regexErrorMessage',
  );

  static String fieldParamsFullNameLabel = get('forms.fieldParams.fullName.label');
  static String fieldParamsFullNameHintText = get('forms.fieldParams.fullName.hintText');
  static String fieldParamsFullNameRegexErrorMessage = get(
    'forms.fieldParams.fullName.regexErrorMessage',
  );

  static String authErrorUserNotFoundMessage = get('forms.warnings.userNotFound');
  static String authErrorIncorrectPassword = get('forms.warnings.incorrectPassword');
  static String authErrorUserAlreadyExists = get('forms.warnings.userAlreadyExists');

  static String authPasswordStrengthLengthHint = get('forms.hints.passwordMinLength');
  static String authPasswordStrengthLowercaseHint = get('forms.hints.passwordLowercaseChar');
  static String authPasswordStrengthUppercaseHint = get('forms.hints.passwordUpperCaseChar');
  static String authPasswordStrengthDigitHint = get('forms.hints.passwordDigitChar');
  static String authPasswordStrengthSpecialCharacterHint = get('forms.hints.passwordSpecialChar');

  static String inboxPageLoggedOutText = get('pages.inbox.loggedOutPlaceholderText');
  static String inboxPageEmptyText = get('pages.inbox.emptyPlaceholderText');
  static String inboxPageTitle = get('pages.inbox.title');

  static String accountPageTitle = get('pages.account.title');

  static String accountItemPersonalDetails = get('pages.account.items.personalDetails.title');
  static String personalDetailsItemFirstName = get(
    'pages.account.items.personalDetails.firstNameItem',
  );
  static String personalDetailsItemLastName = get(
    'pages.account.items.personalDetails.lastNameItem',
  );
  static String personalDetailsItemEmail = get('pages.account.items.personalDetails.emailItem');
  static String personalDetailsItemPassword = get(
    'pages.account.items.personalDetails.passwordItem',
  );

  static String accountItemLocation = get('pages.account.items.location.title');
  static String locationUsageDescription = get(
    'pages.account.items.location.locationUsageDescription',
  );
  static String locationSettingsItemAccess = get('pages.account.items.location.locationAccessItem');
  static String locationSettingsItemRegion = get('pages.account.items.location.regionItem');

  static String locationSettingsPrivacyItemConditions = get(
    'pages.account.items.location.privacyPolicyItemConditions',
  );
  static String locationSettingsPrivacyItemPrivacyPolicy = get(
    'pages.account.items.location.privacyPolicyItemPolicy',
  );

  static String accountItemMyItems = get('pages.account.items.myItems.title');
  static String myItemsNoResultsPlaceholder = get('pages.account.items.myItems.emptyPlaceholder');

  static String accountItemViewedItems = get('pages.account.items.recentlyViewed.title');
  static String viewedItemsNoResultsPlaceholder = get(
    'pages.account.items.recentlyViewed.emptyPlaceholder',
  );

  static String accountItemClearData = get('pages.account.items.clearData.title');
  static String dataDeletionDescription = get(
    'pages.account.items.clearData.dataDeletionDescription',
  );
  static String clearViewHistoryItem = get('pages.account.items.clearData.viewedHistoryItem');
  static String clearFavoritesItem = get('pages.account.items.clearData.favoritesItem');
  static String clearMyItemsItem = get('pages.account.items.clearData.myItemsItem');
  static String clearAllDataItem = get('pages.account.items.clearData.clearAllDataItem');

  static String accountItemLogout = get('pages.account.items.logOut');
  static String accountItemDeleteAccount = get('pages.account.items.deleteAccount');

  static String dateFormattingYesterday = get('dateFormatting.yesterday');

  static String articlePageMinsToRead = get('pages.article.minsToRead');

  static String shareButtonLabel = get('general.share');
  static String onLabel = get('general.on');
  static String offLabel = get('general.off');

  static String confirmLabel = get('general.confirm');
  static String cancelLabel = get('general.cancel');

  static String clearViewHistoryDialogDescription = get('dialogs.clearViewHistory.description');
  static String clearViewHistoryDialogConfirmLabel = get('dialogs.clearViewHistory.confirmLabel');
  static String clearViewHistoryDialogCancelLabel = get('dialogs.clearViewHistory.cancelLabel');

  static String clearFavoriteItemsDialogDescription = get('dialogs.clearFavoriteItems.description');
  static String clearFavoriteItemsDialogConfirmLabel = get(
    'dialogs.clearFavoriteItems.confirmLabel',
  );
  static String clearFavoriteItemsDialogCancelLabel = get('dialogs.clearFavoriteItems.cancelLabel');

  static String clearMyItemsDialogDescription = get('dialogs.clearMyItems.description');
  static String clearMyItemsDialogConfirmLabel = get('dialogs.clearMyItems.confirmLabel');
  static String clearMyItemsDialogCancelLabel = get('dialogs.clearMyItems.cancelLabel');

  static String clearAllDataDialogDescription = get('dialogs.clearAllData.description');
  static String clearAllDataDialogConfirmLabel = get('dialogs.clearAllData.confirmLabel');
  static String clearAllDataDialogCancelLabel = get('dialogs.clearAllData.cancelLabel');

  static String deleteAccountDialogDescription = get('dialogs.deleteAccount.description');
  static String deleteAccountDialogConfirmLabel = get('dialogs.deleteAccount.confirmLabel');
  static String deleteAccountDialogCancelLabel = get('dialogs.deleteAccount.cancelLabel');
}
