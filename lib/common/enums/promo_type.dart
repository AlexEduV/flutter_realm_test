import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

enum PromoType {
  bestPrice('best_price', L10nKeys.promoTypeBestPrice),
  limitedTimeOffer('limited_time_offer', L10nKeys.promoTypeLimitedTimeOffer),
  oneOwner('one_owner', L10nKeys.promoTypeOneOwner),
  featured('featured', L10nKeys.promoTypeFeatured);

  final String code;
  final String localisationKey;

  const PromoType(this.code, this.localisationKey);

  static PromoType? fromCode(String? code) {
    if (code == null) return null;

    return PromoType.values.cast<PromoType?>().firstWhere(
      (e) => e?.code == code,
      orElse: () => null,
    );
  }

  String fromLocalisations() {
    return serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(localisationKey);
  }
}
