import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';

import '../../../domain/repositories/auth_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void init() {
    emit(
      state.copyWith(
        emailFieldParams: FieldParamsModel.withLabel('Email').copyWith(
          regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
          regexErrorMessage: 'The email is not valid.',
          validationMessage: 'This field is required',
        ),
        passwordFieldParams: FieldParamsModel.withLabel('Password').copyWith(
          minLength: '8',
          maxLength: '20',
          validationMessage: 'This field is required',
          regex: r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
          regexErrorMessage: 'The password is not valid.',
        ),
      ),
    );
  }

  void setObscurePassword(bool newState) {
    emit(state.copyWith(isPasswordFieldObscure: newState));
  }

  void updateEmail(String newValue) {
    emit(state.copyWith(emailValue: newValue));
  }

  void updatePassword(String newValue) {
    emit(state.copyWith(passwordValue: newValue));
  }

  bool validateEmail(String email, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(emailError: null));
      return true;
    }

    if (email.isEmpty) {
      emit(state.copyWith(emailError: state.emailFieldParams?.validationMessage));
      return false;
    }

    final emailRegex = RegExp(state.emailFieldParams?.regex ?? '');
    if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(emailError: state.emailFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(emailError: null));
    return true;
  }

  bool validatePassword(String password, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(passwordError: null));
      return true;
    }

    if (password.isEmpty) {
      emit(state.copyWith(passwordError: state.passwordFieldParams?.validationMessage));
      return false;
    }

    final passwordRegex = RegExp(state.passwordFieldParams?.regex ?? '');
    if (!passwordRegex.hasMatch(password)) {
      emit(state.copyWith(passwordError: state.passwordFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(emailError: null));
    return true;
  }

  void onLoginButtonPressed() async {
    validatePassword(state.passwordValue, false);
    validateEmail(state.emailValue, false);

    if (state.emailError != null || state.passwordError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await serviceLocator<AuthRepository>().login(
      state.emailValue,
      state.passwordValue,
    );
    emit(state.copyWith(isLoading: false));
  }
}
