import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/usecases/owners/get_owner_by_id_use_case.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import '../../../common/app_text_styles.dart';

class MessagesPage extends StatelessWidget {
  final String ownerId;

  const MessagesPage({required this.ownerId, super.key});

  @override
  Widget build(BuildContext context) {
    final owner = serviceLocator<GetOwnerByIdUseCase>().call(ownerId);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(owner.name, style: AppTextStyles.zonaPro20),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.normalS),
            child: AvatarWidget(imageSrc: owner.imageSrc, size: AppDimensions.appBarIconSize * 1.5),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: AppDimensions.majorM,
            right: AppDimensions.minorL,
            left: AppDimensions.minorL,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.minorL),
                  decoration: BoxDecoration(
                    color: AppColors.whiteGrey,
                    borderRadius: BorderRadius.circular(AppDimensions.normalM),
                  ),
                  child: const Text('Write Something...'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
