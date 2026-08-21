import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/constants/app_routes.dart';
import 'package:test_flutter_project/common/enums/auth_mode.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/animated_divider_with_text.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../features/authentication/authentication_cubit.dart';
import '../login_page_identifiers.dart';
import 'app_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Column(
          children: [
            AppSemantics(
              label: LoginPageIds.emailTextField,
              textField: true,
              child: AppFormField(
                focusNode: _emailFocusNode,
                textEditingController: _emailTextController,
                labelText: state.emailFieldParams?.label ?? '',
                hintText: state.emailFieldParams?.hintText ?? '',
                textInputType: TextInputType.emailAddress,
                leadingIcon: Icons.email_outlined,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  _passwordFocusNode.requestFocus();
                },
                errorText: state.emailError,
                onChanged: (newValue) {
                  context.read<AuthenticationCubit>().updateEmail(_emailTextController.text);

                  context.read<AuthenticationCubit>().validateEmail(
                    _emailTextController.text,
                    _emailFocusNode.hasFocus,
                  );
                },
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    context.read<AuthenticationCubit>().validateEmail(
                      _emailTextController.text,
                      false,
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            // password textField
            AppSemantics(
              label: LoginPageIds.passwordTextField,
              textField: true,
              child: AppFormField(
                focusNode: _passwordFocusNode,
                textEditingController: _passwordTextController,
                labelText: state.passwordFieldParams?.label ?? '',
                hintText: state.passwordFieldParams?.hintText ?? '',
                textInputType: TextInputType.visiblePassword,
                leadingIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                isObscureText: state.isPasswordFieldObscure,
                onSuffixIconPressed: () {
                  context.read<AuthenticationCubit>().setObscurePassword(
                    !state.isPasswordFieldObscure,
                  );
                },
                errorText: state.passwordError,
                onChanged: (newValue) {
                  context.read<AuthenticationCubit>().updatePassword(_passwordTextController.text);

                  context.read<AuthenticationCubit>().validatePassword(
                    _passwordTextController.text,
                    _passwordFocusNode.hasFocus,
                  );
                },
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    context.read<AuthenticationCubit>().validatePassword(
                      _passwordTextController.text,
                      false,
                    );
                  }
                },
                maxLength: state.passwordFieldParams?.maxLength,
                trailingActionSemanticsLabel: LoginPageIds.obscurePasswordButton,
              ),
            ),

            //forgot password button
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.minorS,
                right: AppDimensions.normalM,
              ),
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: AppSemantics(
                  label: LoginPageIds.forgotPasswordButton,
                  button: true,
                  child: GestureDetector(
                    child: Text(
                      context.tr(LoginPageLocaleKeys.forgotPasswordButtonTitle),
                      style: AppTextStyles.zonaPro16.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.headerColor,
                      ),
                    ),
                    onTap: () => context.go(AppRoutes.home + AppRoutes.forgotPassword),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // login button
            AppSemantics(
              button: true,
              label: LoginPageIds.loginButton,
              child: SplashButton(
                title: context.tr(LoginPageLocaleKeys.loginButtonTitle),
                onPressed: () {
                  if (state.isLoading) {
                    return;
                  }

                  _emailFocusNode.unfocus();
                  _passwordFocusNode.unfocus();

                  context.read<AuthenticationCubit>().onLoginButtonPressed();
                },
                buttonType: ButtonType.primary,
                isLoading: state.isLoading,
              ),
            ),

            //Or Divider
            AppSemantics(
              label: LoginPageIds.orDivider,
              child: AnimatedDividerWithText(text: context.tr(LoginPageLocaleKeys.orDividerTitle)),
            ),

            // join us button if not registered
            AppSemantics(
              label: context.tr(LoginPageLocaleKeys.signUpButtonTitle),
              button: true,
              child: SplashButton(
                title: context.tr(LoginPageLocaleKeys.signUpButtonTitle),
                onPressed: () =>
                    context.read<AuthenticationCubit>().setNewFormMode(AuthMode.register),
                buttonType: ButtonType.secondary,
              ),
            ),

            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
