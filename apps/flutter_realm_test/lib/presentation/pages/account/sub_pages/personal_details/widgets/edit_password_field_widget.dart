import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';

import '../../../../../../common/constants/app_colors.dart';
import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../common/constants/app_semantics_labels.dart';
import '../../../../../../common/constants/app_text_styles.dart';
import '../../../../../bloc/account/edit_dialog_cubit.dart';
import '../../../../../widgets/app_semantics.dart';
import '../../../../authentication/widgets/animated_password_visibility_icon.dart';

class EditPasswordFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final bool Function(String)? validationCallback;
  final void Function(BuildContext, String, bool Function(String)?) validateEditField;
  final void Function() onSuffixIconTap;
  final bool isObscureText;

  const EditPasswordFieldWidget({
    required this.textEditingController,
    required this.focusNode,
    required this.validateEditField,
    required this.onSuffixIconTap,
    required this.isObscureText,
    super.key,
    this.validationCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDialogCubit, EditDialogState>(
      builder: (context, state) {
        return AppSemantics(
          textField: true,
          label: AppSemanticsLabels.dialogEditField,
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (newValue) => validateEditField(context, newValue, validationCallback),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppDimensions.minorL,
                horizontal: AppDimensions.minorL,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.normalS),
                borderSide: const BorderSide(color: AppColors.accentColor),
              ),
              suffixIcon: _getFieldSuffixWidget(
                isObscureText,
                AppSemanticsLabels.obscurePasswordButton,
                onSuffixIconTap,
              ),
              hintStyle: AppTextStyles.zonaPro16.copyWith(color: AppColors.hintColor),
            ),
            obscureText: isObscureText,
            keyboardType: TextInputType.visiblePassword,
            style: AppTextStyles.zonaPro16,
          ),
        );
      },
    );
  }

  Widget _getFieldSuffixWidget(
    bool isObscureText,
    String? trailingActionSemanticsLabel,
    final void Function() onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.minorS).copyWith(right: AppDimensions.normalS),
      child: AppSemantics(
        label: trailingActionSemanticsLabel ?? '',
        button: true,
        isSelected: isObscureText,
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            //this will prevent refocusing on the text field on icon long press;
            onLongPress: () {},
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.minorL),
              child: AnimatedVisibilityIcon(isObscure: isObscureText),
            ),
          ),
        ),
      ),
    );
  }
}
