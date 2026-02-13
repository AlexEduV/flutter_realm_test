import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class LoginField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final String? errorText;
  final TextInputType textInputType;
  final IconData leadingIcon;
  final TextInputAction textInputAction;
  final bool isObscureText;
  final Function()? onEditingComplete;
  final Function()? onSuffixIconPressed;
  final Function(bool)? onFocusChange;
  final Function(String? value) onChanged;

  const LoginField({
    required this.focusNode,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.leadingIcon,
    required this.textInputAction,
    required this.onFocusChange,
    required this.onChanged,
    this.errorText,
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
        onFocusChange: onFocusChange,
        child: TextFormField(
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            errorText: errorText,
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
              borderSide: const BorderSide(
                color: AppColors.accentColor,
                width: AppDimensions.minorXS,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.normalS),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: Icon(leadingIcon, color: AppColors.accentColor),
            suffixIcon: onSuffixIconPressed != null
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(end: AppDimensions.normalS),
                    child: Material(
                      borderRadius: BorderRadius.circular(100.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100.0),
                        onTap: onSuffixIconPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(isObscureText ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: isObscureText,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
