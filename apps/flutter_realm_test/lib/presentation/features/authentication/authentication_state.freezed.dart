// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationState {
  bool get isPasswordFieldObscure;
  FieldParamsModel? get fullNameFieldParams;
  FieldParamsModel? get emailFieldParams;
  FieldParamsModel? get passwordFieldParams;
  String? get emailError;
  String? get passwordError;
  String? get fullNameError;
  bool get isButtonEnabled;
  String get emailValue;
  String get passwordValue;
  String get fullNameValue;
  bool get isLoading;
  String? get authenticationErrorText;
  bool get isLoginMode;
  int get passwordValidationStage;
  String? get passwordStrengthHintText;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticationStateCopyWith<AuthenticationState> get copyWith =>
      _$AuthenticationStateCopyWithImpl<AuthenticationState>(
          this as AuthenticationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationState &&
            (identical(other.isPasswordFieldObscure, isPasswordFieldObscure) ||
                other.isPasswordFieldObscure == isPasswordFieldObscure) &&
            (identical(other.fullNameFieldParams, fullNameFieldParams) ||
                other.fullNameFieldParams == fullNameFieldParams) &&
            (identical(other.emailFieldParams, emailFieldParams) ||
                other.emailFieldParams == emailFieldParams) &&
            (identical(other.passwordFieldParams, passwordFieldParams) ||
                other.passwordFieldParams == passwordFieldParams) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.fullNameError, fullNameError) ||
                other.fullNameError == fullNameError) &&
            (identical(other.isButtonEnabled, isButtonEnabled) ||
                other.isButtonEnabled == isButtonEnabled) &&
            (identical(other.emailValue, emailValue) ||
                other.emailValue == emailValue) &&
            (identical(other.passwordValue, passwordValue) ||
                other.passwordValue == passwordValue) &&
            (identical(other.fullNameValue, fullNameValue) ||
                other.fullNameValue == fullNameValue) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(
                    other.authenticationErrorText, authenticationErrorText) ||
                other.authenticationErrorText == authenticationErrorText) &&
            (identical(other.isLoginMode, isLoginMode) ||
                other.isLoginMode == isLoginMode) &&
            (identical(
                    other.passwordValidationStage, passwordValidationStage) ||
                other.passwordValidationStage == passwordValidationStage) &&
            (identical(
                    other.passwordStrengthHintText, passwordStrengthHintText) ||
                other.passwordStrengthHintText == passwordStrengthHintText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPasswordFieldObscure,
      fullNameFieldParams,
      emailFieldParams,
      passwordFieldParams,
      emailError,
      passwordError,
      fullNameError,
      isButtonEnabled,
      emailValue,
      passwordValue,
      fullNameValue,
      isLoading,
      authenticationErrorText,
      isLoginMode,
      passwordValidationStage,
      passwordStrengthHintText);

  @override
  String toString() {
    return 'AuthenticationState(isPasswordFieldObscure: $isPasswordFieldObscure, fullNameFieldParams: $fullNameFieldParams, emailFieldParams: $emailFieldParams, passwordFieldParams: $passwordFieldParams, emailError: $emailError, passwordError: $passwordError, fullNameError: $fullNameError, isButtonEnabled: $isButtonEnabled, emailValue: $emailValue, passwordValue: $passwordValue, fullNameValue: $fullNameValue, isLoading: $isLoading, authenticationErrorText: $authenticationErrorText, isLoginMode: $isLoginMode, passwordValidationStage: $passwordValidationStage, passwordStrengthHintText: $passwordStrengthHintText)';
  }
}

