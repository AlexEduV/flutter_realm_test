import 'package:flutter/cupertino.dart';

import 'login_form.dart';
import 'registration_form.dart';

class AuthFormsSwitcher extends StatelessWidget {
  const AuthFormsSwitcher({required this.isLoginMode, super.key});

  final bool isLoginMode;

  @override
  Widget build(BuildContext context) {
    return isLoginMode ? const LoginForm() : const RegistrationForm();
  }
}
