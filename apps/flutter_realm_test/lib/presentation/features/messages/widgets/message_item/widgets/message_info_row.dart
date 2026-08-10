import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';

import '../../../../inbox/inbox_page_identifiers.dart';

class MessageInfoRow extends StatelessWidget {
  const MessageInfoRow({
    required this.time,
    required this.isMyMessage,
    required this.senderName,
    super.key,
  });

  final String time;
  final bool isMyMessage;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppDimensions.minorM,
      mainAxisSize: MainAxisSize.min,
      textDirection: isMyMessage ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(
          isMyMessage ? context.tr(InboxPageLocaleKeys.messageSenderYou) : senderName,
          style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(time),
      ],
    );
  }
}
