import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/repositories/region_model_repository.dart';
import 'package:test_flutter_project/domain/repositories/region_repository.dart';
import 'package:test_flutter_project/domain/usecases/url/open_url_link_use_case.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_page_state.dart';

class LocationSettingsPageCubit extends Cubit<LocationSettingsPageState> {
  LocationSettingsPageCubit(
    this._regionRepository,
    this._regionModelRepository,
    this._openUrlLinkUseCase,
  ) : super(const LocationSettingsPageState());

  final RegionRepository _regionRepository;
  final RegionModelRepository _regionModelRepository;
  final OpenUrlLinkUseCase _openUrlLinkUseCase;

  void loadCurrentRegionByCode(String code) {
    final region = _regionRepository.getRegionByCode(code);
    emit(state.copyWith(currentRegion: region));
  }

  void updateAvailableCountries() {
    final availableCountries = _regionModelRepository.getAvailableCountries();
    emit(state.copyWith(availableRegions: availableCountries));
  }

  Future<void> openUrl(String url) async {
    await _openUrlLinkUseCase.call(url);
  }
}
