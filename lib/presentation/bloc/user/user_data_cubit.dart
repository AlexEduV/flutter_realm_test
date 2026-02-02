import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(const UserDataState());

  void init() {
    //get initial data from local storage
  }
}
