import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/presentation/widgets/app_badge.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';
import 'package:test_futter_project/utils/date_formatter.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';

class InboxListItem extends StatelessWidget {
  final ConversationModel conversation;

  const InboxListItem({required this.conversation, super.key});

  @override
  Widget build(BuildContext context) {
    final message = conversation.messages.lastOrNull;
    final owner = serviceLocator<GetOwnerByIdUseCase>().call(conversation.ownerId);

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: AppDimensions.normalXS,
        vertical: AppDimensions.minorM,
      ),
      child: AppSemantics(
        label: '${AppSemanticsLabels.inboxItem} ${owner.firstName} ${owner.lastName}',
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.normalM),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.normalM),
            onTap: () =>
                context.go(AppRoutes.home + AppRoutes.inbox, extra: conversation.conversationId),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.normalXS),
              child: SizedBox(
                height: AppDimensions.inboxItemHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarWidget(imageSrc: owner.imageSrc),

                    const SizedBox(width: AppDimensions.normalM),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${owner.firstName} ${owner.lastName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${message?.text ?? ''}\n',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.zonaPro16Grey.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(_getMessageStatusIcon(message)),

                            const SizedBox(width: AppDimensions.minorM),

                            Text(
                              message == null ? '' : DateFormatter.formatSmartDate(message.date),
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        if (message?.messageStatus == MessageStatus.unknown) ...[
                          const SizedBox(height: AppDimensions.minorL),

                          const Align(
                            alignment: AlignmentGeometry.bottomRight,
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
        ),
      ),
    );
  }

  IconData? _getMessageStatusIcon(MessageModel? message) {
    switch (message?.messageStatus) {
      case MessageStatus.sent:
        return Icons.done;
      case MessageStatus.read:
        return Icons.done_all;

      default:
        return null;
    }
  }
}
