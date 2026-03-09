import 'package:flutter/cupertino.dart';

class AppLocalisations {
  final Map<String, String> localisations;
  final String locale;

  AppLocalisations(this.localisations, this.locale);

  static AppLocalisations of(BuildContext context) {
    // This assumes you have an InheritedWidget or Localizations widget set up.
    return Localizations.of<AppLocalisations>(context, AppLocalisations)!;
  }

  String get(String key) => localisations[key] ?? '';

  //todo: maybe move to slang for strong typing
  String get appName => get('app.name');

  String get explorePageTitle => get('pages.explore.title');

  String get results => get('pages.search.resultsSection.title');

  String get favoritesPageTitle => get('pages.favorites.title');

  String get favoritesEmptyPlaceholder => get('pages.favorites.emptyPlaceholder');

  String get addCarButtonTooltip => get('actions.addCar.tooltip');

  String get deleteButtonTitle => get('actions.delete.title');

  String get distanceWidgetText => get('widgets.distance.text');

  String get recommendedSectionTitle => get('pages.explore.recommendedSection.title');

  String get lastSeenSectionTitle => get('pages.explore.lastSeenSection.title');

  String get searchPageTitle => get('pages.search.title');

  String get searchTabCars => get('pages.search.tabs.cars');

  String get searchTabBikes => get('pages.search.tabs.bikes');

  String get searchTabTrucks => get('pages.search.tabs.trucks');

  String get emptySearchPlaceholderText => get('pages.search.emptyPlaceholder');

  String get searchFilterModelTitle => get('filters.model.title');

  String get searchFilterParametersTitle => get('filters.parameters.title');

  String get searchFilterModelPlaceholder => get('filters.model.placeholder');

  String get parameterYearName => get('filters.parameters.year');

  String get parameterColorName => get('filters.parameters.color');

  String get parameterBodyTypeName => get('filters.parameters.bodyTypes.title');

  String get parameterPriceRangeName => get('filters.parameters.priceRange');

  String get parameterFuelTypeName => get('filters.parameters.fuelTypes.title');

  String get parameterTransmissionTypeName => get('filters.parameters.transmissionTypes.title');

  String get filterValidationMessage => get('filters.parameters.filterValidationMessage');

  String get comingSoonPlaceholderPageTitle => get('pages.comingSoon.title');

  String get comingSoonPlaceholderPageSubTitle => get('pages.comingSoon.subtitle');

  String get bodyTypeSedan => get('filters.parameters.bodyTypes.sedan');

  String get bodyTypeHatchback => get('filters.parameters.bodyTypes.hatchback');

  String get bodyTypeUniversal => get('filters.parameters.bodyTypes.universal');

  String get bodyTypeMinivan => get('filters.parameters.bodyTypes.minivan');

  String get bodyTypeCoupe => get('filters.parameters.bodyTypes.coupe');

  String get bodyTypeCrossover => get('filters.parameters.bodyTypes.crossover');

  String get bodyTypeSemi => get('filters.parameters.bodyTypes.semi');

  String get bodyTypeBike => get('filters.parameters.bodyTypes.bike');

  String get fuelTypeDiesel => get('filters.parameters.fuelTypes.diesel');

  String get fuelTypeGasoline => get('filters.parameters.fuelTypes.gasoline');

  String get fuelTypeEv => get('filters.parameters.fuelTypes.ev');

  String get fuelTypeHybrid => get('filters.parameters.fuelTypes.hybrid');

  String get transmissionTypeManual => get('filters.parameters.transmissionTypes.manual');

  String get transmissionTypeAutomatic => get('filters.parameters.transmissionTypes.automatic');

  String get transmissionTypeHybrid => get('filters.parameters.transmissionTypes.hybrid');

  String get vehicleSpecificationsSectionTitle => get('pages.vehicleDetails.sectionTitle');
  String get vehicleSpecificationBody => get('pages.vehicleDetails.specifications.body');
  String get vehicleSpecificationEngine => get('pages.vehicleDetails.specifications.engine');
  String get vehicleSpecificationTransmission =>
      get('pages.vehicleDetails.specifications.transmission');
  String get vehicleSpecificationMileage => get('pages.vehicleDetails.specifications.mileage');
  String get vehicleSpecificationColor => get('pages.vehicleDetails.specifications.color');
  String get vehicleSpecificationYear => get('pages.vehicleDetails.specifications.year');

  String get ownerSectionPersonTypeOwner =>
      get('pages.vehicleDetails.ownerSection.personTypeOwner');
  String get ownerSectionContactButtonTitle =>
      get('pages.vehicleDetails.ownerSection.contactButtonTitle');

  String get loginPageLoginWelcomeText => get('forms.ui.welcomeLoginTitle');
  String get loginPageRegistrationWelcomeText => get('forms.ui.welcomeRegisterTitle');

  String get forgotPasswordButtonTitle => get('forms.ui.forgotPasswordButtonText');

  String get loginButtonTitle => get('forms.ui.loginButtonTitle');
  String get signUpButtonTitle => get('forms.ui.signUpButtonTitle');

  String get orDividerTitle => get('forms.ui.orDividerTitle');

  String get fieldParamsValidationMessage => get('forms.validationMessage');

  String get fieldParamsEmailLabel => get('forms.fieldParams.email.label');
  String get fieldParamsEmailHintText => get('forms.fieldParams.email.hintText');
  String get fieldParamsEmailRegexErrorMessage => get('forms.fieldParams.email.regexErrorMessage');

