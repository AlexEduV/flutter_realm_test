import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/core/router/app_router.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';
import 'package:test_flutter_project/presentation/widgets/avatar_widget.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';
import 'package:test_flutter_project/utils/inline_style_parser.dart';

import '../../../../widgets/app_badge.dart';

class InboxListItem extends StatelessWidget {
  const InboxListItem({
    required this.conversation,
    required this.owner,
    required this.unreadCount,
    super.key,
  });

  final ConversationModel conversation;
  final OwnerEntity owner;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final message = conversation.messages.lastOrNull;
    final conversationId = conversation.conversationId;

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
            onLongPress: () => DialogHelper.showInboxItemModalBottomSheet(context, conversationId),
            borderRadius: BorderRadius.circular(AppDimensions.normalM),
            onTap: () => AppRouter.goToInbox(context: context, conversationId: conversationId),
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
                            child: Text.rich(
                              TextSpan(
                                children: parseInlineStyles(
                                  '${_formatMessageText(message?.payload, context)}\n',
                                ),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                              message == null
                                  ? ''
                                  : context.read<MessagesPageCubit>().getMessageTime(message.date),
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

  String _formatMessageText(String? message, BuildContext context) {
    if (message == null) {
      return context.tr(L10nKeys.inboxPageEmptyText);
    }

    if (message.contains('url')) {
      return context.tr(L10nKeys.gifMessagePlaceholder);
    }

    if (message.contains('file')) {
      return context.tr(L10nKeys.attachmentMessagePlaceholder);
    }

    return message;
  }
}