/// @nodoc
abstract mixin class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) _then) =
      _$AuthenticationStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isPasswordFieldObscure,
      FieldParamsModel? fullNameFieldParams,
      FieldParamsModel? emailFieldParams,
      FieldParamsModel? passwordFieldParams,
      String? emailError,
      String? passwordError,
      String? fullNameError,
      bool isButtonEnabled,
      String emailValue,
      String passwordValue,
      String fullNameValue,
      bool isLoading,
      String? authenticationErrorText,
      bool isLoginMode,
      int passwordValidationStage,
      String? passwordStrengthHintText});
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._self, this._then);

  final AuthenticationState _self;
  final $Res Function(AuthenticationState) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPasswordFieldObscure = null,
    Object? fullNameFieldParams = freezed,
    Object? emailFieldParams = freezed,
    Object? passwordFieldParams = freezed,
    Object? emailError = freezed,
    Object? passwordError = freezed,
    Object? fullNameError = freezed,
    Object? isButtonEnabled = null,
    Object? emailValue = null,
    Object? passwordValue = null,
    Object? fullNameValue = null,
    Object? isLoading = null,
    Object? authenticationErrorText = freezed,
    Object? isLoginMode = null,
    Object? passwordValidationStage = null,
    Object? passwordStrengthHintText = freezed,
  }) {
    return _then(_self.copyWith(
      isPasswordFieldObscure: null == isPasswordFieldObscure
          ? _self.isPasswordFieldObscure
          : isPasswordFieldObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      fullNameFieldParams: freezed == fullNameFieldParams
          ? _self.fullNameFieldParams
          : fullNameFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      emailFieldParams: freezed == emailFieldParams
          ? _self.emailFieldParams
          : emailFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      passwordFieldParams: freezed == passwordFieldParams
          ? _self.passwordFieldParams
          : passwordFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      emailError: freezed == emailError
          ? _self.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      fullNameError: freezed == fullNameError
          ? _self.fullNameError
          : fullNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      isButtonEnabled: null == isButtonEnabled
          ? _self.isButtonEnabled
          : isButtonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailValue: null == emailValue
          ? _self.emailValue
          : emailValue // ignore: cast_nullable_to_non_nullable
              as String,
      passwordValue: null == passwordValue
          ? _self.passwordValue
          : passwordValue // ignore: cast_nullable_to_non_nullable
              as String,
      fullNameValue: null == fullNameValue
          ? _self.fullNameValue
          : fullNameValue // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      authenticationErrorText: freezed == authenticationErrorText
          ? _self.authenticationErrorText
          : authenticationErrorText // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoginMode: null == isLoginMode
          ? _self.isLoginMode
          : isLoginMode // ignore: cast_nullable_to_non_nullable
              as bool,
      passwordValidationStage: null == passwordValidationStage
          ? _self.passwordValidationStage
          : passwordValidationStage // ignore: cast_nullable_to_non_nullable
              as int,
      passwordStrengthHintText: freezed == passwordStrengthHintText
          ? _self.passwordStrengthHintText
          : passwordStrengthHintText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _AuthenticationState implements AuthenticationState {
  const _AuthenticationState(
      {this.isPasswordFieldObscure = true,
      this.fullNameFieldParams,
      this.emailFieldParams,
      this.passwordFieldParams,
      this.emailError,
      this.passwordError,
      this.fullNameError,
      this.isButtonEnabled = false,
      this.emailValue = '',
      this.passwordValue = '',
      this.fullNameValue = '',
      this.isLoading = false,
      this.authenticationErrorText,
      this.isLoginMode = true,
      this.passwordValidationStage = 0,
      this.passwordStrengthHintText});

  @override
  @JsonKey()
  final bool isPasswordFieldObscure;
  @override
  final FieldParamsModel? fullNameFieldParams;
  @override
  final FieldParamsModel? emailFieldParams;
  @override
  final FieldParamsModel? passwordFieldParams;
  @override
  final String? emailError;
  @override
  final String? passwordError;
  @override
  final String? fullNameError;
  @override
  @JsonKey()
  final bool isButtonEnabled;
  @override
  @JsonKey()
  final String emailValue;
  @override
  @JsonKey()
  final String passwordValue;
  @override
  @JsonKey()
  final String fullNameValue;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? authenticationErrorText;
  @override
  @JsonKey()
  final bool isLoginMode;
  @override
  @JsonKey()
  final int passwordValidationStage;
  @override
  final String? passwordStrengthHintText;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticationStateCopyWith<_AuthenticationState> get copyWith =>
      __$AuthenticationStateCopyWithImpl<_AuthenticationState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticationState &&
            (identical(other.isPasswordFieldObscure, isPasswordFieldObscure) ||
                other.isPasswordFieldObscure == isPasswordFieldObscure) &&
            (identical(other.fullNameFieldParams, fullNameFieldParams) ||
                other.fullNameFieldParams == fullNameFieldParams) &&
            (identical(other.emailFieldParams, emailFieldParams) ||
                other.emailFieldParams == emailFieldParams) &&
            (identical(other.passwordFieldParams, passwordFieldParams) ||
                other.passwordFieldParams == passwordFieldParams) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.fullNameError, fullNameError) ||
                other.fullNameError == fullNameError) &&
            (identical(other.isButtonEnabled, isButtonEnabled) ||
                other.isButtonEnabled == isButtonEnabled) &&
            (identical(other.emailValue, emailValue) ||
                other.emailValue == emailValue) &&
            (identical(other.passwordValue, passwordValue) ||
                other.passwordValue == passwordValue) &&
            (identical(other.fullNameValue, fullNameValue) ||
                other.fullNameValue == fullNameValue) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(
                    other.authenticationErrorText, authenticationErrorText) ||
                other.authenticationErrorText == authenticationErrorText) &&
            (identical(other.isLoginMode, isLoginMode) ||
                other.isLoginMode == isLoginMode) &&
            (identical(
                    other.passwordValidationStage, passwordValidationStage) ||
                other.passwordValidationStage == passwordValidationStage) &&
            (identical(
                    other.passwordStrengthHintText, passwordStrengthHintText) ||
                other.passwordStrengthHintText == passwordStrengthHintText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPasswordFieldObscure,
      fullNameFieldParams,
      emailFieldParams,
      passwordFieldParams,
      emailError,
      passwordError,
      fullNameError,
      isButtonEnabled,
      emailValue,
      passwordValue,
      fullNameValue,
      isLoading,
      authenticationErrorText,
      isLoginMode,
      passwordValidationStage,
      passwordStrengthHintText);

  @override
  String toString() {
    return 'AuthenticationState(isPasswordFieldObscure: $isPasswordFieldObscure, fullNameFieldParams: $fullNameFieldParams, emailFieldParams: $emailFieldParams, passwordFieldParams: $passwordFieldParams, emailError: $emailError, passwordError: $passwordError, fullNameError: $fullNameError, isButtonEnabled: $isButtonEnabled, emailValue: $emailValue, passwordValue: $passwordValue, fullNameValue: $fullNameValue, isLoading: $isLoading, authenticationErrorText: $authenticationErrorText, isLoginMode: $isLoginMode, passwordValidationStage: $passwordValidationStage, passwordStrengthHintText: $passwordStrengthHintText)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticationStateCopyWith<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticationStateCopyWith(_AuthenticationState value,
          $Res Function(_AuthenticationState) _then) =
      __$AuthenticationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isPasswordFieldObscure,
      FieldParamsModel? fullNameFieldParams,
      FieldParamsModel? emailFieldParams,
      FieldParamsModel? passwordFieldParams,
      String? emailError,
      String? passwordError,
      String? fullNameError,
      bool isButtonEnabled,
      String emailValue,
      String passwordValue,
      String fullNameValue,
      bool isLoading,
      String? authenticationErrorText,
      bool isLoginMode,
      int passwordValidationStage,
      String? passwordStrengthHintText});
}

