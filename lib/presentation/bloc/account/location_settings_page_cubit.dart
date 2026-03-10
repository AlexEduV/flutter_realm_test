import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/account/location_settings_page_state.dart';

class LocationSettingsPageCubit extends Cubit<LocationSettingsPageState> {
  LocationSettingsPageCubit() : super(const LocationSettingsPageState());

  void tickAnimation() {
    emit(state.copyWith(isLocationItemAnimating: !state.isLocationItemAnimating));
  }
}
