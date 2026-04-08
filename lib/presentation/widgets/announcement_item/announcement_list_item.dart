import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction;
import 'package:test_futter_project/common/constants/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/widgets/announcement_item/announcement_item_body.dart';

import '../../../l10n/l10n_keys.dart';

class AnnouncementListItem extends StatelessWidget {
  final CarEntity? car;
  final UserEntity? user;
  final void Function()? onDismissed;
  final bool isExploreItem;

  const AnnouncementListItem({
    required this.car,
    required this.user,
    required this.onDismissed,
    this.isExploreItem = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final carId = car?.carId ?? '';

    final content = AnnouncementItemBody(car: car, isExploreItem: isExploreItem, user: user);

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalS),
        child: isExploreItem
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(AppDimensions.normalL),
                ),
                child: Slidable(
                  key: car != null ? ValueKey(carId) : null,
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      //NOTE: slidable action is not allowed semantics - 'hasSize' exception
                      SlidableAction(
                        onPressed: (context) => onDismissed?.call(),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        icon: Icons.close,
                        label: context.tr(L10nKeys.deleteButtonTitle),
                      ),
                    ],
                  ),
                  child: content,
                ),
              )
            : content,
      ),
    );
  }
}
