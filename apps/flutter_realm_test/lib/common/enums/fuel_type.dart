import '../../core/di/injection_container.dart';
import '../../presentation/features/l10n/app_localisations_cubit.dart';
import '../../presentation/features/search/search_page_identifiers.dart';

enum FuelType {
  diesel(SearchPageLocaleKeys.fuelTypeDiesel),
  gasoline(SearchPageLocaleKeys.fuelTypeGasoline),
  ev(SearchPageLocaleKeys.fuelTypeEv),
  hybrid(SearchPageLocaleKeys.fuelTypeHybrid);

  const FuelType(this.localisationKey);

  final String localisationKey;

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }

  String getUnitOfMeasurement() {
    return this == FuelType.ev ? 'kW' : 'L';
  }
}
