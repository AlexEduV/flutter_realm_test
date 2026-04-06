import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_futter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item/widgets/message_file_content.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item/widgets/message_gif_content.dart';

import '../../../../../../common/constants/app_colors.dart';
import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../common/constants/app_semantics_labels.dart';
import '../../../../../controllers/inline_style_text_controller.dart';
import '../../../../../widgets/app_semantics.dart';

class MessageContent extends StatelessWidget {
  final bool isMyMessage;
  final bool withExtendedData;
  final String message;
  final SentAttachmentMetaDataModel? attachmentMetaData;
  final SentImageMetaDataModel? imageMetaData;

  const MessageContent({
    required this.isMyMessage,
    required this.withExtendedData,
    required this.message,
    super.key,
    this.attachmentMetaData,
    this.imageMetaData,
  });

  @override
  Widget build(BuildContext context) {
    return AppSemantics(
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
              ? DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageMetaData?.url ?? ''))
              : null,
        ),
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    if (imageMetaData != null) {
      return MessageGifContent(imageMetaData: imageMetaData);
    }

    if (attachmentMetaData != null) {
      return MessageFileContent(attachmentMetaData: attachmentMetaData, isMyMessage: isMyMessage);
    }

    return Text.rich(
      TextSpan(children: InlineStyleTextController.parseText(message)),
      style: isMyMessage ? const TextStyle().whiten() : null,
    );
  }
}
