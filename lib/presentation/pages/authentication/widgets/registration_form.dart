import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/splash_button.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../common/app_colors.dart';
import '../../../bloc/authentication/authentication_cubit.dart';
import 'animated_divider_with_text.dart';
import 'login_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    fullNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Column(
          children: [
            LoginField(
              focusNode: fullNameFocusNode,
              textEditingController: fullNameTextController,
              labelText: state.fullNameFieldParams?.label ?? '',
              hintText: state.fullNameFieldParams?.hintText ?? '',
              textInputType: TextInputType.name,
              leadingIcon: Icons.person_outlined,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                emailFocusNode.requestFocus();
              },
              errorText: state.fullNameError,
              onChanged: (newValue) {
                context.read<AuthenticationCubit>().updateFullName(fullNameTextController.text);

                context.read<AuthenticationCubit>().validateFullName(
                  fullNameTextController.text,
                  fullNameFocusNode.hasFocus,
                );
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context.read<AuthenticationCubit>().validateFullName(
                    fullNameTextController.text,
                    false,
                  );
                }
              },
              semanticsLabel: AppSemanticsLabels.fullNameTextField,
            ),

            const SizedBox(height: 20),

            LoginField(
              focusNode: emailFocusNode,
              textEditingController: emailTextController,
              labelText: state.emailFieldParams?.label ?? '',
              hintText: state.emailFieldParams?.hintText ?? '',
              textInputType: TextInputType.emailAddress,
              leadingIcon: Icons.email_outlined,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                passwordFocusNode.requestFocus();
              },
              errorText: state.emailError,
              onChanged: (newValue) {
                context.read<AuthenticationCubit>().updateEmail(emailTextController.text);

                context.read<AuthenticationCubit>().validateEmail(
                  emailTextController.text,
                  emailFocusNode.hasFocus,
                );
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context.read<AuthenticationCubit>().validateEmail(
                    emailTextController.text,
                    false,
                  );
                }
              },
              semanticsLabel: AppSemanticsLabels.emailTextField,
            ),

            const SizedBox(height: 20),

            // password textField
            LoginField(
              focusNode: passwordFocusNode,
              textEditingController: passwordTextController,
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
                context.read<AuthenticationCubit>().updatePassword(passwordTextController.text);

                context.read<AuthenticationCubit>().validatePassword(
                  passwordTextController.text,
                  passwordFocusNode.hasFocus,
                );
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context.read<AuthenticationCubit>().validatePassword(
                    passwordTextController.text,
                    false,
                  );
                }
              },
              semanticsLabel: AppSemanticsLabels.passwordTextField,
              trailingActionSemanticsLabel: AppSemanticsLabels.obscurePasswordButton,
            ),

            const SizedBox(height: 20),

            // Sign up button
            AppSemantics(
              button: true,
              label: AppLocalisations.signUpButtonTitle,
              child: SplashButton(
                title: AppLocalisations.signUpButtonTitle,
                onPressed: () {
                  if (state.isLoading) {
                    return;
                  }

                  emailFocusNode.unfocus();
                  passwordFocusNode.unfocus();
                  fullNameFocusNode.unfocus();

                  context.read<AuthenticationCubit>().onRegisterButtonPressed();
                },
                foregroundColor: Colors.white,
                backgroundColor: AppColors.headerColor,
                isLoading: state.isLoading,
              ),
            ),

            //Or Divider
            AppSemantics(
              label: AppSemanticsLabels.orDivider,
              child: AnimatedDividerWithText(text: AppLocalisations.orDividerTitle),
            ),

            // join us button if not registered
            AppSemantics(
              button: true,
              label: AppSemanticsLabels.loginButton,
              child: SplashButton(
                title: AppLocalisations.loginButtonTitle,
                onPressed: () => context.read<AuthenticationCubit>().setNewFormModeToLogin(true),
                foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
