import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool isPasswordFieldObscure,
    FieldParamsModel? fullNameFieldParams,
    FieldParamsModel? emailFieldParams,
    FieldParamsModel? passwordFieldParams,
    String? emailError,
    String? passwordError,
    String? fullNameError,
    @Default(false) bool isButtonEnabled,
    @Default('') String emailValue,
    @Default('') String passwordValue,
    @Default('') String fullNameValue,
    @Default(false) bool isLoading,
    @Default(null) String? authenticationErrorText,
    @Default(true) bool isLoginMode,
  }) = _AuthenticationState;
}
