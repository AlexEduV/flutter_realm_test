import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/animated_florentine_divider_with_text.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/password_strength_bar_widget.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/splash_button.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../../bloc/authentication/authentication_cubit.dart';
import 'app_form_field.dart';

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
            AppFormField(
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
            ),

            const SizedBox(height: 20),

            AppFormField(
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
            ),

            const SizedBox(height: 20),

            // password textField
            AppFormField(
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

                context.read<AuthenticationCubit>().validatePasswordWithStrengthBar(
                  passwordTextController.text,
                );
              },
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context.read<AuthenticationCubit>().validatePasswordWithStrengthBar(
                    passwordTextController.text,
                  );
                }
              },
              maxLength: state.passwordFieldParams?.maxLength,
              trailingActionSemanticsLabel: AppSemanticsLabels.obscurePasswordButton,
            ),

            const PasswordStrengthBarWidget(),

            //todo: add password confirmation field as well
            const SizedBox(height: 20),

            // Sign up button
            AppSemantics(
              button: true,
              label: context.tr(L10nKeys.signUpButtonTitle),
              child: SplashButton(
                title: context.tr(L10nKeys.signUpButtonTitle),
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
              child: AnimatedTiledDivider(
                text: context.tr(L10nKeys.orDividerTitle),
                ornamentAsset: 'assets/images/divider_samples/florence-2.jpg',
              ),
            ),

            // join us button if not registered
            AppSemantics(
              button: true,
              label: AppSemanticsLabels.loginButton,
              child: SplashButton(
                title: context.tr(L10nKeys.loginButtonTitle),
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
