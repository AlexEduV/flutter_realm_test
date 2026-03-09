import 'package:flutter/cupertino.dart';

import '../localisation_util.dart';
import 'l10n.dart';

class AppLocalisationsDelegate extends LocalizationsDelegate<AppLocalisations> {
  const AppLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<AppLocalisations> load(Locale locale) async {
    final localisations = await LocalisationUtil.loadLocalisations(
      'assets/mocks/localisation_mock_response_data_${locale.languageCode}.json',
    );
    return AppLocalisations(localisations, locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalisations> old) => false;
}
