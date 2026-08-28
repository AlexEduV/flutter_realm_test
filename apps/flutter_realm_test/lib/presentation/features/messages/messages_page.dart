import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/conversation_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/models/message_model.dart';
import 'package:test_flutter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_flutter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/chat_input_bar/chat_input_bar.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/date_divider.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/empty_conversation_placeholder.dart';
import 'package:test_flutter_project/presentation/features/messages/widgets/message_item/message_item.dart';
import 'package:test_flutter_project/presentation/widgets/avatar_widget.dart';

import '../../../utils/inline_style_parser.dart';
import '../../widgets/app_semantics.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({required this.conversationId, super.key});

  final String conversationId;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final _messageInputTextController = _InlineStyleTextController();
  final _messageInputFocusNode = FocusNode();

  final _listViewScrollController = ScrollController();

  late ConversationEntity conversation;
  late OwnerEntity owner;

  @override
  void initState() {
    context.read<MessagesPageCubit>().setCurrentConversationId(widget.conversationId);

    conversation = context.read<MessagesPageCubit>().getConversationById(widget.conversationId);
    owner = context.read<MessagesPageCubit>().getOwnerById(conversation.ownerId);

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
    _messageInputFocusNode.dispose();
    _messageInputTextController.dispose();

    _listViewScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          messageTextController: _messageInputTextController,
          messageFocusNode: _messageInputFocusNode,
        ),
      ),
      body: BlocBuilder<InboxPageCubit, InboxPageState>(
        builder: (context, state) {
          final conversation = context.read<MessagesPageCubit>().getConversationById(
            widget.conversationId,
          );
          final users = context.read<MessagesPageCubit>().getUsersFromConversation(conversation);

          final messages = conversation.messages.reversed.toList();

          if (messages.isEmpty) {
            return const EmptyConversationPlaceholder();
          }

          return BlocListener<InboxPageCubit, InboxPageState>(
            listenWhen: (previous, current) {
              final prevCount =
                  previous.conversations
                      .firstWhereOrNull((c) => c.conversationId == widget.conversationId)
                      ?.messages
                      .length ??
                  0;
              final currCount =
                  current.conversations
                      .firstWhereOrNull((c) => c.conversationId == widget.conversationId)
                      ?.messages
                      .length ??
                  0;
              return currCount > prevCount;
            },
            listener: (context, state) =>
                _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 200)),
            child: AnimatedList(
              key: _listKey,
              reverse: true,
              controller: _listViewScrollController,
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
                          label: MessagesPageIds.dateDivider,
                          child: DateDivider(
                            text: context.read<MessagesPageCubit>().getMessageDividerDate(
                              message.date,
                            ),
                          ),
                        ),
                      ],

                      AppSemantics(
                        label: MessagesPageIds.messageListItem,
                        child: MessageItem(
                          senderName: '${sender?.firstName ?? ''} ${sender?.lastName ?? ''}',
                          imageSrc: sender?.avatarImageSrc,
                          message: message.payload,
                          time: context.read<MessagesPageCubit>().getMessageTime(message.date),
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
            ),
          );
        },
      ),
    );
  }

  bool shouldExpandMessage(int index, List<MessageModel> messages) {
    if (index < messages.length - 1) {
      final currentMessage = messages[index];
      final nextMessage = messages[index + 1];

      final currentMessageDate = currentMessage.date;
      final nextMessageDate = nextMessage.date;

      assert(
        currentMessageDate != null,
        'current message: dates in messages are not expected to be null',
      );
      assert(nextMessageDate != null, 'nextMessage: dates in messages are not expected to be null');

      if (currentMessageDate == null || nextMessageDate == null) return true;

      final differenceInMinutes = currentMessageDate.difference(nextMessageDate).inMinutes.abs();

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

    final nextMessageDay = nextMessage.date?.day;
    final currentMessageDay = currentMessage.date?.day;
    if (nextMessageDay != currentMessageDay) {
      return true;
    }

    return false;
  }

  void scrollToBottom({bool isInit = false}) {
    final controller = _listViewScrollController;

    if (!controller.hasClients) return;

    final minExtent = controller.position.minScrollExtent;

    if (isInit) {
      controller.jumpTo(minExtent);
      return;
    }
  }
}

class _InlineStyleTextController extends TextEditingController {
  _InlineStyleTextController();

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    return TextSpan(style: style, children: parseInlineStyles(text));
  }
}
