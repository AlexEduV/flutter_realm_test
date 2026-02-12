import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class LoginField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final IconData leadingIcon;
  final TextInputAction textInputAction;
  final bool isObscureText;
  final Function()? onEditingComplete;
  final Function()? onSuffixIconPressed;

  const LoginField({
    required this.focusNode,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.leadingIcon,
    required this.textInputAction,
    this.onEditingComplete,
    this.isObscureText = false,
    this.onSuffixIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
      child: Focus(
        onFocusChange: (newValue) {
          //todo: validate field here
        },
        child: TextFormField(
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppDimensions.normalM,
              horizontal: 20.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
              borderSide: const BorderSide(color: AppColors.accentColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
              borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: Icon(leadingIcon, color: AppColors.accentColor),
            suffixIcon: onSuffixIconPressed != null
                ? Padding(
                    padding: const EdgeInsets.only(right: AppDimensions.normalS),
                    child: IconButton(
                      onPressed: onSuffixIconPressed,
                      icon: Icon(isObscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  )
                : null,
          ),
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: isObscureText,
          onChanged: (newValue) {
            //todo: revalidate values here
          },
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
