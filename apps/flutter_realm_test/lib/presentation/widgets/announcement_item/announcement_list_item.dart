import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction;
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/widgets/announcement_item/announcement_item_body.dart';

import '../../features/l10n/l10n_keys.dart';

class AnnouncementListItem extends StatelessWidget {
  const AnnouncementListItem({
    required this.car,
    required this.user,
    required this.onDismissed,
    this.isExploreItem = true,
    super.key,
  });

  final CarEntity? car;
  final UserEntity? user;
  final void Function()? onDismissed;
  final bool isExploreItem;

  @override
  Widget build(BuildContext context) {
    final carId = car?.carId ?? '';

    final content = AnnouncementItemBody(car: car, isExploreItem: isExploreItem, user: user);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: isExploreItem
          ? DecoratedBox(
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
                      autoClose: false,
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
    );
  }
}
