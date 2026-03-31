import 'package:flutter/material.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/animated_password_visibility_icon.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class AppFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final String? errorText;
  final TextInputType textInputType;
  final IconData? leadingIcon;
  final TextInputAction textInputAction;
  final bool isObscureText;
  final Function()? onEditingComplete;
  final Function()? onSuffixIconPressed;
  final Function(bool)? onFocusChange;
  final Function(String? value) onChanged;
  final String? trailingActionSemanticsLabel;
  final int? maxLength;
  final double? padding;
  final VoidCallback? onTap;

  const AppFormField({
    required this.focusNode,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
    required this.onFocusChange,
    required this.onChanged,
    this.errorText,
    this.onEditingComplete,
    this.isObscureText = false,
    this.maxLength,
    this.leadingIcon,
    this.padding = AppDimensions.normalM,
    this.onSuffixIconPressed,
    this.trailingActionSemanticsLabel,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isAddItemForm = padding != null;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding ?? 0.0,
        vertical: isAddItemForm ? AppDimensions.minorS : 0.0,
      ),
      child: Focus(
        onFocusChange: onFocusChange,
        child: TextFormField(
          maxLength: maxLength,
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
            prefixIcon: leadingIcon != null
                ? Icon(leadingIcon, color: AppColors.accentColor)
                : null,
            suffixIcon: onSuffixIconPressed != null ? getFieldSuffixWidget() : null,
          ),
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: isObscureText,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget getFieldSuffixWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.normalS),
      child: AppSemantics(
        label: trailingActionSemanticsLabel ?? '',
        button: true,
        isSelected: isObscureText,
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            //this will prevent refocusing on the text field on icon long press;
            onLongPress: () {},
            onTap: onSuffixIconPressed,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.normalS),
              child: AnimatedVisibilityIcon(isObscure: isObscureText),
            ),
          ),
        ),
      ),
    );
  }
}
