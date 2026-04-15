import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/models/conversation_model.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_flutter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_flutter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/users/get_user_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/controllers/inline_style_text_controller.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/chat_input_bar/chat_input_bar.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/date_divider.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/empty_conversation_placeholder.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/message_item.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';
import 'package:test_flutter_project/presentation/widgets/avatar_widget.dart';

import '../../../common/constants/app_text_styles.dart';
import '../../../utils/date_formatter.dart';

class MessagesPage extends StatefulWidget {
  final String conversationId;

  const MessagesPage({required this.conversationId, super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final messageInputTextController = InlineStyleTextController();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //todo: maybe I should save the scroll position on exit, and do not scroll initially, only on
      // adding a message

      //the controller is assigned in the initial frame, so the post frame is needed;
      scrollToBottom(isInit: true);
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
          listKey: _listKey,
          onMessageSent: scrollToBottom,
          messageTextController: messageInputTextController,
          messageFocusNode: messageInputFocusNode,
        ),
      ),
      body: BlocBuilder<InboxPageCubit, InboxPageState>(
        builder: (context, state) {
          final conversation = getConversationById(widget.conversationId);
          final users = serviceLocator<ExtractUsersFromConversationUseCase>().call(conversation);

          final messages = conversation.messages.reversed.toList();

          if (messages.isEmpty) {
            return const EmptyConversationPlaceholder();
          }

          return AnimatedList(
            key: _listKey,
            reverse: true,
            controller: listViewScrollController,
            padding: const EdgeInsets.only(
              bottom: AppDimensions.bottomMessageBarHeight + AppDimensions.majorXL,
            ),
            initialItemCount: messages.length,
            itemBuilder: (context, index, animation) {
              final message = messages[index];
              final isExpanded = shouldExpandMessage(index, messages);
              final sender = users[message.senderId];

              final showDivider = shouldShowDivider(index, messages);

              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              );

              // Build a list of widgets: divider + message item
              return SizeTransition(
                axisAlignment: -1.0,
                sizeFactor: curvedAnimation,
                child: Column(
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool shouldExpandMessage(int index, List<MessageModel> messages) {
    if (index < messages.length - 1) {
      final currentMessage = messages[index];
      final nextMessage = messages[index + 1];
      final differenceInMinutes = currentMessage.date.difference(nextMessage.date).inMinutes.abs();

      if (nextMessage.senderId == currentMessage.senderId && differenceInMinutes < 2) {
        return false;
      }
    }

    return true;
  }

  bool shouldShowDivider(int index, List<MessageModel> messages) {
    if (index == messages.length - 1) return true; // Last message (oldest)

    final currentMessage = messages[index];
    final nextMessage = messages[index + 1];

    final nextMessageDay = nextMessage.date.day;
    final currentMessageDay = currentMessage.date.day;
    if (nextMessageDay != currentMessageDay) {
      return true;
    }

    return false;
  }

  ConversationModel getConversationById(String conversationId) {
    final conversation = serviceLocator<GetConversationByIdUseCase>().call(widget.conversationId);
    return conversation;
  }

  void scrollToBottom({bool isInit = false}) {
    final controller = listViewScrollController;

    if (!controller.hasClients) return;

    final minExtent = controller.position.minScrollExtent;

    if (isInit) {
      controller.jumpTo(minExtent);
      return;
    }
  }
}
