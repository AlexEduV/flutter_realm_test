import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({@Default(false) bool isPasswordFieldObscure}) =
      _AuthenticationState;
}
