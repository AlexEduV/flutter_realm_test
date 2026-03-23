import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';
import 'package:test_futter_project/utils/date_formatter.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../widgets/app_badge.dart';

class InboxListItem extends StatelessWidget {
  final ConversationModel conversation;

  const InboxListItem({required this.conversation, super.key});

  @override
  Widget build(BuildContext context) {
    final message = conversation.messages.lastOrNull;
    final owner = serviceLocator<GetOwnerByIdUseCase>().call(conversation.ownerId);

    final unreadCount = getUnreadCount();

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
            onLongPress: () =>
                DialogHelper.showInboxItemModalBottomSheet(context, conversation.conversationId),
            borderRadius: BorderRadius.circular(AppDimensions.normalM),
            onTap: () =>
                context.go(AppRoutes.home + AppRoutes.inbox, extra: conversation.conversationId),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.normalXS),
              child: SizedBox(
                height: AppDimensions.inboxItemHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.normalM,
                  children: [
                    AvatarWidget(imageSrc: owner.imageSrc),

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
                          ExcludeSemantics(
                            child: Text(
                              '${formatMessageText(message?.text, context)}\n',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: AppDimensions.minorL,
                      children: [
                        Row(
                          spacing: AppDimensions.minorM,
                          children: [
                            Icon(_getMessageStatusIcon(message)),

                            Text(
                              message == null ? '' : DateFormatter.formatSmartDate(message.date),
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),

                        if (unreadCount > 0) ...[AppBadge(text: unreadCount.toString())],
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

  int getUnreadCount() {
    final unreadCount = conversation.messages
        .where(
          (element) =>
              element.senderId == conversation.ownerId &&
              element.messageStatus == MessageStatus.sent,
        )
        .length;

    return unreadCount;
  }

  String formatMessageText(String? message, BuildContext context) {
    if (message == null) {
      return context.tr(L10nKeys.inboxPageEmptyText);
    }

    //todo: localise;
    if (message.startsWith(AppConstants.gifIdentifier)) {
      return 'GIF';
    }

    return message;
  }
}
