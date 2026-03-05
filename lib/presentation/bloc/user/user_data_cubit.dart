import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/data_sources/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/mocks/mock_users.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/utils/auth_session_util.dart';

import '../../../di/injection_container.dart';
import '../../../domain/usecases/database/delete_car_by_id_use_case.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._localStorage, this._requestLocationPermissionUseCase)
    : super(const UserDataState());

  final BaseLocalStorage _localStorage;
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;

  late UserEntity user;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    user = _localStorage.initUser();
    final userSession = await AuthSessionUtil.getUserSession();

    checkLastSeenCarExpiration(7);

    emit(
      state.copyWith(
        isLoading: false,
        favoriteIds: user.favoriteIds,
        createdIds: user.createdIds,
        viewedIds: user.viewedIds,
        isLocationPermissionGranted: user.isLocationPermissionGranted,
        isUserAuthenticated: userSession != null,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        lastSeenCar: user.lastSeenCar,
        password: user.password,
        region: user.region,
        avatarImageSrc: user.avatarImageSrc,
      ),
    );
  }

  void setLastSeenCar(String? carId) {
    final newLastSeenCarData = carId == null ? null : {DateTime.now(): carId};

    user = user.copyWith(lastSeenCar: newLastSeenCarData);
    emit(state.copyWith(lastSeenCar: newLastSeenCarData));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void checkLastSeenCarExpiration(int days) {
    final lastSeenCar = user.lastSeenCar;

    if (lastSeenCar == null) return;

    final daysAgo = DateTime.now().subtract(Duration(days: days));
    if (lastSeenCar.entries.first.key.isBefore(daysAgo)) {
      setLastSeenCar(null);
    }
  }

  Future<void> requestLocationPermission() async {
    final isGranted = await _requestLocationPermissionUseCase.call();

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

  void updateAvatarImage(String? src) {
    user = user.copyWith(avatarImageSrc: src);
    emit(state.copyWith(avatarImageSrc: src));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void addCarIdToFavorites(String carId) {
    final newList = user.favoriteIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    user = user.copyWith(favoriteIds: cleanedList);
    emit(state.copyWith(favoriteIds: cleanedList));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void removeCarIdFromFavorites(String carId) {
    final newList = user.favoriteIds.toList()..remove(carId);
    user = user.copyWith(favoriteIds: newList);
    emit(state.copyWith(favoriteIds: newList));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void addCarIdToCreated(String carId) {
    final newList = user.createdIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    user = user.copyWith(createdIds: cleanedList);
    emit(state.copyWith(createdIds: cleanedList));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void removeCarIdFromCreated(String carId) {
    final newList = user.createdIds.toList()..remove(carId);
    user = user.copyWith(createdIds: newList);
    emit(state.copyWith(createdIds: newList));

    _localStorage.update(UserExtensions.fromEntity(user));

    serviceLocator<DeleteCarByIdUseCase>().call(carId);
  }

  void addCarToRecentlyViewed(String carId) {
    if (carId.isEmpty) return;

    if (user.viewedIds.lastOrNull == carId) return;

    final newList = user.viewedIds.toList()..add(carId);

    user = user.copyWith(viewedIds: newList);
    emit(state.copyWith(viewedIds: newList));

    _localStorage.update(UserExtensions.fromEntity(user));
  }

  void authUser(String email) {
    final user = MockUsers.getUserByEmail(email);

    if (user == null) return;

    //todo: probably favorite, viewed and created items are needed to be here too,
    // but all the data that was created in the guest mode also should be synced

    emit(
      state.copyWith(
        isUserAuthenticated: true,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        password: user.password,
        region: user.region,
        avatarImageSrc: user.avatarImageSrc,
      ),
    );
  }

  void logOutUser() {
    emit(state.copyWith(isUserAuthenticated: false));
  }
}