  String get fieldParamsPasswordLabel => get('forms.fieldParams.password.label');
  String get fieldParamsPasswordHintText => get('forms.fieldParams.password.hintText');
  String get fieldParamsPasswordRegexErrorMessage =>
      get('forms.fieldParams.password.regexErrorMessage');

  String get fieldParamsFullNameLabel => get('forms.fieldParams.fullName.label');
  String get fieldParamsFullNameHintText => get('forms.fieldParams.fullName.hintText');
  String get fieldParamsFullNameRegexErrorMessage =>
      get('forms.fieldParams.fullName.regexErrorMessage');

  String get authErrorUserNotFoundMessage => get('forms.warnings.userNotFound');
  String get authErrorIncorrectPassword => get('forms.warnings.incorrectPassword');
  String get authErrorUserAlreadyExists => get('forms.warnings.userAlreadyExists');

  String get authPasswordStrengthLengthHint => get('forms.hints.passwordMinLength');
  String get authPasswordStrengthLowercaseHint => get('forms.hints.passwordLowercaseChar');
  String get authPasswordStrengthUppercaseHint => get('forms.hints.passwordUpperCaseChar');
  String get authPasswordStrengthDigitHint => get('forms.hints.passwordDigitChar');
  String get authPasswordStrengthSpecialCharacterHint => get('forms.hints.passwordSpecialChar');

  String get inboxPageLoggedOutText => get('pages.inbox.loggedOutPlaceholderText');
  String get inboxPageEmptyText => get('pages.inbox.emptyPlaceholderText');
  String get inboxPageTitle => get('pages.inbox.title');

  String get accountPageTitle => get('pages.account.title');

  String get accountItemPersonalDetails => get('pages.account.items.personalDetails.title');
  String get personalDetailsItemFirstName =>
      get('pages.account.items.personalDetails.firstNameItem');
  String get personalDetailsItemLastName => get('pages.account.items.personalDetails.lastNameItem');
  String get personalDetailsItemEmail => get('pages.account.items.personalDetails.emailItem');
  String get personalDetailsItemPassword => get('pages.account.items.personalDetails.passwordItem');

  String get accountItemLocation => get('pages.account.items.location.title');
  String get locationUsageDescription =>
      get('pages.account.items.location.locationUsageDescription');
  String get locationSettingsItemAccess => get('pages.account.items.location.locationAccessItem');
  String get locationSettingsItemRegion => get('pages.account.items.location.regionItem');

  String get locationSettingsPrivacyItemConditions =>
      get('pages.account.items.location.privacyPolicyItemConditions');
  String get locationSettingsPrivacyItemPrivacyPolicy =>
      get('pages.account.items.location.privacyPolicyItemPolicy');

  String get accountItemMyItems => get('pages.account.items.myItems.title');
  String get myItemsNoResultsPlaceholder => get('pages.account.items.myItems.emptyPlaceholder');

  String get accountItemViewedItems => get('pages.account.items.recentlyViewed.title');
  String get viewedItemsNoResultsPlaceholder =>
      get('pages.account.items.recentlyViewed.emptyPlaceholder');

  String get accountItemClearData => get('pages.account.items.clearData.title');
  String get dataDeletionDescription =>
      get('pages.account.items.clearData.dataDeletionDescription');
  String get clearViewHistoryItem => get('pages.account.items.clearData.viewedHistoryItem');
  String get clearFavoritesItem => get('pages.account.items.clearData.favoritesItem');
  String get clearMyItemsItem => get('pages.account.items.clearData.myItemsItem');
  String get clearAllDataItem => get('pages.account.items.clearData.clearAllDataItem');

  String get accountItemLogout => get('pages.account.items.logOut');
  String get accountItemDeleteAccount => get('pages.account.items.deleteAccount');

  String get dateFormattingYesterday => get('dateFormatting.yesterday');

  String get articlePageMinsToRead => get('pages.article.minsToRead');

  String get shareButtonLabel => get('general.share');
  String get onLabel => get('general.on');
  String get offLabel => get('general.off');

  String get confirmLabel => get('general.confirm');
  String get cancelLabel => get('general.cancel');

  String get clearViewHistoryDialogDescription => get('dialogs.clearViewHistory.description');
  String get clearViewHistoryDialogConfirmLabel => get('dialogs.clearViewHistory.confirmLabel');
  String get clearViewHistoryDialogCancelLabel => get('dialogs.clearViewHistory.cancelLabel');

  String get clearFavoriteItemsDialogDescription => get('dialogs.clearFavoriteItems.description');
  String get clearFavoriteItemsDialogConfirmLabel => get('dialogs.clearFavoriteItems.confirmLabel');
  String get clearFavoriteItemsDialogCancelLabel => get('dialogs.clearFavoriteItems.cancelLabel');

  String get clearMyItemsDialogDescription => get('dialogs.clearMyItems.description');
  String get clearMyItemsDialogConfirmLabel => get('dialogs.clearMyItems.confirmLabel');
  String get clearMyItemsDialogCancelLabel => get('dialogs.clearMyItems.cancelLabel');

  String get clearAllDataDialogDescription => get('dialogs.clearAllData.description');
  String get clearAllDataDialogConfirmLabel => get('dialogs.clearAllData.confirmLabel');
  String get clearAllDataDialogCancelLabel => get('dialogs.clearAllData.cancelLabel');

  String get deleteAccountDialogDescription => get('dialogs.deleteAccount.description');
  String get deleteAccountDialogConfirmLabel => get('dialogs.deleteAccount.confirmLabel');
  String get deleteAccountDialogCancelLabel => get('dialogs.deleteAccount.cancelLabel');
}
