import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';
import 'package:test_futter_project/presentation/widgets/avatar_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_routes.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../l10n/l10n_keys.dart';

class OwnerWidget extends StatelessWidget {
  final CarEntity car;
  final UserEntity user;

  const OwnerWidget({required this.car, required this.user, super.key});

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
                            : context.tr(L10nKeys.messageSenderYou),
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

          if (isUserNotTheOwner) ...[
            SizedBox(
              width: double.infinity, // Makes the button full width
              child: AppSemantics(
                button: true,
                label: AppSemanticsLabels.detailsPageContactButton,
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
                    context.tr(L10nKeys.ownerSectionContactButtonTitle),
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

    final conversationId = serviceLocator<GetConversationByOwnerIdUseCase>()
        .call(ownerId)
        .conversationId;

    context.go('${AppRoutes.home}${AppRoutes.details}/${AppRoutes.inbox}', extra: conversationId);
  }
}

@Preview(
  group: 'Owner Widget',
  name: 'Normal',
  brightness: Brightness.light,
  size: Size.fromWidth(390),
)
Widget preview() => _basePreview(isOwner: false);

@Preview(
  group: 'Owner Widget',
  name: 'User is Owner',
  brightness: Brightness.light,
  size: Size.fromWidth(390),
)
Widget previewUserIsOwner() => _basePreview(isOwner: true);

Widget _basePreview({required bool isOwner}) {
  final appLocalisationsCubit = AppLocalisationsCubit();
  appLocalisationsCubit.load({
    L10nKeys.messageSenderYou: 'You',
    L10nKeys.ownerSectionPersonTypeOwner: 'Owner',
    L10nKeys.distanceWidgetText: 'km',
    L10nKeys.ownerSectionContactButtonTitle: 'Send a message',
  });

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.normalS),
              child: OwnerWidget(
                car: CarEntity.empty().copyWith(
                  distanceTo: 5,
                  owner: OwnerEntity(
                    id: '1', // Fixed ID
                    firstName: 'John',
                    lastName: 'Doe',
                    linkedItemIds: [],
                  ),
                ),
                user: UserEntity.initial(
                  userId: isOwner ? '1' : '2', // Toggle this to change the view
                  firstName: 'Alexander',
                  lastName: 'Hamilton',
                  email: 'mock@example.com',
                  password: 'pass',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
