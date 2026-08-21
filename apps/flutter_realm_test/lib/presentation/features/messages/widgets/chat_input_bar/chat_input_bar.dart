import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';

import '../../messages_page_state.dart';
import 'chat_input_button.dart';
import 'chat_input_text_field.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    required this.messageTextController,
    required this.messageFocusNode,
    this.onMessageSent,
    super.key,
  });

  final TextEditingController messageTextController;
  final FocusNode messageFocusNode;
  final VoidCallback? onMessageSent;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        final isTextFieldEmpty = state.currentMessageText.isEmpty;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: AppDimensions.minorL,
          children: [
            ChatInputButton(
              icon: Icons.attach_file,
              onTap: () async => await _addAttachment(),
              iconRotationAngleDegrees: 40,
              semanticsLabel: MessagesPageIds.chatInputBarAttachmentButton,
            ),

            Expanded(
              child: ChatInputTextField(
                focusNode: widget.messageFocusNode,
                textEditingController: widget.messageTextController,
                sendMessage: (context, state) => _onSendMessageTap(context),
                onMessageSent: widget.onMessageSent,
              ),
            ),

            ChatInputButton(
              icon: Icons.send,
              onTap: isTextFieldEmpty ? null : () => _onSendMessageTap(context),
              iconRotationAngleDegrees: -40,
              semanticsLabel: MessagesPageIds.chatInputBarSendMessageButton,
            ),
          ],
        );
      },
    );
  }

  void _onSendMessageTap(BuildContext context) {
    _sendMessage(widget.messageTextController.text);

    context.read<MessagesPageCubit>().updateMessageText('');
    widget.messageTextController.clear();

    widget.messageFocusNode.requestFocus();
  }

  Future<void> _addAttachment() async {
    final attachment = await context.read<MessagesPageCubit>().getAttachmentFile();
    if (attachment == null) return;

    _sendMessage(attachment.toPayload());
  }

  void _sendMessage(String message) {
    final conversationId = context.read<MessagesPageCubit>().state.currentConversationId ?? '';
    final user = context.read<UserDataCubit>().state.user;

    context.read<InboxPageCubit>().sendMessage(
      conversationId,
      MessageModel(
        senderId: user.userId,
        messageStatus: MessageStatus.sent,
        payload: message,
        date: serviceLocator<TimeService>().now(),
      ),
    );

    widget.onMessageSent?.call();
  }
}
