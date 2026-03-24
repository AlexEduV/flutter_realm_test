import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/enums/message_status.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_futter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../widgets/avatar_widget.dart';

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
                crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (withExtendedData) ...[
                    Row(
                      spacing: AppDimensions.minorM,
                      mainAxisSize: MainAxisSize.min,
                      textDirection: isMyMessage ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        Text(
                          isMyMessage ? context.tr(L10nKeys.messageSenderYou) : senderName,
                          style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(time),
                      ],
                    ),
                  ],
                  AppSemantics(
                    label: AppSemanticsLabels.messageItemText,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.normalS,
                        horizontal: AppDimensions.normalM,
                      ),
                      decoration: BoxDecoration(
                        color: isMyMessage ? AppColors.teal : AppColors.whiteGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: isMyMessage || !withExtendedData
                              ? const Radius.circular(AppDimensions.normalS)
                              : Radius.zero,
                          topRight: !isMyMessage || !withExtendedData
                              ? const Radius.circular(AppDimensions.normalS)
                              : Radius.zero,
                          bottomLeft: const Radius.circular(AppDimensions.normalS),
                          bottomRight: const Radius.circular(AppDimensions.normalS),
                        ),
                        image: imageMetaData != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageMetaData?.url ?? ''),
                              )
                            : null,
                      ),
                      child: imageMetaData == null
                          ? attachmentMetaData == null
                                ? Text(
                                    message,
                                    style: isMyMessage ? const TextStyle().whiten() : null,
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: AppDimensions.minorS,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          attachmentMetaData?.name ?? '',
                                          style: isMyMessage ? const TextStyle().whiten() : null,
                                        ),
                                      ),

                                      const Icon(
                                        Icons.file_present_sharp,
                                        color: Colors.white,
                                        size: AppDimensions.majorS,
                                      ),
                                    ],
                                  )
                          : Stack(
                              children: [
                                SizedBox(
                                  width: AppDimensions.imageMessageSize,
                                  height: imageMetaData == null
                                      ? AppDimensions.imageMessageSize
                                      : AppDimensions.imageMessageSize *
                                            getImageFactorFromMetaData(imageMetaData),
                                ),

                                Positioned(
                                  bottom: 0.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.minorM,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(AppDimensions.normalS),
                                    ),
                                    child: Text(
                                      context.tr(L10nKeys.gifMessagePlaceholder),
                                      style: AppTextStyles.zonaPro14.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            if (withExtendedData) ...[
              AvatarWidget(imageSrc: imageSrc, size: AppDimensions.majorM, isLocal: isMyMessage),
            ] else ...[
              const SizedBox(width: AppDimensions.majorM),
            ],
          ],
        ),
      ),
    );
  }

  double getImageFactorFromMetaData(SentImageMetaDataModel? metaData) {
    if (metaData == null) return 1.0;

    final height = metaData.height;
    final width = metaData.width;

    if (width == 0) return 1.0;

    return height / width;
  }
}