/// @nodoc
class __$AuthenticationStateCopyWithImpl<$Res>
    implements _$AuthenticationStateCopyWith<$Res> {
  __$AuthenticationStateCopyWithImpl(this._self, this._then);

  final _AuthenticationState _self;
  final $Res Function(_AuthenticationState) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isPasswordFieldObscure = null,
    Object? fullNameFieldParams = freezed,
    Object? emailFieldParams = freezed,
    Object? passwordFieldParams = freezed,
    Object? emailError = freezed,
    Object? passwordError = freezed,
    Object? fullNameError = freezed,
    Object? isButtonEnabled = null,
    Object? emailValue = null,
    Object? passwordValue = null,
    Object? fullNameValue = null,
    Object? isLoading = null,
    Object? authenticationErrorText = freezed,
    Object? isLoginMode = null,
    Object? passwordValidationStage = null,
    Object? passwordStrengthHintText = freezed,
  }) {
    return _then(_AuthenticationState(
      isPasswordFieldObscure: null == isPasswordFieldObscure
          ? _self.isPasswordFieldObscure
          : isPasswordFieldObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      fullNameFieldParams: freezed == fullNameFieldParams
          ? _self.fullNameFieldParams
          : fullNameFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      emailFieldParams: freezed == emailFieldParams
          ? _self.emailFieldParams
          : emailFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      passwordFieldParams: freezed == passwordFieldParams
          ? _self.passwordFieldParams
          : passwordFieldParams // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      emailError: freezed == emailError
          ? _self.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: freezed == passwordError
          ? _self.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as String?,
      fullNameError: freezed == fullNameError
          ? _self.fullNameError
          : fullNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      isButtonEnabled: null == isButtonEnabled
          ? _self.isButtonEnabled
          : isButtonEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailValue: null == emailValue
          ? _self.emailValue
          : emailValue // ignore: cast_nullable_to_non_nullable
              as String,
      passwordValue: null == passwordValue
          ? _self.passwordValue
          : passwordValue // ignore: cast_nullable_to_non_nullable
              as String,
      fullNameValue: null == fullNameValue
          ? _self.fullNameValue
          : fullNameValue // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      authenticationErrorText: freezed == authenticationErrorText
          ? _self.authenticationErrorText
          : authenticationErrorText // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoginMode: null == isLoginMode
          ? _self.isLoginMode
          : isLoginMode // ignore: cast_nullable_to_non_nullable
              as bool,
      passwordValidationStage: null == passwordValidationStage
          ? _self.passwordValidationStage
          : passwordValidationStage // ignore: cast_nullable_to_non_nullable
              as int,
      passwordStrengthHintText: freezed == passwordStrengthHintText
          ? _self.passwordStrengthHintText
          : passwordStrengthHintText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
