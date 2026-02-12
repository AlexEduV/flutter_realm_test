import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/login_form.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/registration_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final welcomeText = state.isLoginMode ? 'Welcome \nBack' : 'Join us';

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // todo: add a background with cars or something, and a separate pages for registration and forgot password.
                child: Padding(
                  padding: const EdgeInsetsGeometry.only(left: AppDimensions.normalXL, top: 200),
                  child: Text(welcomeText, style: AppTextStyles.zonaPro30),
                ),
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                opacity: state.authenticationErrorText == null ? 0 : 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.normalM,
                    vertical: AppDimensions.minorS,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.normalM,
                    vertical: AppDimensions.normalM,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    state.authenticationErrorText ?? '',
                    style: AppTextStyles.zonaPro16.copyWith(color: AppColors.cherryRed),
                  ),
                ),
              ),

              if (state.isLoginMode) ...[const LoginForm()] else ...[const RegistrationForm()],
            ],
          ),
        );
      },
    );
  }
}
