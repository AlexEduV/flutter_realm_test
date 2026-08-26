import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_flutter_project/utils/localisation_util.dart';

import '../../../common/constants/app_asset_routes.dart';
import 'app_localisations_state.dart';

class AppLocalisationsCubit extends Cubit<AppLocalisationsState> {
  AppLocalisationsCubit([this._localisationUtil])
    : super(const AppLocalisationsState(localisations: {}));

  final LocalisationUtil? _localisationUtil;

  Future<void> initLocalisation(String locale) async {
    if (_localisationUtil == null) return;

    final rawJson = await _localisationUtil.loadRawJson(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}localisation_mock_response_data_$locale.json',
    );

    final localisations = _localisationUtil.extractLocalisations(rawJson);
    if (localisations == null) return;

    load(localisations);

    await initializeDateFormatting(locale, null);
    await _localisationUtil.saveLocalisations(localisations);
  }

  void load(Map<String, String> newLocalisations) {
    emit(AppLocalisationsState(localisations: newLocalisations));
  }

  String getLocalisationByKey(String key) {
    return state.localisations[key] ?? '';
  }

  void clear() {
    emit(const AppLocalisationsState(localisations: {}));
  }
}
