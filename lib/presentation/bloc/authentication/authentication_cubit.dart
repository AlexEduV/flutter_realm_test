import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void setObscurePassword(bool newState) {
    emit(state.copyWith(isPasswordFieldObscure: newState));
  }
}
