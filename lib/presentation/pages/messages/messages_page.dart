import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/message_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_bar.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import '../../../common/app_text_styles.dart';
import '../../../utils/date_formatter.dart';

class MessagesPage extends StatefulWidget {
  final String conversationId;

  const MessagesPage({required this.conversationId, super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final messageInputTextController = TextEditingController();
  final messageInputFocusNode = FocusNode();

  late ConversationModel conversation;
  late OwnerEntity owner;

  @override
  void initState() {
    context.read<MessagesPageCubit>().setCurrentConversationId(widget.conversationId);

    conversation = serviceLocator<GetConversationByIdUseCase>().call(widget.conversationId);
    owner = serviceLocator<GetOwnerByIdUseCase>().call(conversation.ownerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(owner.name, style: AppTextStyles.zonaPro20),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.normalS),
            child: AvatarWidget(imageSrc: owner.imageSrc, size: AppDimensions.appBarIconSize * 1.5),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<InboxPageCubit, InboxPageState>(
            builder: (context, state) {
              final conversation =
                  state.conversations.firstWhereOrNull(
                    (element) => element.conversationId == widget.conversationId,
                  ) ??
                  ConversationModel.empty();

              return ListView.builder(
                itemBuilder: (context, index) {
                  final message = conversation.messages[index];
                  final isExpanded = shouldExpandMessage(index, message, conversation);

                  return MessageItem(
                    name: message.sender.name,
                    imageSrc: message.sender.imageSrc,
                    message: message.text,
                    time: DateFormatter.formatSmartDate(message.date),
                    isMyMessage: message.sender.id != owner.id,
                    expanded: isExpanded,
                  );
                },
                itemCount: conversation.messages.length,
              );
            },
          ),

          Positioned(
            bottom: AppDimensions.majorM,
            left: AppDimensions.minorL,
            right: AppDimensions.minorL,
            child: MessageBar(
              messageTextController: messageInputTextController,
              messageFocusNode: messageInputFocusNode,
            ),
          ),
        ],
      ),
    );
  }

  bool shouldExpandMessage(int index, MessageModel currentMessage, ConversationModel conversation) {
    if (index > 0) {
      final previousMessage = conversation.messages[index - 1];
      final differenceInMinutes = currentMessage.date.difference(previousMessage.date).inMinutes;

      if (previousMessage.sender == currentMessage.sender && differenceInMinutes.abs() < 2) {
        return false;
      }
    }

    return true;
  }
}
