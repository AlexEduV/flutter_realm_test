import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/login_field.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/splash_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                // todo: add a background with cars or something, and a separate pages for registration and forgot password.
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: AppDimensions.normalXL, top: 200),
                  child: Text('Welcome \nBack', style: AppTextStyles.zonaPro30),
                ),
              ),

              // email textField
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
                  emailFocusNode.unfocus();
                  passwordFocusNode.unfocus();

                  context.read<AuthenticationCubit>().onLoginButtonPressed();
                },
                foregroundColor: Colors.white,
                backgroundColor: AppColors.headerColor,
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
                onPressed: () {},
                foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
