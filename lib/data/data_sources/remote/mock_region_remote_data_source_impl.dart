import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/constants/app_asset_routes.dart';
import '../../../core/di/injection_container.dart';
import '../../../domain/models/api_response.dart';
import '../../../domain/models/region_ui_model.dart';
import '../../../l10n/l10n_keys.dart';
import '../../../presentation/bloc/l10n/app_localisations_cubit.dart';

class MockRegionRemoteDataSourceImpl implements RegionRemoteDataSource {
  List<RegionEntity>? regions = [];

  @override
  Future<void> init() async {
    await loadRegions();
  }

  @override
  List<RegionUiModel> getAvailableCountries() {
    final availableCountries = (regions ?? [])
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

  @override
  List<RegionEntity> getAllRegions() {
    return regions ?? [];
  }

  @override
  Future<void> loadRegions() async {
    final jsonString = await rootBundle.loadString(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}regions_data.json',
    );

    final jsonDecoded = json.decode(jsonString);
    final response = ApiResponse.fromJson(jsonDecoded, (data) {
      final results = data as List;

      return results.expand((item) {
        final regionsList = item['regions'] as List;

        return regionsList.map((element) => RegionEntity.fromJson(element));
      }).toList();
    });

    if (response.status != ApiConstants.apiSuccessStatus) {
      return;
    }

    regions = response.results;
  }
}
