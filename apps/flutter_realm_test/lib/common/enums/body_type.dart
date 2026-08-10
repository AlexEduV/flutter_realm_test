import 'package:test_flutter_project/common/enums/car_type.dart';

import '../../core/di/injection_container.dart';
import '../../presentation/features/l10n/app_localisations_cubit.dart';
import '../../presentation/features/search/search_page_identifiers.dart';

enum BodyType {
  sedan(CarType.car, SearchPageLocaleKeys.bodyTypeSedan),
  hatchback(CarType.car, SearchPageLocaleKeys.bodyTypeHatchback),
  universal(CarType.car, SearchPageLocaleKeys.bodyTypeUniversal),
  minivan(CarType.car, SearchPageLocaleKeys.bodyTypeMinivan),
  coupe(CarType.car, SearchPageLocaleKeys.bodyTypeCoupe),
  crossover(CarType.car, SearchPageLocaleKeys.bodyTypeCrossover),
  semi(CarType.truck, SearchPageLocaleKeys.bodyTypeSemi),
  bike(CarType.bike, SearchPageLocaleKeys.bodyTypeBike);

  const BodyType(this.carType, this.localisationKey);

  final CarType carType;
  final String localisationKey;

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }

  static List<BodyType> filterByCarType(CarType type) {
    final bodyTypesList = BodyType.values.where((element) => element.carType == type).toList();

    return bodyTypesList;
  }
}
