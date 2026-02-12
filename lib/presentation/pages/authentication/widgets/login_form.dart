import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/splash_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../bloc/authentication/authentication_cubit.dart';
import 'login_field.dart';

class LoginForm extends StatelessWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  const LoginForm({
    required this.emailTextController,
    required this.passwordTextController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Column(
          children: [
            LoginField(
              focusNode: emailFocusNode,
              textEditingController: emailTextController,
              labelText: 'Email',
              hintText: 'Enter your email',
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
              labelText: 'Password',
              hintText: 'Enter your password',
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
                    'Forgot Password?',
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
              title: 'Log in',
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
            const Padding(
              padding: EdgeInsets.all(AppDimensions.normalM),
              child: Row(
                children: <Widget>[
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Or')),
                  Expanded(child: Divider()),
                ],
              ),
            ),

            // join us button if not registered
            SplashButton(
              title: 'Sign up',
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
