import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';

import '../../../../../../common/app_dimensions.dart';

class MessageFileContent extends StatelessWidget {
  final SentAttachmentMetaDataModel? attachmentMetaData;
  final bool isMyMessage;

  const MessageFileContent({
    required this.attachmentMetaData,
    required this.isMyMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
