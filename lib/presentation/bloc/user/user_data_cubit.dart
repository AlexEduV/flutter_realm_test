import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/data_sources/local/base_local_storage.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/geolocator/check_location_service_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/geolocator/open_app_settings_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/check_location_permission_status_use_case.dart';
import 'package:test_futter_project/domain/usecases/permissions/request_location_permission_use_case.dart';
import 'package:test_futter_project/mocks/mock_users.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/utils/auth_session_util.dart';

import '../../../di/injection_container.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/database/delete_car_by_id_use_case.dart';
import '../../../utils/localisation_util.dart';
import '../l10n/app_localisations_cubit.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(
    this._localStorage,
    this._checkLocationServiceStatusUseCase,
    this._openAppSettingsUseCase,
    this._requestLocationPermissionUseCase,
    this._checkLocationPermissionStatusUseCase,
  ) : super(const UserDataState());

  final BaseLocalStorage _localStorage;

  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final CheckLocationServiceStatusUseCase _checkLocationServiceStatusUseCase;

  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final CheckLocationPermissionStatusUseCase _checkLocationPermissionStatusUseCase;

  late UserEntity user;
  final _imagePicker = ImagePicker();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    user = _localStorage.initUser();
    final userSession = await AuthSessionUtil.getUserSession();

    await initLocalisation(user.region);

    checkLastSeenCarExpiration(days: 7);
    final isLocationPermissionGranted = await _checkLocationPermissionStatusUseCase
        .call()
        .isGranted;

    emit(
      state.copyWith(
        isLoading: false,
        favoriteIds: user.favoriteIds,
        createdIds: user.createdIds,
        viewedIds: user.viewedIds,
        isLocationPermissionGranted: isLocationPermissionGranted,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        lastSeenCar: user.lastSeenCar,
        password: user.password,
        region: user.region,
        avatarImageSrc: user.avatarImageSrc,
        isUserAuthenticated: userSession != null,
      ),
    );
  }

  void updateCloudUser(UserEntity user) {
    serviceLocator<AuthRepository>().updateUser(state.email, user);
  }

  Future<void> initLocalisation(String locale) async {
    final localisations = await LocalisationUtil.loadLocalisations(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}localisation_mock_response_data_$locale.json',
    );

    serviceLocator<AppLocalisationsCubit>().load(localisations);

    await initializeDateFormatting(locale, null);
    await LocalisationUtil.saveLocalisations(localisations);
  }

  void setFirstName(String firstName) {
    user = user.copyWith(firstName: firstName);
    emit(state.copyWith(firstName: firstName));

    updateUser(user: user);
  }

  void setLastName(String lastName) {
    user = user.copyWith(lastName: lastName);
    emit(state.copyWith(lastName: lastName));

    updateUser(user: user);
  }

  void setEmail(String email) {
    user = user.copyWith(email: email);
    emit(state.copyWith(email: email));

    updateUser(user: user);
  }

  void setPassword(String password) {
    user = user.copyWith(password: password);
    emit(state.copyWith(password: password));

    updateUser(user: user);
  }

  void setLastSeenCar(String? carId) {
    final newLastSeenCarData = carId == null ? null : {DateTime.now(): carId};

    user = user.copyWith(lastSeenCar: newLastSeenCarData);
    emit(state.copyWith(lastSeenCar: newLastSeenCarData));

    updateUser(user: user);
  }

  void checkLastSeenCarExpiration({required int days}) {
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

    final isServiceEnabled = await _checkLocationServiceStatusUseCase.call();
    if (!isServiceEnabled) {
      await _openAppSettingsUseCase.call();
    }
  }

  Future<void> openLocationSettings() async {
    await _openAppSettingsUseCase.call();
  }

  void updateLocationPermissionStatus(bool newStatus) {
    user = user.copyWith(isLocationPermissionGranted: newStatus);
    emit(state.copyWith(isLocationPermissionGranted: newStatus));

    updateUser(user: user);
  }

  Future<void> updateAvatarImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final src = image.path;

      user = user.copyWith(avatarImageSrc: src);
      emit(state.copyWith(avatarImageSrc: src));

      updateUser(user: user);
    }
  }

  void addCarIdToFavorites(String carId) {
    final newList = user.favoriteIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    user = user.copyWith(favoriteIds: cleanedList);
    emit(state.copyWith(favoriteIds: cleanedList));

    updateUser(user: user);
  }

  void removeCarIdFromFavorites(String carId) {
    final newList = user.favoriteIds.toList()..remove(carId);
    user = user.copyWith(favoriteIds: newList);
    emit(state.copyWith(favoriteIds: newList));

    updateUser(user: user);
  }

  void addCarIdToCreated(String carId) {
    final newList = user.createdIds.toList()..add(carId);
    final cleanedList = newList.toSet().toList();

    user = user.copyWith(createdIds: cleanedList);
    emit(state.copyWith(createdIds: cleanedList));

    updateUser(user: user);
  }

  void removeCarIdFromCreated(String carId) {
    final newList = user.createdIds.toList()..remove(carId);
    user = user.copyWith(createdIds: newList);
    emit(state.copyWith(createdIds: newList));

    updateUser(user: user);

    serviceLocator<DeleteCarByIdUseCase>().call(carId);
  }

  void addCarToRecentlyViewed(String carId) {
    if (carId.isEmpty) return;

    if (user.viewedIds.lastOrNull == carId) return;

    final newList = user.viewedIds.toList()..add(carId);

    final int maxEntriesAllowed = 20;
    final limitedList = newList.length > maxEntriesAllowed
        ? newList.sublist(newList.length - maxEntriesAllowed)
        : newList;

    user = user.copyWith(viewedIds: limitedList);
    emit(state.copyWith(viewedIds: limitedList));

    updateUser(user: user);
  }

  void clearFavorites() {
    if (state.favoriteIds.isEmpty) return;

    final List<String> newList = [];
    user = user.copyWith(favoriteIds: newList);
    emit(state.copyWith(favoriteIds: newList));

    updateUser(user: user);
  }

  void clearRecentItems() {
    if (state.viewedIds.isEmpty) return;

    final List<String> newList = [];
    user = user.copyWith(viewedIds: newList);
    emit(state.copyWith(viewedIds: newList));

    updateUser(user: user);
  }

  void clearMyItems() {
    if (state.createdIds.isEmpty) return;

    for (final id in state.createdIds) {
      serviceLocator<DeleteCarByIdUseCase>().call(id);
    }

    final List<String> newList = [];
    user = user.copyWith(createdIds: newList);
    emit(state.copyWith(createdIds: newList));

    updateUser(user: user);
  }

  void clearAllData() {
    clearFavorites();
    clearMyItems();
    clearMyItems();
  }

  void updateRegion(String? region) {
    if (region == null || region == user.region) return;

    user = user.copyWith(region: region);
    emit(state.copyWith(region: region));

    initLocalisation(region);

    updateUser(user: user);
  }

  Future<void> authUser(String email) async {
    final user = MockUsers.getUserByEmail(email);

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

    //todo: while this does update the user avatar, it's bad architecture
    serviceLocator<InboxPageCubit>().init();
  }
}
