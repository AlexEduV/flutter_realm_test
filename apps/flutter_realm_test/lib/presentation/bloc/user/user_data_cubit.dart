import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter_project/common/constants/app_asset_routes.dart';
import 'package:test_flutter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_flutter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_flutter_project/domain/entities/last_seen_car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_flutter_project/domain/usecases/image_picker/pick_image_from_gallery_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_flutter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_email_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/database/delete_car_by_id_use_case.dart';
import '../../../utils/localisation_util.dart';
import '../../features/l10n/app_localisations_cubit.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(
    this._localStorage,
    this._authRepository,
    this._checkLocationServiceStatusUseCase,
    this._openAppSettingsUseCase,
    this._requestLocationPermissionUseCase,
    this._checkLocationPermissionStatusUseCase,
    this._getUserByEmailUseCase,
    this._pickImageFromGalleryUseCase,
    this._deleteCarByIdUseCase,
    this._logger,
    this._appLocalisationsCubit,
  ) : super(UserDataState(user: UserEntity.empty()));

  final BaseLocalStorage _localStorage;
  final AuthRepository _authRepository;

  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final CheckLocationServiceStatusUseCase _checkLocationServiceStatusUseCase;
  final PickImageFromGalleryUseCase _pickImageFromGalleryUseCase;

  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;

  final GetUserByEmailUseCase _getUserByEmailUseCase;
  final DeleteCarByIdUseCase _deleteCarByIdUseCase;

  final LoggingService _logger;
  final AppLocalisationsCubit _appLocalisationsCubit;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    final user = _localStorage.initUser();
    final isUserLoggedIn = await _authRepository.isUserLoggedIn();

    await initLocalisation(user.region);

    checkLastSeenCarExpiration(days: 7);
    final isLocationPermissionGranted = await checkLocationPermissionStatus().isGranted;

    final updatedUser = user.copyWith(isLocationPermissionGranted: isLocationPermissionGranted);

    emit(state.copyWith(user: updatedUser, isLoading: false, isUserAuthenticated: isUserLoggedIn));
  }

  void updateCloudUser(UserEntity user) {
    _authRepository.updateUser(user.userId, user);
  }

  Future<PermissionStatus> checkLocationPermissionStatus() {
    return _checkLocationPermissionStatusUseCase.call();
  }

  Future<void> initLocalisation(String locale) async {
    final rawJson = await LocalisationUtil.loadRawJson(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}localisation_mock_response_data_$locale.json',
    );

    final localisations = LocalisationUtil.extractLocalisations(rawJson);
    if (localisations == null) return;

    _appLocalisationsCubit.load(localisations);

    await initializeDateFormatting(locale, null);
    await LocalisationUtil.saveLocalisations(localisations);
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
        : LastSeenCarEntity(carId: carId, seenAt: DateTime.now());

    final user = state.user.copyWith(lastSeenCar: newLastSeenCar);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  void checkLastSeenCarExpiration({required int days}) {
    final lastSeenCar = state.user.lastSeenCar;

    if (lastSeenCar == null) return;

    final daysAgo = DateTime.now().subtract(Duration(days: days));
    if (lastSeenCar.seenAt.isBefore(daysAgo)) {
      setLastSeenCar(null);
    }
  }

  Future<void> requestLocationPermission() async {
    final isGranted = await _requestLocationPermissionUseCase.call();

    if (!isGranted) {
      return;
    }

    updateLocationPermissionStatus(isGranted);

    final isServiceEnabled = await _checkLocationServiceStatusUseCase.call();
    if (!isServiceEnabled) {
      await _openAppSettingsUseCase.call();
    }
  }

  Future<void> openLocationSettings() async {
    final canLocationSettingsBeOpened = await _openAppSettingsUseCase.call();
    if (!canLocationSettingsBeOpened) {
      _logger.error('Could not open system location settings');
    }
  }

  void updateLocationPermissionStatus(bool newStatus) {
    final user = state.user.copyWith(isLocationPermissionGranted: newStatus);
    emit(state.copyWith(user: user));

    updateUser(user: user);
  }

  Future<void> updateAvatarImage() async {
    final path = await _pickImageFromGalleryUseCase.call();
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

    _deleteCarByIdUseCase.call(carId);
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
      _deleteCarByIdUseCase.call(id);
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

    initLocalisation(region);

    updateUser(user: user);
  }

  Future<void> authUser(String email) async {
    final user = _getUserByEmailUseCase.call(email);

    if (user == null) return;

    //todo: if the user was in the guest mode, migrate the favorites and created items to the account;
    await init();
  }

  void logOutUser() {
    emit(state.copyWith(isUserAuthenticated: false));
  }

  void updateUser({required UserEntity user, bool updateCloud = true}) {
    _localStorage.update(UserExtensions.fromEntity(user));
    updateCloudUser(user);
  }
}
