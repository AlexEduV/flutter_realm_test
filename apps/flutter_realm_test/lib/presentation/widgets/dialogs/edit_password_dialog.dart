import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_dimensions.dart';
import '../../../common/constants/app_semantics_labels.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../l10n/l10n_keys.dart';
import '../../bloc/account/edit_dialog_cubit.dart';
import '../../bloc/account/edit_dialog_state.dart';
import '../../pages/account/sub_pages/personal_details/widgets/edit_password_field_widget.dart';
import '../app_semantics.dart';

class EditPasswordDialog extends StatefulWidget {
  final String title;
  final String cancelButtonTitle;
  final String confirmButtonTitle;
  final void Function(String)? onConfirm;
  final VoidCallback? onCancel;
  final bool Function(String)? validationCallback;
  final bool isPasswordField;

  const EditPasswordDialog({
    required this.title,
    required this.cancelButtonTitle,
    required this.confirmButtonTitle,
    super.key,
    this.onConfirm,
    this.onCancel,
    this.validationCallback,
    this.isPasswordField = false,
  });

  @override
  State<EditPasswordDialog> createState() => _EditPasswordDialogState();
}

class _EditPasswordDialogState extends State<EditPasswordDialog> {
  final textEditingController = TextEditingController();
  final confirmationTextEditingController = TextEditingController();
  final focusNode = FocusNode();
  final confirmationFocusNode = FocusNode();

  @override
  void initState() {
    _validateEditField(context, textEditingController.text, widget.validationCallback);
    _validateEditField(context, confirmationTextEditingController.text, widget.validationCallback);

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    confirmationFocusNode.dispose();

    textEditingController.dispose();
    confirmationTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDialogCubit, EditDialogState>(
      builder: (context, state) {
        final isConfirmButtonEnabled =
            state.isConfirmButtonEnabled &&
            textEditingController.text == confirmationTextEditingController.text;

        return AlertDialog(
          title: Text(
            widget.title,
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.minorL,
            children: [
              Text(context.tr(L10nKeys.personalDetailsItemPasswordDialogLabel)),

              EditPasswordFieldWidget(
                textEditingController: textEditingController,
                focusNode: focusNode,
                validateEditField: _validateEditField,
                validationCallback: widget.validationCallback,
                isObscureText: state.isPasswordFieldObscure,
                onSuffixIconTap: () => context.read<EditDialogCubit>().setPasswordFieldObscurity(
                  !state.isPasswordFieldObscure,
                ),
              ),

              const SizedBox(height: AppDimensions.minorS),

              Text(context.tr(L10nKeys.personalDetailsItemPasswordDialogSecondLabel)),

              EditPasswordFieldWidget(
                textEditingController: confirmationTextEditingController,
                focusNode: confirmationFocusNode,
                validationCallback: widget.validationCallback,
                validateEditField: _validateEditField,
                isObscureText: state.isConfirmationPasswordFieldObscure,
                onSuffixIconTap: () =>
                    context.read<EditDialogCubit>().setPasswordConfirmationFieldObscurity(
                      !state.isConfirmationPasswordFieldObscure,
                    ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          actions: [
            AppSemantics(
              label: AppSemanticsLabels.dialogCancelButton,
              button: true,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onCancel?.call();
                },
                child: Text(
                  widget.cancelButtonTitle,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            AppSemantics(
              label: AppSemanticsLabels.dialogConfirmButton,
              button: true,
              enabled: isConfirmButtonEnabled,
              child: ElevatedButton(
                onPressed: isConfirmButtonEnabled
                    ? () {
                        Navigator.of(context).pop();
                        widget.onConfirm?.call(textEditingController.text);
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    }
                    return AppColors.headerColor;
                  }),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
                child: Text(
                  widget.confirmButtonTitle,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _validateEditField(
    BuildContext context,
    String newValue,
    bool Function(String)? validationCallback,
  ) {
    final isValid = validationCallback?.call(newValue);
    context.read<EditDialogCubit>().setConfirmButtonEnabled(isValid ?? false);
  }
}
