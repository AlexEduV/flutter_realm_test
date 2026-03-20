import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/local/env_local_data_source.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_button.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_text_field.dart';

import '../../../../../common/app_dimensions.dart';

class ChatInputBar extends StatelessWidget {
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
              onTap: () {},
              iconRotationAngleDegrees: 40,
              semanticsLabel: AppSemanticsLabels.chatInputBarAttachmentButton,
            ),

            Expanded(
              child: ChatInputTextField(
                focusNode: messageFocusNode,
                textEditingController: messageTextController,
                sendMessage: (context, state) => sendMessage(context, state),
              ),
            ),

            ChatInputButton(
              icon: isTextFieldEmpty ? Icons.gif : Icons.send,
              onTap: isTextFieldEmpty ? pickGif : () => sendMessage(context, state),
              iconRotationAngleDegrees: isTextFieldEmpty ? 0.0 : -40,
              semanticsLabel: AppSemanticsLabels.chatInputBarSendMessageButton,
            ),
          ],
        );
      },
    );
  }

  void pickGif() {
    final klipyApiKey = serviceLocator<EnvLocalDataSource>().get(key: AppConstants.envKlipyKeyPath);

    return;
  }

  void sendMessage(BuildContext context, MessagesPageState state) {
    final user = context.read<UserDataCubit>().user;

    context.read<InboxPageCubit>().sendMessage(
      state.currentConversationId,
      MessageModel(user.userId, MessageStatus.sent, messageTextController.text, DateTime.now()),
    );

    onMessageSent?.call();

    context.read<MessagesPageCubit>().updateMessageText('');
    messageTextController.clear();

    messageFocusNode.requestFocus();
  }
}
