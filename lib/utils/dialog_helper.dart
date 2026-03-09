import 'package:flutter/material.dart';

import 'l10n.dart';

class DialogHelper {
  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(AppLocalisations.cancelLabel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(AppLocalisations.confirmLabel),
            ),
          ],
        );
      },
    );
  }
}
