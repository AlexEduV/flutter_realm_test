import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_constants.dart';
import 'package:test_flutter_project/common/enums/message_status.dart';
import 'package:test_flutter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_flutter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/widgets/message_content.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/widgets/message_info_row.dart';
import 'package:test_flutter_project/presentation/widgets/skip_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/constants/app_dimensions.dart';
import '../../../../widgets/avatar_widget.dart';

class MessageItem extends StatelessWidget {
  final String senderName;
  final String? imageSrc;
  final String message;
  final SentImageMetaDataModel? imageMetaData;
  final SentAttachmentMetaDataModel? attachmentMetaData;
  final String time;
  final bool isMyMessage;
  final bool withExtendedData;
  final MessageStatus messageStatus;
  final String conversationId;
  final int messageIndex;

  const MessageItem({
    required this.senderName,
    required this.imageSrc,
    required this.message,
    required this.messageStatus,
    required this.time,
    required this.messageIndex,
    required this.conversationId,
    this.isMyMessage = true,
    this.withExtendedData = true,
    this.imageMetaData,
    this.attachmentMetaData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppDimensions.normalS,
        left: AppDimensions.normalS,
        top: withExtendedData ? AppDimensions.normalS : 0.0,
        bottom: AppDimensions.minorS,
      ),
      child: SkipWidget(
        skip: AppConstants.kIsTest,
        child: VisibilityDetector(
          onVisibilityChanged: (info) {
            if (isMyMessage) return;
            if (messageStatus == MessageStatus.read) return;

            if (info.visibleFraction > 0.75) {
              //update message status to 'read'
              context.read<InboxPageCubit>().markMessageAsRead(conversationId, messageIndex);
            }
          },
          key: ValueKey('message-${message.hashCode}'),
          child: Row(
            textDirection: isMyMessage ? TextDirection.ltr : TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.minorL,
            mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: AppDimensions.minorS,
                  crossAxisAlignment: isMyMessage
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (withExtendedData) ...[
                      MessageInfoRow(time: time, isMyMessage: isMyMessage, senderName: senderName),
                    ],

                    MessageContent(
                      isMyMessage: isMyMessage,
                      withExtendedData: withExtendedData,
                      message: message,
                      attachmentMetaData: attachmentMetaData,
                      imageMetaData: imageMetaData,
                    ),
                  ],
                ),
              ),

              AvatarWidget(
                imageSrc: imageSrc,
                size: AppDimensions.majorM,
                isLocal: isMyMessage,
                showPlaceholder: !withExtendedData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
