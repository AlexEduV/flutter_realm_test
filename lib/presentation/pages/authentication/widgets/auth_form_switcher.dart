import 'package:flutter/cupertino.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/registration_form.dart';

import 'login_form.dart';

class AuthFormsSwitcher extends StatelessWidget {
  final bool isLoginMode;

  const AuthFormsSwitcher({required this.isLoginMode, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        child: isLoginMode
            ? const LoginForm(key: ValueKey('login'))
            : const RegistrationForm(key: ValueKey('register')),
      ),
    );
  }
}
