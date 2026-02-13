import 'package:flutter/cupertino.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/registration_form.dart';

import 'login_form.dart';

class AuthFormsSwitcher extends StatelessWidget {
  final bool isLoginMode;

  const AuthFormsSwitcher({required this.isLoginMode, super.key});

  @override
  Widget build(BuildContext context) {
    //todo: not the best resizing. I wanted the bottom to always remain there, and the height to
    //change upwards, but did not find a solution.
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: isLoginMode
            ? const LoginForm(key: ValueKey('login'))
            : const RegistrationForm(key: ValueKey('register')),
      ),
    );
  }
}
