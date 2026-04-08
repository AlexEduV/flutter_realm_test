import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction, SlidableController;
import 'package:test_futter_project/common/constants/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/widgets/announcement_item/announcement_item_body.dart';

import '../../../l10n/l10n_keys.dart';

class AnnouncementListItem extends StatefulWidget {
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
  State<AnnouncementListItem> createState() => _AnnouncementListItemState();
}

class _AnnouncementListItemState extends State<AnnouncementListItem> with TickerProviderStateMixin {
  late SlidableController slidableController;

  @override
  void initState() {
    super.initState();

    slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carId = widget.car?.carId ?? '';

    final content = AnnouncementItemBody(
      car: widget.car,
      isExploreItem: widget.isExploreItem,
      user: widget.user,
    );

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: widget.isExploreItem
          ? Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
              ),
              child: Slidable(
                controller: slidableController,
                key: widget.car != null ? ValueKey(carId) : null,
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.25,
                  children: [
                    //NOTE: slidable action is not allowed semantics - 'hasSize' exception
                    SlidableAction(
                      autoClose: false,
                      onPressed: (context) => widget.onDismissed?.call(),
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
