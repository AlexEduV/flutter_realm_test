import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/presentation/widgets/app_badge.dart';
import 'package:test_futter_project/utils/date_formatter.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';

class InboxListItem extends StatelessWidget {
  final MessageModel message;

  const InboxListItem({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: AppDimensions.normalXS,
        vertical: AppDimensions.minorM,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalM),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.normalM),
          onTap: () => context.go(AppRoutes.home + AppRoutes.inbox, extra: message.sender.id),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.normalXS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.placeholderColor,
                  radius: AppDimensions.normalXL,
                ),

                const SizedBox(width: AppDimensions.normalM),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${message.text}\n',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(_getMessageStatusIcon()),

                        const SizedBox(width: AppDimensions.minorM),

                        Text(
                          DateFormatter.formatSmartDate(message.date),
                          style: AppTextStyles.zonaPro16Grey.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    if (message.messageStatus == MessageStatus.unknown) ...[
                      const Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: AppBadge(text: '1'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData? _getMessageStatusIcon() {
    switch (message.messageStatus) {
      case MessageStatus.sent:
        return Icons.done;
      case MessageStatus.read:
        return Icons.done_all;

      default:
        return null;
    }
  }
}
