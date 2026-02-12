import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/login_field.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your action here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.normalM,
                      ), // Button height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.normalS,
                        ), // Optional rounded corners
                      ),
                      backgroundColor: AppColors.headerColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Log in',
                      style: AppTextStyles.zonaPro16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              //Or Divider
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.normalM,
                  horizontal: AppDimensions.normalM,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Or')),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              // join us button if not registered
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your action here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.normalM,
                      ), // Button height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.normalS,
                        ), // Optional rounded corners
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Sign up',
                      style: AppTextStyles.zonaPro16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
