import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_futter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/domain/usecases/users/get_user_by_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_bar.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/date_divider.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/empty_conversation_placeholder.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item/message_item.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
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

  final listViewScrollController = ScrollController();

  late ConversationModel conversation;
  late OwnerEntity owner;

  final getUserById = serviceLocator<GetUserByIdUseCase>();

  @override
  void initState() {
    context.read<MessagesPageCubit>().setCurrentConversationId(widget.conversationId);

    conversation = serviceLocator<GetConversationByIdUseCase>().call(widget.conversationId);
    owner = serviceLocator<GetOwnerByIdUseCase>().call(conversation.ownerId);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //todo: maybe I should save the scroll position on exit, and do not scroll initially, only on
      // adding a message

      //the controller is assigned in the initial frame, so the post frame is needed;
      await scrollToBottom(isInit: true);
    });

    super.initState();
  }

  @override
  void dispose() {
    messageInputFocusNode.dispose();
    messageInputTextController.dispose();

    listViewScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      extendBody: true,
      appBar: AppBar(
        title: Text('${owner.firstName} ${owner.lastName}', style: AppTextStyles.zonaPro20),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.normalS),
            child: AvatarWidget(imageSrc: owner.imageSrc, size: AppDimensions.appBarIconSize * 1.5),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.majorM,
          left: AppDimensions.minorL,
          right: AppDimensions.minorL,
        ),
        child: ChatInputBar(
          onMessageSent: scrollToBottom,
          messageTextController: messageInputTextController,
          messageFocusNode: messageInputFocusNode,
        ),
      ),
      body: BlocBuilder<InboxPageCubit, InboxPageState>(
        builder: (context, state) {
          final conversation = getConversationById(widget.conversationId);
          final users = getUsersFromConversation(conversation);

          if (conversation.messages.isEmpty) {
            return const EmptyConversationPlaceholder();
          }

          return ListView.builder(
            controller: listViewScrollController,
            padding: const EdgeInsets.only(
              bottom: AppDimensions.bottomMessageBarHeight + AppDimensions.majorXL,
            ),
            itemCount: conversation.messages.length,
            itemBuilder: (context, index) {
              final message = conversation.messages[index];
              final isExpanded = shouldExpandMessage(index, conversation);
              final sender = users[message.senderId];

              final showDivider = shouldShowDivider(index, conversation);

              // Build a list of widgets: divider + message item
              return Column(
                children: [
                  if (showDivider) ...[
                    AppSemantics(
                      label: AppSemanticsLabels.dateDivider,
                      child: DateDivider(
                        text: DateFormatter.formatMessageDividerDate(message.date),
                      ),
                    ),
                  ],

                  AppSemantics(
                    label: AppSemanticsLabels.messageListItem,
                    child: MessageItem(
                      senderName: '${sender?.firstName ?? ''} ${sender?.lastName ?? ''}',
                      imageSrc: sender?.avatarImageSrc,
                      message: message.payload,
                      time: DateFormatter.formatSmartDate(message.date),
                      isMyMessage: sender?.userId != owner.id,
                      withExtendedData: isExpanded,
                      messageStatus: message.messageStatus,
                      conversationId: conversation.conversationId,
                      messageIndex: index,
                      imageMetaData: message.payload.contains('url')
                          ? SentImageMetaDataModel.fromJson(jsonDecode(message.payload))
                          : null,
                      attachmentMetaData: message.payload.contains('file')
                          ? SentAttachmentMetaDataModel.fromJson(jsonDecode(message.payload))
                          : null,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  bool shouldExpandMessage(int index, ConversationModel conversation) {
    if (index > 0) {
      final currentMessage = conversation.messages[index];
      final previousMessage = conversation.messages[index - 1];
      final differenceInMinutes = currentMessage.date.difference(previousMessage.date).inMinutes;

      if (previousMessage.senderId == currentMessage.senderId && differenceInMinutes.abs() < 2) {
        return false;
      }
    }

    return true;
  }

  bool shouldShowDivider(int index, ConversationModel conversation) {
    if (index == 0) return true;

    final currentMessage = conversation.messages[index];
    final lastMessage = conversation.messages[index - 1];

    if (lastMessage.date.day != currentMessage.date.day) return true;

    return false;
  }

  ConversationModel getConversationById(String conversationId) {
    final conversation = serviceLocator<GetConversationByIdUseCase>().call(widget.conversationId);
    return conversation;
  }

  Map<String, UserEntity?> getUsersFromConversation(ConversationModel conversation) {
    final senderIds = conversation.messages.map((m) => m.senderId).toSet();

    final userMap = <String, UserEntity?>{for (final id in senderIds) id: getUserById.call(id)};

    return userMap;
  }

  Future<void> scrollToBottom({bool isInit = false}) async {
    //todo: when opening a large list, there's a scroll bouncing effect.
    // It persists, even when disabling animation and setting different scroll physics.
    // It happens because the list scroll extent is changing on a large list load, so the position is
    // incorrect. Waiting for the list to load results in delay and then sudden jump.

    //recalculating the position until it's stable also did not help

    //flutter limitation.

    final controller = listViewScrollController;

    if (!controller.hasClients) return;

    final maxExtent = controller.position.maxScrollExtent + AppDimensions.expandedMessageHeight;

    if (isInit) {
      controller.jumpTo(maxExtent);
      return;
    }

    await controller.animateTo(
      maxExtent + AppDimensions.expandedMessageHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
