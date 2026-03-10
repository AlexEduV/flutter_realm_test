import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';

import '../../domain/entities/region_entity.dart';

class RegionRepositoryImpl implements RegionRepository {
  static final RegionRepositoryImpl _instance = RegionRepositoryImpl._internal();
  factory RegionRepositoryImpl() => _instance;
  RegionRepositoryImpl._internal();

  List<RegionEntity>? _regions;

  @override
  Future<void> loadRegions() async {
    if (_regions != null) return; // Already loaded
    final jsonString = await rootBundle.loadString(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}regions_data.json',
    );
    final List data = json.decode(jsonString);
    _regions = data.map((e) => RegionEntity.fromJson(e)).toList();
  }

  // Get region by code
  @override
  RegionEntity? getRegionByCode(String code) {
    return _regions?.cast<RegionEntity?>().firstWhere((r) => r?.locale == code, orElse: () => null);
  }

  // Optionally, get all regions
  @override
  List<RegionEntity> getAllRegions() => _regions ?? [];
}
