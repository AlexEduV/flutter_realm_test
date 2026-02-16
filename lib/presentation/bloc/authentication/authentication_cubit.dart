import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/domain/models/login_model.dart';
import 'package:test_futter_project/domain/models/register_model.dart';
import 'package:test_futter_project/domain/usecases/authentication/login_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/logout_use_case.dart';
import 'package:test_futter_project/domain/usecases/authentication/register_use_case.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/utils/l10n.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void init() {
    emit(
      state.copyWith(
        emailFieldParams: FieldParamsModel.withLabel(AppLocalisations.fieldParamsEmailLabel)
            .copyWith(
              regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
              regexErrorMessage: AppLocalisations.fieldParamsEmailRegexErrorMessage,
              validationMessage: AppLocalisations.fieldParamsValidationMessage,
              hintText: AppLocalisations.fieldParamsEmailHintText,
            ),
        passwordFieldParams: FieldParamsModel.withLabel(AppLocalisations.fieldParamsPasswordLabel)
            .copyWith(
              minLength: 8,
              maxLength: 20,
              validationMessage: AppLocalisations.fieldParamsValidationMessage,
              //todo:
              regex: r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
              regexErrorMessage: AppLocalisations.fieldParamsPasswordRegexErrorMessage,
              hintText: AppLocalisations.fieldParamsPasswordHintText,
            ),
        fullNameFieldParams: FieldParamsModel.withLabel(AppLocalisations.fieldParamsFullNameLabel)
            .copyWith(
              regex: r"^[A-Za-zÀ-ÖØ-öø-ÿ' -]{2,}$",
              validationMessage: AppLocalisations.fieldParamsValidationMessage,
              regexErrorMessage: AppLocalisations.fieldParamsFullNameRegexErrorMessage,
              hintText: AppLocalisations.fieldParamsFullNameHintText,
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

  //todo: add localisations
  bool validatePasswordWithStrengthBar(String password) {
    final minLength = state.passwordFieldParams?.minLength ?? 0;
    if (password.length < minLength) {
      emit(
        state.copyWith(
          passwordValidationStage: 0,
          passwordStrengthHintText: 'The minimum password length is $minLength',
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 1,
          passwordStrengthHintText: 'The password should contain at least one lower case character',
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 2,
          passwordStrengthHintText: 'The password should contain at least one upper case character',
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'\d'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 3,
          passwordStrengthHintText: 'The password should contain at least one digit',
        ),
      );
      return false;
    }

    const specialChars = '!@#\$&*~';
    if (!password.split('').any((char) => specialChars.contains(char))) {
      emit(
        state.copyWith(
          passwordValidationStage: 4,
          passwordStrengthHintText: 'The password should contain at least one special character',
        ),
      );
      return false;
    }

    emit(state.copyWith(passwordValidationStage: 5, passwordStrengthHintText: null));
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
    final result = await serviceLocator<LoginUseCase>().call(
      LoginModel(state.emailValue, state.passwordValue),
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

    validatePasswordWithStrengthBar(state.passwordValue);
    validateEmail(state.emailValue, false);
    validateFullName(state.fullNameValue, false);

    if (state.emailError != null ||
        state.passwordError != null ||
        state.fullNameError != null ||
        state.passwordStrengthHintText != null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await serviceLocator<RegisterUseCase>().call(
      RegisterModel(state.emailValue, state.passwordValue, state.fullNameValue),
    );

    if (!result.success) {
      emit(state.copyWith(authenticationErrorText: result.message));
    } else {
      serviceLocator<UserDataCubit>().authUser(state.emailValue);
    }

    emit(state.copyWith(isLoading: false));
  }

  void setNewFormModeToLogin(bool newValue) {
    emit(
      state.copyWith(
        isLoginMode: newValue,
        fullNameError: null,
        emailError: null,
        passwordError: null,
        passwordValue: '',
        fullNameValue: '',
        emailValue: '',
        authenticationErrorText: null,
        passwordStrengthHintText: null,
        passwordValidationStage: 0,
      ),
    );
  }

  void logOut() {
    serviceLocator<LogoutUseCase>().call();
    emit(state.copyWith(isLoginMode: true));
  }
}
