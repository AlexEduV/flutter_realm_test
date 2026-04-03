import 'package:flutter/material.dart';

import '../../../../../../common/constants/app_dimensions.dart';
import '../../../../../../domain/models/sent_image_meta_data_model.dart';
import 'gif_label.dart';

class MessageGifContent extends StatelessWidget {
  final SentImageMetaDataModel? imageMetaData;

  const MessageGifContent({required this.imageMetaData, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: AppDimensions.imageMessageSize,
          height: AppDimensions.imageMessageSize * (imageMetaData?.getImageFactor() ?? 1.0),
        ),

        const Positioned(bottom: 0.0, child: GifLabel()),
      ],
    );
  }
}
