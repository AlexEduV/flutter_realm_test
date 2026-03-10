import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/usecases/regions/fetch_regions_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_regions_use_case.dart';

class MockRegionService {
  static late List<RegionEntity> regions;

  static Future<void> init() async {
    await serviceLocator<FetchRegionsUseCase>().call();

    regions = serviceLocator<GetAllRegionsUseCase>().call();
  }
}
