import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._localStorage) : super(const UserDataState());

  final BaseLocalStorage _localStorage;

  void init() {
    _localStorage.initUser();
  }
}
