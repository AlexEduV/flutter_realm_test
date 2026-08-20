import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_semantics_labels.dart';
import '../app_semantics.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.description,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    this.isAlertStyling = true,
    this.onConfirm,
    this.onCancel,
    super.key,
  });

  final String title;
  final String description;
  final VoidCallback? onConfirm;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final bool isAlertStyling;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
      content: Text(description),
      backgroundColor: AppColors.white,
      actions: [
        AppSemantics(
          label: AppSemanticsLabels.dialogCancelButton,
          button: true,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: Text(cancelButtonTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        AppSemantics(
          label: AppSemanticsLabels.dialogConfirmButton,
          button: true,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm?.call();
            },
            style: isAlertStyling
                ? const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red))
                : null,
            child: Text(
              confirmButtonTitle,
              style: TextStyle(
                color: isAlertStyling ? AppColors.white : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
