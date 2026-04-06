import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';

import '../../../core/di/injection_container.dart';
import '../../../domain/models/region_ui_model.dart';
import '../../../l10n/l10n_keys.dart';
import '../../../presentation/bloc/l10n/app_localisations_cubit.dart';

class MockRegionRemoteDataSourceImpl implements RegionRemoteDataSource {
  static late List<RegionEntity> regions;

  @override
  Future<void> init() async {
    //todo: rework, since data sources should not call use cases;
    await serviceLocator<FetchRegionsUseCase>().call();

    regions = serviceLocator<GetAllRegionsUseCase>().call();
  }

  @override
  List<RegionUiModel> getAvailableCountries() {
    final availableCountries = regions
        .map(
          (element) => RegionUiModel(
            code: element.locale,
            countryName: serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
              '${L10nKeys.countryPrefix}${element.locale}',
            ),
          ),
        )
        .toList();

    return availableCountries;
  }
}
