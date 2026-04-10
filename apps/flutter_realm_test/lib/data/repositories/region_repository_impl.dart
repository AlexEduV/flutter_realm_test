import 'package:test_futter_project/domain/repositories/region_repository.dart';

import '../../domain/data_sources/remote/region_remote_data_source.dart';
import '../../domain/entities/region_entity.dart';

class RegionRepositoryImpl implements RegionRepository {
  final RegionRemoteDataSource _regionRemoteDataSource;
  RegionRepositoryImpl(this._regionRemoteDataSource);

  List<RegionEntity>? regions;

  @override
  Future<void> loadRegions() async {
    if (regions != null) return;

    await _regionRemoteDataSource.loadRegions();
    regions = _regionRemoteDataSource.getAllRegions();
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
