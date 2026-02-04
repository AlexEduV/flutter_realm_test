import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_usecase.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._localStorage, this._requestLocationPermissionUseCase)
    : super(const UserDataState());

  final BaseLocalStorage _localStorage;
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;

  late UserEntity user;

  void init() {
    user = _localStorage.initUser();
  }

  Future<void> requestLocationPermission() async {
    final isGranted = await _requestLocationPermissionUseCase.call(null);

    if (!isGranted) {
      return;
    }

    updateLocationPermissionStatus(isGranted);

    final bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
    }
  }

  void updateLocationPermissionStatus(bool newStatus) {
    user = user.copyWith(isLocationPermissionGranted: newStatus);
    _localStorage.update(UserExtensions.fromEntity(user));

    emit(state.copyWith(isLocationPermissionGranted: newStatus));
  }
}
