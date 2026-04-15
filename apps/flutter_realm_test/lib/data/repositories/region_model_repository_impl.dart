import 'package:test_flutter_project/domain/data_sources/remote/region_remote_data_source.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';

class RegionModelRepositoryImpl implements RegionModelRepository {
  final RegionRemoteDataSource _regionRemoteDataSource;

  RegionModelRepositoryImpl(this._regionRemoteDataSource);

  @override
  List<RegionUiModel> getAvailableCountries() {
    return _regionRemoteDataSource.getAvailableCountries();
  }

  @override
  Future<void> init() {
    return _regionRemoteDataSource.init();
  }
}
