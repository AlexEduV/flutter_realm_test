import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_text_styles.dart';
import '../../../widgets/avatar_widget.dart';

class MessageItem extends StatelessWidget {
  final String name;
  final String? imageSrc;
  final String message;
  final String time;
  final bool isMyMessage;

  const MessageItem({
    required this.name,
    required this.imageSrc,
    required this.message,
    required this.time,
    this.isMyMessage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.minorL,
        children: [
          AvatarWidget(imageSrc: imageSrc, size: AppDimensions.majorM),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.minorL,
            children: [
              Row(
                spacing: AppDimensions.minorM,
                children: [
                  Text(name, style: AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600)),

                  Text(time),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.normalS,
                  horizontal: AppDimensions.normalM,
                ),
                decoration: BoxDecoration(
                  color: isMyMessage ? Colors.blue : AppColors.whiteGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimensions.normalS),
                  ).copyWith(topLeft: Radius.zero),
                ),
                child: Text(
                  message,
                  style: isMyMessage ? const TextStyle(color: Colors.white) : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
