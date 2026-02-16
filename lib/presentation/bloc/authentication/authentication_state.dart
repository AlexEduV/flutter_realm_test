import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(true) bool isPasswordFieldObscure,
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
    String? authenticationErrorText,
    @Default(true) bool isLoginMode,
    @Default(0) int passwordValidationStage,
    String? passwordStrengthHintText,
  }) = _AuthenticationState;
}
