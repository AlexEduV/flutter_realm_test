import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool isPasswordFieldObscure,
    FieldParamsModel? emailFieldParams,
    FieldParamsModel? passwordFieldParams,
    String? emailError,
    String? passwordError,
    @Default(false) bool isButtonEnabled,
  }) = _AuthenticationState;
}
