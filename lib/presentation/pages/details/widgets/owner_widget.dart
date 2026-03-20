import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_routes.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../l10n/l10n_keys.dart';

class OwnerWidget extends StatelessWidget {
  final CarEntity car;

  const OwnerWidget({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    final owner = car.owner;

    return Container(
      padding: const EdgeInsets.only(top: AppDimensions.normalL),
      decoration: const BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.normalL),
          topLeft: Radius.circular(AppDimensions.normalL),
          bottomRight: Radius.circular(AppDimensions.normalXL),
          bottomLeft: Radius.circular(AppDimensions.normalXL),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: Row(
              spacing: AppDimensions.normalM,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(imageSrc: owner?.imageSrc),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${owner?.firstName ?? ''} ${owner?.lastName ?? ''}',
                        style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              context.tr(L10nKeys.ownerSectionPersonTypeOwner),
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.location_pin,
                            size: AppDimensions.detailsPageItemIconSize,
                            color: Colors.grey,
                          ),

                          Flexible(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              '${car.distanceTo ?? ''} ${context.tr(L10nKeys.distanceWidgetText)}',
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.normalL),

          SizedBox(
            width: double.infinity, // Makes the button full width
            child: AppSemantics(
              button: true,
              label: AppSemanticsLabels.detailsPageContactButton,
              child: ElevatedButton(
                onPressed: () {
                  final ownerId = owner?.id;
                  if (ownerId == null) return;

                  final conversationId = serviceLocator<GetConversationByOwnerIdUseCase>()
                      .call(ownerId)
                      .conversationId;

                  context.go(
                    '${AppRoutes.home}${AppRoutes.details}/${AppRoutes.inbox}',
                    extra: conversationId,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.normalM,
                  ), // Button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.normalXL,
                    ), // Optional rounded corners
                  ),
                  backgroundColor: AppColors.headerColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  context.tr(L10nKeys.ownerSectionContactButtonTitle),
                  style: AppTextStyles.zonaPro16,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
