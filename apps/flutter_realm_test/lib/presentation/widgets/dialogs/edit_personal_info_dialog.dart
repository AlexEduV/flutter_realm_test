import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_semantics_labels.dart';
import '../../widgets/dialogs/edit_dialog_cubit.dart';
import '../../widgets/dialogs/edit_dialog_state.dart';
import '../app_semantics.dart';

class EditPersonalInfoDialog extends StatefulWidget {
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

  final String initialValue;
  final String title;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final void Function(String)? onConfirm;
  final VoidCallback? onCancel;
  final bool Function(String)? validationCallback;
  final TextInputType textInputType;

  @override
  State<EditPersonalInfoDialog> createState() => _EditPersonalInfoDialogState();
}

class _EditPersonalInfoDialogState extends State<EditPersonalInfoDialog> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController.text = widget.initialValue;
    _validateEditField(context, _textEditingController.text, widget.validationCallback);

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();

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
              controller: _textEditingController,
              focusNode: _focusNode,
              onChanged: (newValue) =>
                  _validateEditField(context, newValue, widget.validationCallback),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.normalS),
                  borderSide: const BorderSide(color: AppColors.accentColor),
                ),
                hintStyle: AppTextStyles.zonaPro16.copyWith(color: AppColors.hintColor),
              ),
              keyboardType: widget.textInputType,
              style: AppTextStyles.zonaPro16,
            ),
          ),
          backgroundColor: AppColors.white,
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
                        widget.onConfirm?.call(_textEditingController.text);
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    }
                    return AppColors.headerColor;
                  }),
                  foregroundColor: const WidgetStatePropertyAll(AppColors.white),
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
