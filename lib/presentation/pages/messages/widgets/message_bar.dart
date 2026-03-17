import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

class MessageBar extends StatelessWidget {
  final TextEditingController messageTextController;
  final FocusNode messageFocusNode;

  const MessageBar({
    required this.messageTextController,
    required this.messageFocusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalM);

    return Row(
      spacing: AppDimensions.minorL,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.attach_file),
          style: const ButtonStyle(
            iconSize: WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
            foregroundColor: WidgetStatePropertyAll(AppColors.headerColor),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        Expanded(
          child: TextFormField(
            focusNode: messageFocusNode,
            controller: messageTextController,
            decoration: InputDecoration(
              hintText: 'Message',
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppDimensions.normalM,
                horizontal: AppDimensions.normalS,
              ),
              border: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(color: AppColors.accentColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(
                  color: AppColors.accentColor,
                  width: AppDimensions.minorXS,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: textFieldBorderRadius,
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            style: AppTextStyles.zonaPro16,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.send),
          style: const ButtonStyle(
            iconSize: WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
            foregroundColor: WidgetStatePropertyAll(AppColors.headerColor),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
      ],
    );
  }
}
