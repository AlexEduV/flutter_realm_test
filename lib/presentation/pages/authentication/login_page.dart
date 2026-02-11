import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

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
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 200),

          const Padding(
            padding: EdgeInsetsGeometry.only(left: AppDimensions.normalXL),
            child: Text('Welcome \nBack', style: AppTextStyles.zonaPro30),
          ),

          const SizedBox(height: 200),

          // email textField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: TextFormField(
              controller: emailTextController,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                errorText: null,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppDimensions.minorS,
                  horizontal: AppDimensions.minorL,
                ),
                fillColor: Colors.white,
                filled: true,
                labelText: 'Email',
                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          const SizedBox(height: 20),

          // password textField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: TextFormField(
              controller: passwordTextController,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                errorText: null,
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppDimensions.minorS,
                  horizontal: AppDimensions.minorL,
                ),
                fillColor: Colors.white,
                filled: true,
                labelText: 'Password',
                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentColor)),
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          //forgot password button
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.minorS, right: AppDimensions.normalM),
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

          // login button

          //Or Divider

          // join us button if not registered
        ],
      ),
    );
  }
}
