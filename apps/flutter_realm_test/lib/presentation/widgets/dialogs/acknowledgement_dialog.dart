import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AcknowledgementDialog extends StatelessWidget {
  const AcknowledgementDialog({
    required this.title,
    required this.description,
    required this.confirmButtonTitle,
    this.isAlertStyling = true,
    this.onConfirm,
    super.key,
  });

  final String title;
  final String description;
  final VoidCallback? onConfirm;
  final String confirmButtonTitle;
  final bool isAlertStyling;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700)),
      content: Text(description),
      actionsPadding: const EdgeInsets.only(bottom: AppDimensions.normalM),
      actions: [
        SplashButton(
          title: confirmButtonTitle,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
        ),
      ],
    );
  }
}
