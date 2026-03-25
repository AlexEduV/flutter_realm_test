import 'package:flutter/material.dart';

import '../../../common/app_semantics_labels.dart';
import '../../../common/app_text_styles.dart';
import '../app_semantics.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onConfirm;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final bool isDeletion;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    required this.title,
    required this.description,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    this.isDeletion = true,
    this.onConfirm,
    this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
      content: Text(description),
      backgroundColor: Colors.white,
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
            style: isDeletion
                ? const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red))
                : null,
            child: Text(
              confirmButtonTitle,
              style: TextStyle(
                color: isDeletion ? Colors.white : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
