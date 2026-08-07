import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/region_entity.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_all_region_models_use_case.dart';
import 'package:test_flutter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_flutter_project/domain/usecases/url/open_url_link_use_case.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_state.dart';

class LocationSettingsPageCubit extends Cubit<LocationSettingsState> {
  LocationSettingsPageCubit(
    this._getRegionByCodeUseCase,
    this._getAllRegionModelsUseCase,
    this._openUrlLinkUseCase,
  ) : super(const LocationSettingsState());

  final GetRegionByCodeUseCase _getRegionByCodeUseCase;
  final GetAllRegionModelsUseCase _getAllRegionModelsUseCase;
  final OpenUrlLinkUseCase _openUrlLinkUseCase;

  RegionEntity? getRegionByCode(String code) {
    final region = _getRegionByCodeUseCase.call(code);
    return region;
  }

  void updateAvailableCountries() {
    final availableCountries = _getAllRegionModelsUseCase.call();
    emit(state.copyWith(availableRegions: availableCountries));
  }

  Future<void> openUrl(String url) async {
    await _openUrlLinkUseCase.call(url);
  }
}
