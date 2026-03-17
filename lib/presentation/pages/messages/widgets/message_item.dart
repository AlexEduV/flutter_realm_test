import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../widgets/avatar_widget.dart';

class MessageItem extends StatelessWidget {
  final String name;
  final String? imageSrc;
  final String message;
  final String time;
  final bool isMyMessage;

  const MessageItem({
    required this.name,
    required this.imageSrc,
    required this.message,
    required this.time,
    this.isMyMessage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final senderInfo = [
      Text(
        isMyMessage ? context.tr(L10nKeys.messageSenderYou) : name,
        style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
      ),
      const SizedBox(width: AppDimensions.minorM),
      Text(time),
    ];

    final messageContent = Column(
      crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: isMyMessage ? senderInfo.reversed.toList() : senderInfo,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.normalS,
            horizontal: AppDimensions.normalM,
          ),
          decoration: BoxDecoration(
            color: isMyMessage ? Colors.blue : AppColors.whiteGrey,
            borderRadius: BorderRadius.only(
              topLeft: isMyMessage ? const Radius.circular(AppDimensions.normalS) : Radius.zero,
              topRight: isMyMessage ? Radius.zero : const Radius.circular(AppDimensions.normalS),
              bottomLeft: const Radius.circular(AppDimensions.normalS),
              bottomRight: const Radius.circular(AppDimensions.normalS),
            ),
          ),
          child: Text(message, style: isMyMessage ? const TextStyle(color: Colors.white) : null),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.minorL,
        mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isMyMessage
            ? [
                Expanded(child: messageContent),
                AvatarWidget(imageSrc: imageSrc, size: AppDimensions.majorM),
              ]
            : [
                AvatarWidget(imageSrc: imageSrc, size: AppDimensions.majorM),
                Expanded(child: messageContent),
              ],
      ),
    );
  }
}
