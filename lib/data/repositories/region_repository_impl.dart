import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';

import '../../common/api_constants.dart';
import '../../domain/entities/region_entity.dart';
import '../../domain/models/api_response.dart';

class RegionRepositoryImpl implements RegionRepository {
  static final RegionRepositoryImpl _instance = RegionRepositoryImpl._internal();
  factory RegionRepositoryImpl() => _instance;
  RegionRepositoryImpl._internal();

  List<RegionEntity>? regions;

  @override
  Future<void> loadRegions() async {
    if (regions != null) return;

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

  // Get region by code
  @override
  RegionEntity? getRegionByCode(String code) {
    return regions?.cast<RegionEntity?>().firstWhere((r) => r?.locale == code, orElse: () => null);
  }

  // Optionally, get all regions
  @override
  List<RegionEntity> getAllRegions() => regions ?? [];
}
