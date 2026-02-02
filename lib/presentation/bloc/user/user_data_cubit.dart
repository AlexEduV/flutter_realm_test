import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/user_scheme_extension.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._localStorage) : super(const UserDataState());

  final BaseLocalStorage _localStorage;

  late UserEntity _user;

  void init() {
    _user = _localStorage.initUser();
  }

  void updateLocationPermissionStatus(bool newStatus) {
    _user = _user.copyWith(isLocationPermissionGranted: newStatus);
    _localStorage.update(UserExtensions.fromEntity(_user));

    emit(state.copyWith(isLocationPermissionGranted: newStatus));
  }
}
