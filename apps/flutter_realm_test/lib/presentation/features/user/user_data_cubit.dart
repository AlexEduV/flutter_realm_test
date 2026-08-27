import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/last_seen_car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_flutter_project/domain/repositories/user_repository.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../l10n/app_localisations_cubit.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(
    this._timeService,
    this._userRepository,
    this._authRepository,
    this._imagePickerRepository,
    this._carRepository,
    this._checkLocationServiceStatusUseCase,
    this._openAppSettingsUseCase,
    this._requestLocationPermissionUseCase,
    this._checkLocationPermissionStatusUseCase,
    this._appLocalisationsCubit,
  ) : super(UserDataState(user: UserEntity.empty()));

  final TimeService _timeService;

  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  final ImagePickerRepository _imagePickerRepository;
  final CarRepository _carRepository;

  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final CheckLocationServiceStatusUseCase _checkLocationServiceStatusUseCase;

  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;

  final AppLocalisationsCubit _appLocalisationsCubit;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    final user = _userRepository.initUser();
    final isUserLoggedIn = await _authRepository.isUserLoggedIn();

    await _appLocalisationsCubit.initLocalisation(user.region);

    checkLastSeenCarExpiration(days: 7);

    emit(state.copyWith(user: user, isLoading: false, isUserAuthenticated: isUserLoggedIn));
  }

  Future<bool> isLocationPermissionGranted() {
    return _checkLocationPermissionStatusUseCase.call();
  }

  void setFirstName(String firstName) {
    final user = state.user.copyWith(firstName: firstName);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void setLastName(String lastName) {
    final user = state.user.copyWith(lastName: lastName);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void setEmail(String email) {
    final user = state.user.copyWith(email: email);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void setPassword(String password) {
    final user = state.user.copyWith(password: password);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void setLastSeenCar(String? carId) {
    final newLastSeenCar = carId == null
        ? null
        : LastSeenCarEntity(carId: carId, seenAt: _timeService.now());

    final user = state.user.copyWith(lastSeenCar: newLastSeenCar);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void checkLastSeenCarExpiration({required int days}) {
    final lastSeenCar = state.user.lastSeenCar;

    if (lastSeenCar == null) return;

    final daysAgo = _timeService.now().subtract(Duration(days: days));
    if (lastSeenCar.seenAt.isBefore(daysAgo)) {
      setLastSeenCar(null);
    }
  }

  Future<void> requestLocationPermission() async {
    final isGranted = await _requestLocationPermissionUseCase.call();

    updateLocationPermissionStatus(isGranted);

    if (isGranted) {
      final isServiceEnabled = await _checkLocationServiceStatusUseCase.call();
      if (!isServiceEnabled) {
        await _openAppSettingsUseCase.call();
      }
    }
  }

  Future<bool> openLocationSettings() {
    return _openAppSettingsUseCase.call();
  }

  void updateLocationPermissionStatus(bool newStatus) {
    final user = state.user.copyWith(isLocationPermissionGranted: newStatus);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  Future<void> updateAvatarImage() async {
    final path = await _imagePickerRepository.pickImage();
    if (path == null) return;

    final user = state.user.copyWith(avatarImageSrc: path);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void addCarIdToFavorites(String carId) {
    final newList = state.user.favoriteIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    final user = state.user.copyWith(favoriteIds: cleanedList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void removeCarIdFromFavorites(String carId) {
    final newList = state.user.favoriteIds.toList()..remove(carId);
    final user = state.user.copyWith(favoriteIds: newList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void addCarIdToCreated(String carId) {
    final newList = state.user.createdIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    final user = state.user.copyWith(createdIds: cleanedList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void removeCarIdFromCreated(String carId) {
    final newList = state.user.createdIds.toList()..remove(carId);
    final user = state.user.copyWith(createdIds: newList);
    emit(state.copyWith(user: user));

    updateUser(user: user);

    _carRepository.deleteCarById(carId);
  }

  void addCarToRecentlyViewed(String carId) {
    if (carId.isEmpty) return;

    if (state.user.viewedIds.lastOrNull == carId) return;

    final newList = state.user.viewedIds.toList()..add(carId);

    final int maxEntriesAllowed = 20;
    final limitedList = newList.length > maxEntriesAllowed
        ? newList.sublist(newList.length - maxEntriesAllowed)
        : newList;

    final user = state.user.copyWith(viewedIds: limitedList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void clearFavorites() {
    if (state.user.favoriteIds.isEmpty) return;

    final List<String> newList = [];
    final user = state.user.copyWith(favoriteIds: newList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void clearRecentItems() {
    if (state.user.viewedIds.isEmpty) return;

    final List<String> newList = [];
    final user = state.user.copyWith(viewedIds: newList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void clearMyItems() {
    if (state.user.createdIds.isEmpty) return;

    for (final id in state.user.createdIds) {
      _carRepository.deleteCarById(id);
    }

    final List<String> newList = [];
    final user = state.user.copyWith(createdIds: newList);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void clearAllData() {
    clearFavorites();
    clearMyItems();
    clearRecentItems();
  }

  void updateRegion(String? region) {
    if (region == null || region == state.user.region) return;

    final user = state.user.copyWith(region: region);
    emit(state.copyWith(user: user));

    _appLocalisationsCubit.initLocalisation(region);

    updateUser(user: user);
  }

  Future<void> authUser(String email) async {
    final user = _userRepository.getUserByEmail(email);

    if (user == null) return;

    //todo: if the user was in the guest mode, migrate the favorites and created items to the account;
    await init();
  }

  void logOutUser() {
    emit(state.copyWith(isUserAuthenticated: false));
  }

  void updateUser({required UserEntity user, bool updateCloud = true}) {
    _userRepository.updateUser(user);
    if (updateCloud) _updateCloudUser(user);
  }

  void _updateCloudUser(UserEntity user) {
    _authRepository.updateUser(user);
  }
}
