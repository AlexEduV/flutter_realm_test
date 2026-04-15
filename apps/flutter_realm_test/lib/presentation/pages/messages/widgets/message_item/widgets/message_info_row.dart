import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../common/constants/app_text_styles.dart';
import '../../../../../../l10n/l10n_keys.dart';

class MessageInfoRow extends StatelessWidget {
  final String time;
  final bool isMyMessage;
  final String senderName;

  const MessageInfoRow({
    required this.time,
    required this.isMyMessage,
    required this.senderName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.minorM,
      mainAxisSize: MainAxisSize.min,
      textDirection: isMyMessage ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(
          isMyMessage ? context.tr(L10nKeys.messageSenderYou) : senderName,
          style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(time),
      ],
    );
  }
}
