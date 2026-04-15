import 'package:test_flutter_project/common/enums/car_type.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';

import '../../core/di/injection_container.dart';
import '../../presentation/bloc/l10n/app_localisations_cubit.dart';

enum BodyType {
  sedan(CarType.car, L10nKeys.bodyTypeSedan),
  hatchback(CarType.car, L10nKeys.bodyTypeHatchback),
  universal(CarType.car, L10nKeys.bodyTypeUniversal),
  minivan(CarType.car, L10nKeys.bodyTypeMinivan),
  coupe(CarType.car, L10nKeys.bodyTypeCoupe),
  crossover(CarType.car, L10nKeys.bodyTypeCrossover),
  semi(CarType.truck, L10nKeys.bodyTypeSemi),
  bike(CarType.bike, L10nKeys.bodyTypeBike);

  final CarType carType;
  final String localisationKey;

  const BodyType(this.carType, this.localisationKey);

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }
}
