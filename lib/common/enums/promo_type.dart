import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

enum PromoType {
  //todo: not the best idea. localisation keys should only be in the l10n file;
  bestPrice('best_price', 'pages.vehicleDetails.promoType.bestPrice'),
  limitedTimeOffer('limited_time_offer', 'pages.vehicleDetails.promoType.limitedTimeOffer'),
  oneOwner('one_owner', 'pages.vehicleDetails.promoType.oneOwner'),
  featured('featured', 'pages.vehicleDetails.promoType.featured');

  final String code;
  final String localized;

  const PromoType(this.code, this.localized);

  static PromoType? fromCode(String? code) {
    if (code == null) return null;

    return PromoType.values.cast<PromoType?>().firstWhere(
      (e) => e?.code == code,
      orElse: () => null,
    );
  }

  String? fromLocalisations() {
    return serviceLocator<AppLocalisationsCubit>().state.localisations[localized] ?? '';
  }
}
