import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/models/auth_error_code.dart';
import 'package:test_flutter_project/domain/models/auth_result.dart';
import 'package:test_flutter_project/domain/models/field_params_model.dart';
import 'package:test_flutter_project/domain/models/login_model.dart';
import 'package:test_flutter_project/domain/models/register_model.dart';
import 'package:test_flutter_project/domain/usecases/authentication/delete_account_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/login_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/logout_use_case.dart';
import 'package:test_flutter_project/domain/usecases/authentication/register_use_case.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';

import '../l10n/app_localisations_cubit.dart';
import 'login_page_identifiers.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this._appLocalisationsCubit,
    this._userDataCubit,
    this._loginUseCase,
    this._logoutUseCase,
    this._registerUseCase,
    this._deleteAccountUseCase,
  ) : super(const AuthenticationState());

  final AppLocalisationsCubit _appLocalisationsCubit;
  final UserDataCubit _userDataCubit;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  void init() {
    emit(
      state.copyWith(
        emailFieldParams:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsEmailLabel),
            ).copyWith(
              regex: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
              regexErrorMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsEmailRegexErrorMessage,
              ),
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              hintText: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsEmailHintText,
              ),
            ),
        passwordFieldParams:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsPasswordLabel),
            ).copyWith(
              minLength: 8,
              maxLength: 20,
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regex: r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
              regexErrorMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsPasswordRegexErrorMessage,
              ),
              hintText: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsPasswordHintText,
              ),
            ),
        fullNameFieldParams:
            FieldParamsModel.withLabel(
              _appLocalisationsCubit.getLocalisationByKey(L10nKeys.fieldParamsFullNameLabel),
            ).copyWith(
              regex: r"^[A-Za-zÀ-ÖØ-öø-ÿ' -]{2,}$",
              validationMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsValidationMessage,
              ),
              regexErrorMessage: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsFullNameRegexErrorMessage,
              ),
              hintText: _appLocalisationsCubit.getLocalisationByKey(
                L10nKeys.fieldParamsFullNameHintText,
              ),
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

  bool validatePasswordWithStrengthBar(String password) {
    final minLength = state.passwordFieldParams?.minLength ?? 0;
    if (password.length < minLength) {
      emit(
        state.copyWith(
          passwordValidationStage: 0,
          passwordStrengthHintText:
              '${_appLocalisationsCubit.getLocalisationByKey(LoginPageIds.authPasswordStrengthLengthHint)} $minLength',
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 1,
          passwordStrengthHintText: _appLocalisationsCubit.getLocalisationByKey(
            LoginPageIds.authPasswordStrengthLowercaseHint,
          ),
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 2,
          passwordStrengthHintText: _appLocalisationsCubit.getLocalisationByKey(
            LoginPageIds.authPasswordStrengthUppercaseHint,
          ),
        ),
      );
      return false;
    }

    if (!password.contains(RegExp(r'\d'))) {
      emit(
        state.copyWith(
          passwordValidationStage: 3,
          passwordStrengthHintText: _appLocalisationsCubit.getLocalisationByKey(
            LoginPageIds.authPasswordStrengthDigitHint,
          ),
        ),
      );
      return false;
    }

    const specialChars = '!@#\$&*~';
    if (!password.split('').any((char) => specialChars.contains(char))) {
      emit(
        state.copyWith(
          passwordValidationStage: 4,
          passwordStrengthHintText: _appLocalisationsCubit.getLocalisationByKey(
            LoginPageIds.authPasswordStrengthSpecialCharacterHint,
          ),
        ),
      );
      return false;
    }

    emit(state.copyWith(passwordValidationStage: 5, passwordStrengthHintText: null));
    return true;
  }

  String? _localizeAuthError(AuthErrorCode code) => switch (code) {
    AuthErrorCode.userNotFound => _appLocalisationsCubit.getLocalisationByKey(
      LoginPageIds.authErrorUserNotFoundMessage,
    ),
    AuthErrorCode.incorrectPassword => _appLocalisationsCubit.getLocalisationByKey(
      LoginPageIds.authErrorIncorrectPassword,
    ),
    AuthErrorCode.userAlreadyExists => _appLocalisationsCubit.getLocalisationByKey(
      LoginPageIds.authErrorUserAlreadyExists,
    ),
  };

  void onLoginButtonPressed() async {
    emit(state.copyWith(authenticationErrorText: null));

    validatePassword(state.passwordValue, false);
    validateEmail(state.emailValue, false);

    if (state.emailError != null || state.passwordError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await _loginUseCase.call(LoginModel(state.emailValue, state.passwordValue));

    switch (result) {
      case AuthSuccess():
        await _userDataCubit.authUser(state.emailValue);
      case AuthFailure(:final errorCode):
        emit(state.copyWith(authenticationErrorText: _localizeAuthError(errorCode)));
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

    List<String> parts = state.fullNameValue.trim().split(' ');

    // Get first and last name
    String firstName = parts.isNotEmpty ? parts.first : '';
    String lastName = parts.length > 1 ? parts.last : '';

    final result = await _registerUseCase.call(
      RegisterModel(state.emailValue, state.passwordValue, firstName, lastName),
    );

    switch (result) {
      case AuthSuccess():
        await _userDataCubit.authUser(state.emailValue);
      case AuthFailure(:final errorCode):
        emit(state.copyWith(authenticationErrorText: _localizeAuthError(errorCode)));
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

  Future<void> logOut() async {
    await _logoutUseCase.call();
    emit(state.copyWith(isLoginMode: true));
  }

  Future<void> deleteAccount(String email) async {
    await _deleteAccountUseCase.call(email);
    emit(state.copyWith(isLoginMode: true));
  }
}
