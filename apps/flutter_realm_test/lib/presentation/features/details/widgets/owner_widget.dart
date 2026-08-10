import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_params.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';
import 'package:test_flutter_project/presentation/widgets/avatar_widget.dart';

import '../../../../common/constants/app_routes.dart';
import '../../inbox/inbox_page_identifiers.dart';
import '../../l10n/l10n_keys.dart';

class OwnerWidget extends StatelessWidget {
  const OwnerWidget({required this.car, required this.user, super.key});

  final CarEntity car;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final owner = car.owner;

    final isUserNotTheOwner = owner?.id != null && owner?.id != user.userId;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.normalM),
            child: Row(
              spacing: AppDimensions.normalM,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(imageSrc: owner?.imageSrc, isLocal: !isUserNotTheOwner),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUserNotTheOwner
                            ? '${owner?.firstName ?? ''} ${owner?.lastName ?? ''}'
                            : context.tr(InboxPageLocaleKeys.messageSenderYou),
                        style: AppTextStyles.zonaPro18.copyWith(fontWeight: FontWeight.w600),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              context.tr(DetailsPageLocaleKeys.ownerSectionPersonTypeOwner),
                              style: AppTextStyles.zonaPro16Grey.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          if (car.distanceTo != null) ...[
                            const Icon(
                              Icons.location_pin,
                              size: AppDimensions.detailsPageItemIconSize,
                              color: Colors.grey,
                            ),

                            Flexible(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                '${car.distanceTo ?? ''} ${context.tr(L10nKeys.distanceAway)}',
                                style: AppTextStyles.zonaPro16Grey.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.normalL),

          if (isUserNotTheOwner) ...[
            SizedBox(
              width: double.infinity, // Makes the button full width
              child: AppSemantics(
                button: true,
                label: DetailsPageIds.detailsPageContactButton,
                child: ElevatedButton(
                  onPressed: () => onSendMessageButtonTap(owner, context),
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
                    context.tr(DetailsPageLocaleKeys.ownerSectionContactButtonTitle),
                    style: AppTextStyles.zonaPro16,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void onSendMessageButtonTap(OwnerEntity? owner, BuildContext context) {
    final ownerId = owner?.id;
    if (ownerId == null) return;

    final conversationId = context.read<DetailsPageCubit>().getConversationId(ownerId);

    context.go(
      '${AppRoutes.home}${AppRoutes.details}/${AppRoutes.inbox}',
      extra: InboxPageParams(conversationId: conversationId),
    );
  }
}
