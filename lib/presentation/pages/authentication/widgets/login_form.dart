import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/animated_divider_with_text.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/splash_button.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../bloc/authentication/authentication_cubit.dart';
import 'login_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

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
            ),

            //forgot password button
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.minorS,
                right: AppDimensions.normalM,
              ),
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: GestureDetector(
                  child: Text(
                    AppLocalisations.forgotPasswordButtonTitle,
                    style: AppTextStyles.zonaPro16.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.headerColor,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),

            const SizedBox(height: 20),

            // login button
            SplashButton(
              title: AppLocalisations.loginButtonTitle,
              onPressed: () {
                if (state.isLoading) {
                  return;
                }

                emailFocusNode.unfocus();
                passwordFocusNode.unfocus();

                context.read<AuthenticationCubit>().onLoginButtonPressed();
              },
              foregroundColor: Colors.white,
              backgroundColor: AppColors.headerColor,
              isLoading: state.isLoading,
            ),

            //Or Divider
            AnimatedDividerWithText(text: AppLocalisations.orDividerTitle),

            // join us button if not registered
            SplashButton(
              title: AppLocalisations.signUpButtonTitle,
              onPressed: () => context.read<AuthenticationCubit>().setNewFormModeToLogin(false),
              foregroundColor: Colors.grey,
              backgroundColor: Colors.white,
            ),

            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
