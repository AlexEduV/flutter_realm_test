import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';

import '../../../domain/repositories/auth_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void init() {
    emit(
      state.copyWith(
        emailFieldParams: FieldParamsModel.withLabel('Email').copyWith(
          regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
          regexErrorMessage: 'The email is not valid.',
          validationMessage: 'This field is required.',
        ),
        passwordFieldParams: FieldParamsModel.withLabel('Password').copyWith(
          minLength: '8',
          maxLength: '20',
          validationMessage: 'This field is required.',
          regex: r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
          regexErrorMessage: 'The password is not valid.',
        ),
        fullNameFieldParams: FieldParamsModel.withLabel('Full Name').copyWith(
          regex: r"^[A-Za-zÀ-ÖØ-öø-ÿ' -]{2,}$",
          validationMessage: 'This field is required.',
          regexErrorMessage: 'The Name is not valid.',
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

  void updateFullName(String newValue) {
    emit(state.copyWith(fullNameValue: newValue));
  }

  bool validateFullName(String fullName, bool isEditing) {
    if (isEditing) {
      emit(state.copyWith(fullNameError: null));
      return true;
    }

    if (fullName.isEmpty) {
      emit(state.copyWith(fullNameError: state.fullNameFieldParams?.validationMessage));
      return false;
    }

    final emailRegex = RegExp(state.fullNameFieldParams?.regex ?? '');
    if (!emailRegex.hasMatch(fullName)) {
      emit(state.copyWith(fullNameError: state.fullNameFieldParams?.regexErrorMessage));
      return false;
    }

    emit(state.copyWith(fullNameError: null));
    return true;
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
    emit(state.copyWith(authenticationErrorText: null));

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

    if (!result.success) {
      emit(state.copyWith(authenticationErrorText: result.message));
    } else {
      serviceLocator<UserDataCubit>().authUser(state.emailValue);
    }

    emit(state.copyWith(isLoading: false));
  }

  void onRegisterButtonPressed() async {
    emit(state.copyWith(authenticationErrorText: null));

    validatePassword(state.passwordValue, false);
    validateEmail(state.emailValue, false);
    validateFullName(state.fullNameValue, false);

    if (state.emailError != null || state.passwordError != null || state.fullNameError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await serviceLocator<AuthRepository>().register(
      state.emailValue,
      state.passwordValue,
      state.fullNameValue,
    );

    if (!result.success) {
      emit(state.copyWith(authenticationErrorText: result.message));
    } else {
      serviceLocator<UserDataCubit>().authUser(state.emailValue);
    }

    emit(state.copyWith(isLoading: false));
  }

  void setNewFormModeToLogin(bool newValue) {
    emit(state.copyWith(isLoginMode: newValue));
  }

  void logOut() {
    serviceLocator<AuthRepository>().logOut();
  }
}
