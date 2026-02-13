import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/login_form.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/registration_form.dart';
import 'package:test_futter_project/utils/l10n.dart';

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
        final welcomeText = state.isLoginMode
            ? AppLocalisations.loginPageLoginWelcomeText
            : AppLocalisations.loginPageRegistrationWelcomeText;

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Stack(
            children: [
              FractionallySizedBox(
                alignment: Alignment.bottomCenter, // or any alignment you need
                heightFactor: 0.5, // 50% of the parent's height
                widthFactor: 1.0, // full width
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.7, 1.0],
                      colors: [
                        Colors.white, // Fully visible image
                        Colors.white, // Start fading
                        Colors.transparent, // Fully faded (shows background)
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/car-yellow.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsGeometry.only(
                        left: AppDimensions.normalXL,
                        top: 200,
                      ),
                      child: Text(welcomeText, style: AppTextStyles.zonaPro30White),
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
            ],
          ),
        );
      },
    );
  }
}
