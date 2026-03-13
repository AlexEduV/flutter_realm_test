import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';

void main() {
  group('L10nKeys', () {
    test('appName', () => expect(L10nKeys.appName, 'app.name'));
    test('locale', () => expect(L10nKeys.locale, 'app.locale'));
    test('explorePageTitle', () => expect(L10nKeys.explorePageTitle, 'pages.explore.title'));
    test('results', () => expect(L10nKeys.results, 'pages.search.resultsSection.title'));
    test('favoritesPageTitle', () => expect(L10nKeys.favoritesPageTitle, 'pages.favorites.title'));
    test(
      'favoritesEmptyPlaceholder',
      () => expect(L10nKeys.favoritesEmptyPlaceholder, 'pages.favorites.emptyPlaceholder'),
    );
    test(
      'addCarButtonTooltip',
      () => expect(L10nKeys.addCarButtonTooltip, 'actions.addCar.tooltip'),
    );
    test('deleteButtonTitle', () => expect(L10nKeys.deleteButtonTitle, 'actions.delete.title'));
    test('distanceWidgetText', () => expect(L10nKeys.distanceWidgetText, 'widgets.distance.text'));
    test(
      'recommendedSectionTitle',
      () => expect(L10nKeys.recommendedSectionTitle, 'pages.explore.recommendedSection.title'),
    );
    test(
      'lastSeenSectionTitle',
      () => expect(L10nKeys.lastSeenSectionTitle, 'pages.explore.lastSeenSection.title'),
    );
    test('searchPageTitle', () => expect(L10nKeys.searchPageTitle, 'pages.search.title'));
    test('searchTabCars', () => expect(L10nKeys.searchTabCars, 'pages.search.tabs.cars'));
    test('searchTabBikes', () => expect(L10nKeys.searchTabBikes, 'pages.search.tabs.bikes'));
    test('searchTabTrucks', () => expect(L10nKeys.searchTabTrucks, 'pages.search.tabs.trucks'));
    test(
      'emptySearchPlaceholderText',
      () => expect(L10nKeys.emptySearchPlaceholderText, 'pages.search.emptyPlaceholder'),
    );
    test(
      'searchFilterModelTitle',
      () => expect(L10nKeys.searchFilterModelTitle, 'filters.model.title'),
    );
    test(
      'searchFilterModelPlaceholder',
      () => expect(L10nKeys.searchFilterModelPlaceholder, 'filters.model.placeholder'),
    );
    test(
      'searchFilterParametersTitle',
      () => expect(L10nKeys.searchFilterParametersTitle, 'filters.parameters.title'),
    );
    test('parameterYearName', () => expect(L10nKeys.parameterYearName, 'filters.parameters.year'));
    test(
      'parameterColorName',
      () => expect(L10nKeys.parameterColorName, 'filters.parameters.color'),
    );
    test(
      'parameterBodyTypeName',
      () => expect(L10nKeys.parameterBodyTypeName, 'filters.parameters.bodyTypes.title'),
    );
    test(
      'parameterPriceRangeName',
      () => expect(L10nKeys.parameterPriceRangeName, 'filters.parameters.priceRange'),
    );
    test(
      'parameterFuelTypeName',
      () => expect(L10nKeys.parameterFuelTypeName, 'filters.parameters.fuelTypes.title'),
    );
    test(
      'parameterTransmissionTypeName',
      () => expect(
        L10nKeys.parameterTransmissionTypeName,
        'filters.parameters.transmissionTypes.title',
      ),
    );
    test(
      'filterValidationMessage',
      () => expect(L10nKeys.filterValidationMessage, 'filters.parameters.filterValidationMessage'),
    );
    test(
      'comingSoonPlaceholderPageTitle',
      () => expect(L10nKeys.comingSoonPlaceholderPageTitle, 'pages.comingSoon.title'),
    );
    test(
      'comingSoonPlaceholderPageSubTitle',
      () => expect(L10nKeys.comingSoonPlaceholderPageSubTitle, 'pages.comingSoon.subtitle'),
    );
    test(
      'bodyTypeSedan',
      () => expect(L10nKeys.bodyTypeSedan, 'filters.parameters.bodyTypes.sedan'),
    );
    test(
      'bodyTypeHatchback',
      () => expect(L10nKeys.bodyTypeHatchback, 'filters.parameters.bodyTypes.hatchback'),
    );
    test(
      'bodyTypeUniversal',
      () => expect(L10nKeys.bodyTypeUniversal, 'filters.parameters.bodyTypes.universal'),
    );
    test(
      'bodyTypeMinivan',
      () => expect(L10nKeys.bodyTypeMinivan, 'filters.parameters.bodyTypes.minivan'),
    );
    test(
      'bodyTypeCoupe',
      () => expect(L10nKeys.bodyTypeCoupe, 'filters.parameters.bodyTypes.coupe'),
    );
    test(
      'bodyTypeCrossover',
      () => expect(L10nKeys.bodyTypeCrossover, 'filters.parameters.bodyTypes.crossover'),
    );
    test('bodyTypeSemi', () => expect(L10nKeys.bodyTypeSemi, 'filters.parameters.bodyTypes.semi'));
    test('bodyTypeBike', () => expect(L10nKeys.bodyTypeBike, 'filters.parameters.bodyTypes.bike'));
    test(
      'fuelTypeDiesel',
      () => expect(L10nKeys.fuelTypeDiesel, 'filters.parameters.fuelTypes.diesel'),
    );
    test(
      'fuelTypeGasoline',
      () => expect(L10nKeys.fuelTypeGasoline, 'filters.parameters.fuelTypes.gasoline'),
    );
    test('fuelTypeEv', () => expect(L10nKeys.fuelTypeEv, 'filters.parameters.fuelTypes.ev'));
    test(
      'fuelTypeHybrid',
      () => expect(L10nKeys.fuelTypeHybrid, 'filters.parameters.fuelTypes.hybrid'),
    );
    test(
      'transmissionTypeManual',
      () => expect(L10nKeys.transmissionTypeManual, 'filters.parameters.transmissionTypes.manual'),
    );
    test(
      'transmissionTypeAutomatic',
      () => expect(
        L10nKeys.transmissionTypeAutomatic,
        'filters.parameters.transmissionTypes.automatic',
      ),
    );
    test(
      'transmissionTypeHybrid',
      () => expect(L10nKeys.transmissionTypeHybrid, 'filters.parameters.transmissionTypes.hybrid'),
    );
    test(
      'vehicleSpecificationsSectionTitle',
      () => expect(L10nKeys.vehicleSpecificationsSectionTitle, 'pages.vehicleDetails.sectionTitle'),
    );
    test(
      'vehicleSpecificationBody',
      () => expect(L10nKeys.vehicleSpecificationBody, 'pages.vehicleDetails.specifications.body'),
    );
    test(
      'vehicleSpecificationEngine',
      () =>
          expect(L10nKeys.vehicleSpecificationEngine, 'pages.vehicleDetails.specifications.engine'),
    );
    test(
      'vehicleSpecificationTransmission',
      () => expect(
        L10nKeys.vehicleSpecificationTransmission,
        'pages.vehicleDetails.specifications.transmission',
      ),
    );
    test(
      'vehicleSpecificationMileage',
      () => expect(
        L10nKeys.vehicleSpecificationMileage,
        'pages.vehicleDetails.specifications.mileage',
      ),
    );
    test(
      'vehicleSpecificationColor',
      () => expect(L10nKeys.vehicleSpecificationColor, 'pages.vehicleDetails.specifications.color'),
    );
    test(
      'vehicleSpecificationYear',
      () => expect(L10nKeys.vehicleSpecificationYear, 'pages.vehicleDetails.specifications.year'),
    );
    test(
      'ownerSectionPersonTypeOwner',
      () => expect(
        L10nKeys.ownerSectionPersonTypeOwner,
        'pages.vehicleDetails.ownerSection.personTypeOwner',
      ),
    );
    test(
      'ownerSectionContactButtonTitle',
      () => expect(
        L10nKeys.ownerSectionContactButtonTitle,
        'pages.vehicleDetails.ownerSection.contactButtonTitle',
      ),
    );
    test(
      'loginPageLoginWelcomeText',
      () => expect(L10nKeys.loginPageLoginWelcomeText, 'forms.ui.welcomeLoginTitle'),
    );
    test(
      'loginPageRegistrationWelcomeText',
      () => expect(L10nKeys.loginPageRegistrationWelcomeText, 'forms.ui.welcomeRegisterTitle'),
    );
    test(
      'forgotPasswordButtonTitle',
      () => expect(L10nKeys.forgotPasswordButtonTitle, 'forms.ui.forgotPasswordButtonText'),
    );
    test('loginButtonTitle', () => expect(L10nKeys.loginButtonTitle, 'forms.ui.loginButtonTitle'));
    test(
      'signUpButtonTitle',
      () => expect(L10nKeys.signUpButtonTitle, 'forms.ui.signUpButtonTitle'),
    );
    test('orDividerTitle', () => expect(L10nKeys.orDividerTitle, 'forms.ui.orDividerTitle'));
    test(
      'fieldParamsValidationMessage',
      () => expect(L10nKeys.fieldParamsValidationMessage, 'forms.validationMessage'),
    );
    test(
      'fieldParamsEmailLabel',
      () => expect(L10nKeys.fieldParamsEmailLabel, 'forms.fieldParams.email.label'),
    );
    test(
      'fieldParamsEmailHintText',
      () => expect(L10nKeys.fieldParamsEmailHintText, 'forms.fieldParams.email.hintText'),
    );
    test(
      'fieldParamsEmailRegexErrorMessage',
      () => expect(
        L10nKeys.fieldParamsEmailRegexErrorMessage,
        'forms.fieldParams.email.regexErrorMessage',
      ),
    );
    test(
      'fieldParamsPasswordLabel',
      () => expect(L10nKeys.fieldParamsPasswordLabel, 'forms.fieldParams.password.label'),
    );
    test(
      'fieldParamsPasswordHintText',
      () => expect(L10nKeys.fieldParamsPasswordHintText, 'forms.fieldParams.password.hintText'),
    );
    test(
      'fieldParamsPasswordRegexErrorMessage',
      () => expect(
        L10nKeys.fieldParamsPasswordRegexErrorMessage,
        'forms.fieldParams.password.regexErrorMessage',
      ),
    );
    test(
      'fieldParamsFullNameLabel',
      () => expect(L10nKeys.fieldParamsFullNameLabel, 'forms.fieldParams.fullName.label'),
    );
    test(
      'fieldParamsFullNameHintText',
      () => expect(L10nKeys.fieldParamsFullNameHintText, 'forms.fieldParams.fullName.hintText'),
    );
    test(
      'fieldParamsFullNameRegexErrorMessage',
      () => expect(
        L10nKeys.fieldParamsFullNameRegexErrorMessage,
        'forms.fieldParams.fullName.regexErrorMessage',
      ),
    );
    test(
      'authErrorUserNotFoundMessage',
      () => expect(L10nKeys.authErrorUserNotFoundMessage, 'forms.warnings.userNotFound'),
    );
    test(
      'authErrorIncorrectPassword',
      () => expect(L10nKeys.authErrorIncorrectPassword, 'forms.warnings.incorrectPassword'),
    );
    test(
      'authErrorUserAlreadyExists',
      () => expect(L10nKeys.authErrorUserAlreadyExists, 'forms.warnings.userAlreadyExists'),
    );
    test(
      'authPasswordStrengthLengthHint',
      () => expect(L10nKeys.authPasswordStrengthLengthHint, 'forms.hints.passwordMinLength'),
    );
    test(
      'authPasswordStrengthLowercaseHint',
      () => expect(L10nKeys.authPasswordStrengthLowercaseHint, 'forms.hints.passwordLowercaseChar'),
    );
    test(
      'authPasswordStrengthUppercaseHint',
      () => expect(L10nKeys.authPasswordStrengthUppercaseHint, 'forms.hints.passwordUpperCaseChar'),
    );
    test(
      'authPasswordStrengthDigitHint',
      () => expect(L10nKeys.authPasswordStrengthDigitHint, 'forms.hints.passwordDigitChar'),
    );
    test(
      'authPasswordStrengthSpecialCharacterHint',
      () => expect(
        L10nKeys.authPasswordStrengthSpecialCharacterHint,
        'forms.hints.passwordSpecialChar',
      ),
    );
    test(
      'inboxPageLoggedOutText',
      () => expect(L10nKeys.inboxPageLoggedOutText, 'pages.inbox.loggedOutPlaceholderText'),
    );
    test(
      'inboxPageEmptyText',
      () => expect(L10nKeys.inboxPageEmptyText, 'pages.inbox.emptyPlaceholderText'),
    );
    test('inboxPageTitle', () => expect(L10nKeys.inboxPageTitle, 'pages.inbox.title'));
    test('accountPageTitle', () => expect(L10nKeys.accountPageTitle, 'pages.account.title'));
    test(
      'accountItemPersonalDetails',
      () =>
          expect(L10nKeys.accountItemPersonalDetails, 'pages.account.items.personalDetails.title'),
    );
    test(
      'personalDetailsItemFirstName',
      () => expect(
        L10nKeys.personalDetailsItemFirstName,
        'pages.account.items.personalDetails.firstNameItem',
      ),
    );
    test(
      'personalDetailsItemLastName',
      () => expect(
        L10nKeys.personalDetailsItemLastName,
        'pages.account.items.personalDetails.lastNameItem',
      ),
    );
    test(
      'personalDetailsItemEmail',
      () => expect(
        L10nKeys.personalDetailsItemEmail,
        'pages.account.items.personalDetails.emailItem',
      ),
    );
    test(
      'personalDetailsItemPassword',
      () => expect(
        L10nKeys.personalDetailsItemPassword,
        'pages.account.items.personalDetails.passwordItem.title',
      ),
    );
    test(
      'accountItemLocation',
      () => expect(L10nKeys.accountItemLocation, 'pages.account.items.location.title'),
    );
    test(
      'locationUsageDescription',
      () => expect(
        L10nKeys.locationUsageDescription,
        'pages.account.items.location.locationUsageDescription',
      ),
    );
    test(
      'locationSettingsItemAccess',
      () => expect(
        L10nKeys.locationSettingsItemAccess,
        'pages.account.items.location.locationAccessItem',
      ),
    );
    test(
      'locationSettingsItemRegion',
      () => expect(L10nKeys.locationSettingsItemRegion, 'pages.account.items.location.regionItem'),
    );
    test(
      'locationSettingsPrivacyItemConditions',
      () => expect(
        L10nKeys.locationSettingsPrivacyItemConditions,
        'pages.account.items.location.privacyPolicyItemConditions',
      ),
    );
    test(
      'locationSettingsPrivacyItemPrivacyPolicy',
      () => expect(
        L10nKeys.locationSettingsPrivacyItemPrivacyPolicy,
        'pages.account.items.location.privacyPolicyItemPolicy',
      ),
    );
    test(
      'accountItemMyItems',
      () => expect(L10nKeys.accountItemMyItems, 'pages.account.items.myItems.title'),
    );
    test(
      'myItemsNoResultsPlaceholder',
      () => expect(
        L10nKeys.myItemsNoResultsPlaceholder,
        'pages.account.items.myItems.emptyPlaceholder',
      ),
    );
    test(
      'accountItemViewedItems',
      () => expect(L10nKeys.accountItemViewedItems, 'pages.account.items.recentlyViewed.title'),
    );
    test(
      'viewedItemsNoResultsPlaceholder',
      () => expect(
        L10nKeys.viewedItemsNoResultsPlaceholder,
        'pages.account.items.recentlyViewed.emptyPlaceholder',
      ),
    );
    test(
      'accountItemClearData',
      () => expect(L10nKeys.accountItemClearData, 'pages.account.items.clearData.title'),
    );
    test(
      'dataDeletionDescription',
      () => expect(
        L10nKeys.dataDeletionDescription,
        'pages.account.items.clearData.dataDeletionDescription',
      ),
    );
    test(
      'clearViewHistoryItem',
      () =>
          expect(L10nKeys.clearViewHistoryItem, 'pages.account.items.clearData.viewedHistoryItem'),
    );
    test(
      'clearFavoritesItem',
      () => expect(L10nKeys.clearFavoritesItem, 'pages.account.items.clearData.favoritesItem'),
    );
    test(
      'clearMyItemsItem',
      () => expect(L10nKeys.clearMyItemsItem, 'pages.account.items.clearData.myItemsItem'),
    );
    test(
      'clearAllDataItem',
      () => expect(L10nKeys.clearAllDataItem, 'pages.account.items.clearData.clearAllDataItem'),
    );
    test(
      'accountItemLogout',
      () => expect(L10nKeys.accountItemLogout, 'pages.account.items.logOut'),
    );
    test(
      'accountItemDeleteAccount',
      () => expect(L10nKeys.accountItemDeleteAccount, 'pages.account.items.deleteAccount'),
    );
    test(
      'dateFormattingYesterday',
      () => expect(L10nKeys.dateFormattingYesterday, 'dateFormatting.yesterday'),
    );
    test(
      'articlePageMinsToRead',
      () => expect(L10nKeys.articlePageMinsToRead, 'pages.article.minsToRead'),
    );
    test('shareButtonLabel', () => expect(L10nKeys.shareButtonLabel, 'general.share'));
    test('onLabel', () => expect(L10nKeys.onLabel, 'general.on'));
    test('offLabel', () => expect(L10nKeys.offLabel, 'general.off'));
    test('confirmLabel', () => expect(L10nKeys.confirmLabel, 'general.confirm'));
    test('cancelLabel', () => expect(L10nKeys.cancelLabel, 'general.cancel'));
    test(
      'clearViewHistoryDialogDescription',
      () => expect(
        L10nKeys.clearViewHistoryDialogDescription,
        'dialogs.clearViewHistory.description',
      ),
    );
    test(
      'clearViewHistoryDialogConfirmLabel',
      () => expect(
        L10nKeys.clearViewHistoryDialogConfirmLabel,
        'dialogs.clearViewHistory.confirmLabel',
      ),
    );
    test(
      'clearViewHistoryDialogCancelLabel',
      () => expect(
        L10nKeys.clearViewHistoryDialogCancelLabel,
        'dialogs.clearViewHistory.cancelLabel',
      ),
    );
    test(
      'clearFavoriteItemsDialogDescription',
      () => expect(
        L10nKeys.clearFavoriteItemsDialogDescription,
        'dialogs.clearFavoriteItems.description',
      ),
    );
    test(
      'clearFavoriteItemsDialogConfirmLabel',
      () => expect(
        L10nKeys.clearFavoriteItemsDialogConfirmLabel,
        'dialogs.clearFavoriteItems.confirmLabel',
      ),
    );
    test(
      'clearFavoriteItemsDialogCancelLabel',
      () => expect(
        L10nKeys.clearFavoriteItemsDialogCancelLabel,
        'dialogs.clearFavoriteItems.cancelLabel',
      ),
    );
    test(
      'clearMyItemsDialogDescription',
      () => expect(L10nKeys.clearMyItemsDialogDescription, 'dialogs.clearMyItems.description'),
    );
    test(
      'clearMyItemsDialogConfirmLabel',
      () => expect(L10nKeys.clearMyItemsDialogConfirmLabel, 'dialogs.clearMyItems.confirmLabel'),
    );
    test(
      'clearMyItemsDialogCancelLabel',
      () => expect(L10nKeys.clearMyItemsDialogCancelLabel, 'dialogs.clearMyItems.cancelLabel'),
    );
    test(
      'clearAllDataDialogDescription',
      () => expect(L10nKeys.clearAllDataDialogDescription, 'dialogs.clearAllData.description'),
    );
    test(
      'clearAllDataDialogConfirmLabel',
      () => expect(L10nKeys.clearAllDataDialogConfirmLabel, 'dialogs.clearAllData.confirmLabel'),
    );
    test(
      'clearAllDataDialogCancelLabel',
      () => expect(L10nKeys.clearAllDataDialogCancelLabel, 'dialogs.clearAllData.cancelLabel'),
    );
    test(
      'deleteAccountDialogDescription',
      () => expect(L10nKeys.deleteAccountDialogDescription, 'dialogs.deleteAccount.description'),
    );
    test(
      'deleteAccountDialogConfirmLabel',
      () => expect(L10nKeys.deleteAccountDialogConfirmLabel, 'dialogs.deleteAccount.confirmLabel'),
    );
    test(
      'deleteAccountDialogCancelLabel',
      () => expect(L10nKeys.deleteAccountDialogCancelLabel, 'dialogs.deleteAccount.cancelLabel'),
    );
    test('countryPrefix', () => expect(L10nKeys.countryPrefix, 'countries.'));
    test(
      'promoTypeBestPrice',
      () => expect(L10nKeys.promoTypeBestPrice, 'pages.vehicleDetails.promoType.bestPrice'),
    );
    test(
      'promoTypeLimitedTimeOffer',
      () => expect(
        L10nKeys.promoTypeLimitedTimeOffer,
        'pages.vehicleDetails.promoType.limitedTimeOffer',
      ),
    );
    test(
      'promoTypeOneOwner',
      () => expect(L10nKeys.promoTypeOneOwner, 'pages.vehicleDetails.promoType.oneOwner'),
    );
    test(
      'promoTypeFeatured',
      () => expect(L10nKeys.promoTypeFeatured, 'pages.vehicleDetails.promoType.featured'),
    );
  });
}
