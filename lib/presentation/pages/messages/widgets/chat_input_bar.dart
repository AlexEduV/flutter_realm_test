import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

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
  double textFieldScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalM);

    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: AppDimensions.minorL,
          children: [
            ChatInputButton(icon: Icons.attach_file, onTap: () {}),

            Expanded(
              child: AnimatedScale(
                scale: textFieldScale,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: TextFormField(
                  onTap: onTextFieldTap,
                  focusNode: widget.messageFocusNode,
                  controller: widget.messageTextController,
                  decoration: InputDecoration(
                    hintText: context.tr(L10nKeys.messageBarHint),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.normalM,
                      horizontal: AppDimensions.normalS,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: textFieldBorderRadius,
                      borderSide: const BorderSide(color: AppColors.accentColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: textFieldBorderRadius,
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: textFieldBorderRadius,
                      borderSide: const BorderSide(
                        color: AppColors.accentColor,
                        width: AppDimensions.minorXS,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderRadius: textFieldBorderRadius,
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  style: AppTextStyles.zonaPro16,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (newValue) =>
                      context.read<MessagesPageCubit>().updateMessageText(newValue),
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) return;

                    sendMessage(context, state);
                  },
                ),
              ),
            ),

            ChatInputButton(
              icon: Icons.send,
              onTap: state.currentMessageText.isEmpty ? null : () => sendMessage(context, state),
            ),
          ],
        );
      },
    );
  }

  Future<void> onTextFieldTap() async {
    setState(() => textFieldScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => textFieldScale = 1.0);
  }

  void sendMessage(BuildContext context, MessagesPageState state) {
    final user = context.read<UserDataCubit>().user;

    context.read<InboxPageCubit>().sendMessage(
      state.currentConversationId,
      MessageModel(
        user.userId,
        MessageStatus.sent,
        widget.messageTextController.text,
        DateTime.now(),
      ),
    );

    widget.onMessageSent?.call();

    context.read<MessagesPageCubit>().updateMessageText('');
    widget.messageTextController.clear();

    widget.messageFocusNode.requestFocus();
  }
}
