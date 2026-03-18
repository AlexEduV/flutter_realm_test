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

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';

class MessageBar extends StatelessWidget {
  final TextEditingController messageTextController;
  final FocusNode messageFocusNode;
  final VoidCallback? onMessageSent;

  const MessageBar({
    required this.messageTextController,
    required this.messageFocusNode,
    this.onMessageSent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textFieldBorderRadius = BorderRadius.circular(AppDimensions.normalM);

    return BlocBuilder<MessagesPageCubit, MessagesPageState>(
      builder: (context, state) {
        return Row(
          spacing: AppDimensions.minorL,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.attach_file),
              style: const ButtonStyle(
                iconSize: WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
                foregroundColor: WidgetStatePropertyAll(AppColors.headerColor),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
            ),
            Expanded(
              child: TextFormField(
                focusNode: messageFocusNode,
                controller: messageTextController,
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
                keyboardType: TextInputType.text,
                onChanged: (newValue) =>
                    context.read<MessagesPageCubit>().updateMessageText(newValue),
                onFieldSubmitted: (value) {
                  if (value.isEmpty) return;

                  sendMessage(context, state);
                },
              ),
            ),
            IconButton(
              onPressed: state.currentMessageText.isEmpty
                  ? null
                  : () => sendMessage(context, state),
              icon: const Icon(Icons.send),
              style: ButtonStyle(
                iconSize: const WidgetStatePropertyAll(AppDimensions.bottomMessageBarIconSize),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return AppColors.lightGrey; // your disabled color here
                  }
                  return AppColors.headerColor; // default color
                }),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
              ),
            ),
          ],
        );
      },
    );
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
