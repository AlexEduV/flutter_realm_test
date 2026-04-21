import '../../core/di/injection_container.dart';
import '../../l10n/l10n_keys.dart';
import '../../presentation/bloc/l10n/app_localisations_cubit.dart';

enum FuelType {
  diesel(L10nKeys.fuelTypeDiesel),
  gasoline(L10nKeys.fuelTypeGasoline),
  ev(L10nKeys.fuelTypeEv),
  hybrid(L10nKeys.fuelTypeHybrid);

  final String localisationKey;

  const FuelType(this.localisationKey);

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
