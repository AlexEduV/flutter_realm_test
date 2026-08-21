import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

import '../login_page_identifiers.dart';

class AuthErrorWidget extends StatelessWidget {
  const AuthErrorWidget({this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
      label: LoginPageIds.authErrorMessage,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        opacity: text == null ? 0 : 1,
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
            color: Colors.orange,
            borderRadius: BorderRadius.circular(AppDimensions.minorL),
          ),
          child: Text(
            text ?? '',
            style: AppTextStyles.zonaPro16.copyWith(color: AppColors.cherryRed),
          ),
        ),
      ),
    );
  }
}
