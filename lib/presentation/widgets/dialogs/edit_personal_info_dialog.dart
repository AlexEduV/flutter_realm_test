import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimensions.dart';
import '../../../common/app_semantics_labels.dart';
import '../../../common/app_text_styles.dart';
import '../../bloc/account/edit_dialog_cubit.dart';
import '../../bloc/account/edit_dialog_state.dart';
import '../app_semantics.dart';

class EditPersonalInfoDialog extends StatefulWidget {
  final String initialValue;
  final String title;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final void Function(String)? onConfirm;
  final VoidCallback? onCancel;
  final bool Function(String)? validationCallback;
  final TextInputType textInputType;

  const EditPersonalInfoDialog({
    required this.initialValue,
    required this.title,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    super.key,
    this.onConfirm,
    this.onCancel,
    this.validationCallback,
    this.textInputType = TextInputType.text,
  });

  @override
  State<EditPersonalInfoDialog> createState() => _EditPersonalInfoDialogState();
}

class _EditPersonalInfoDialogState extends State<EditPersonalInfoDialog> {
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    textEditingController.text = widget.initialValue;
    _validateEditField(context, textEditingController.text, widget.validationCallback);

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDialogCubit, EditDialogState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            widget.title,
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
          ),
          content: AppSemantics(
            textField: true,
            label: AppSemanticsLabels.dialogEditField,
            child: TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onChanged: (newValue) =>
                  _validateEditField(context, newValue, widget.validationCallback),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                  borderSide: const BorderSide(color: AppColors.accentColor),
                ),
              ),
              keyboardType: widget.textInputType,
            ),
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
              enabled: state.isConfirmButtonEnabled,
              child: ElevatedButton(
                onPressed: state.isConfirmButtonEnabled
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
