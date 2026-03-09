import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/auth_error_widget.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/auth_form_switcher.dart';
import 'package:test_futter_project/utils/l10n/l10n.dart';

import '../../../common/app_colors.dart';

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
            ? AppLocalisations.of(context).loginPageLoginWelcomeText
            : AppLocalisations.of(context).loginPageRegistrationWelcomeText;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light, //Android
            statusBarBrightness: Brightness.dark, //iOS
          ),
          child: Scaffold(
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
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          AppAssetRoutes.yellowCarLoginBackground,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.bottomCenter,
                        ),
                        Container(
                          color: Colors.black.withAlpha(70), // Adjust opacity as needed
                        ),
                      ],
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
                          top: 120,
                        ),
                        child: Text(
                          welcomeText,
                          style: AppTextStyles.zonaPro30White.copyWith(
                            shadows: [
                              const Shadow(
                                blurRadius: 2.0,
                                color: Colors.black,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    AuthErrorWidget(text: state.authenticationErrorText),

                    AuthFormsSwitcher(isLoginMode: state.isLoginMode),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
