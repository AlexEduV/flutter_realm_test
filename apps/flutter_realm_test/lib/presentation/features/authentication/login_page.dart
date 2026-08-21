import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_asset_routes.dart';
import 'package:test_flutter_project/common/enums/auth_mode.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/auth_error_widget.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/auth_form_switcher.dart';

import 'login_page_identifiers.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLogin = state.currentAuthMode == AuthMode.login;

        final welcomeText = isLogin
            ? context.tr(LoginPageIds.loginPageLoginWelcomeText)
            : context.tr(LoginPageIds.loginPageRegistrationWelcomeText);

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
                        ColoredBox(color: Colors.black.withAlpha(70)),
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

                    AuthFormsSwitcher(isLoginMode: isLogin),
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
