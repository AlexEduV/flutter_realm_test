import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class DialogHelper {
  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool isDeletion = true,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
          content: Text(description),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelButtonTitle, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
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
          ],
        );
      },
    );
  }
}
