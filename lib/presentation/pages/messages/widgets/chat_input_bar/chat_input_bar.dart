import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/domain/entities/attachment_entity.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_button.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_text_field.dart';

import '../../../../../common/app_dimensions.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController messageTextController;
  final FocusNode messageFocusNode;
  final VoidCallback? onMessageSent;

  const ChatInputBar({
    required this.messageTextController,
    required this.messageFocusNode,
    this.onMessageSent,
    super.key,
  });

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
              onTap: () async => await addAttachment(),
              iconRotationAngleDegrees: 40,
              semanticsLabel: AppSemanticsLabels.chatInputBarAttachmentButton,
            ),

            Expanded(
              child: ChatInputTextField(
                focusNode: widget.messageFocusNode,
                textEditingController: widget.messageTextController,
                sendMessage: (context, state) => onSendMessageTap(context),
                onMessageSent: widget.onMessageSent,
              ),
            ),

            ChatInputButton(
              icon: Icons.send,
              onTap: isTextFieldEmpty ? null : () => onSendMessageTap(context),
              iconRotationAngleDegrees: -40,
              semanticsLabel: AppSemanticsLabels.chatInputBarSendMessageButton,
            ),
          ],
        );
      },
    );
  }

  void onSendMessageTap(BuildContext context) {
    sendMessage(widget.messageTextController.text);

    context.read<MessagesPageCubit>().updateMessageText('');
    widget.messageTextController.clear();

    widget.messageFocusNode.requestFocus();
  }

  Future<void> addAttachment() async {
    //todo: move to other layers
    final filePicker = FilePickerIO();
    final result = await filePicker.pickFiles(type: FileType.media);

    if (result == null || result.files.isEmpty) return;
    final resultConverted = AttachmentEntity.fromPlatformFile(result.files.first);
    sendMessage(resultConverted.toPayload());
  }

  void sendMessage(String message) {
    final conversationId = context.read<MessagesPageCubit>().state.currentConversationId ?? '';
    final user = context.read<UserDataCubit>().user;

    context.read<InboxPageCubit>().sendMessage(
      conversationId,
      MessageModel(
        senderId: user.userId,
        messageStatus: MessageStatus.sent,
        payload: message,
        date: DateTime.now(),
      ),
    );

    widget.onMessageSent?.call();
  }
}
