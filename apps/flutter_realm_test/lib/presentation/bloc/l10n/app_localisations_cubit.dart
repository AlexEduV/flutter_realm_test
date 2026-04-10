import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_localisations_state.dart';

class AppLocalisationsCubit extends Cubit<AppLocalisationsState> {
  AppLocalisationsCubit() : super(const AppLocalisationsState(localisations: {}));

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
