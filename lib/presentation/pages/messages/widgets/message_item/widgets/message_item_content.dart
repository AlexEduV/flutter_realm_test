import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_futter_project/domain/models/sent_image_meta_data_model.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_dimensions.dart';
import '../../../../../../common/app_semantics_labels.dart';
import '../../../../../widgets/app_semantics.dart';
import 'gif_label.dart';

class MessageItemContent extends StatelessWidget {
  final bool isMyMessage;
  final bool withExtendedData;
  final String message;
  final SentAttachmentMetaDataModel? attachmentMetaData;
  final SentImageMetaDataModel? imageMetaData;

  const MessageItemContent({
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
        child: imageMetaData == null
            ? attachmentMetaData == null
                  ? Text(message, style: isMyMessage ? const TextStyle().whiten() : null)
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

                        Icon(
                          Icons.file_present_sharp,
                          color: isMyMessage ? Colors.white : null,
                          size: AppDimensions.majorS,
                        ),
                      ],
                    )
            : Stack(
                children: [
                  SizedBox(
                    width: AppDimensions.imageMessageSize,
                    height:
                        AppDimensions.imageMessageSize * (imageMetaData?.getImageFactor() ?? 1.0),
                  ),

                  const Positioned(bottom: 0.0, child: GifLabel()),
                ],
              ),
      ),
    );
  }
}
