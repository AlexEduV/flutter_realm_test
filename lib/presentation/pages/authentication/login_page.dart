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
          const Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: AppDimensions.normalXL, top: 200),
              child: Text('Welcome \nBack', style: AppTextStyles.zonaPro30),
            ),
          ),

          // email textField
          // todo: add a background with cars or something, and a separate pages for registration and forgot password.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: TextFormField(
              controller: emailTextController,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.accentColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),

          const SizedBox(height: 20),

          // password textField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: TextFormField(
              controller: passwordTextController,
              focusNode: passwordFocusNode,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.accentColor),
              ),
              keyboardType: TextInputType.visiblePassword,
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
  }
}
