import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

import '../../../../data/models/scheme.dart';

class HomeListItem extends StatelessWidget {
  final Car? car;
  final void Function()? onDismissed;

  const HomeListItem({required this.car, required this.onDismissed, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: car != null ? ValueKey(car?.id) : null,
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => onDismissed?.call(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.contentPadding,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppDimensions.normalM),
              ),
            ),

            Text(
              '${car?.manufacturer} ${car?.model ?? ''} ${car?.year ?? ''}'.toUpperCase(),
              style: AppTextStyles.roboto24,
            ),

            Text('\$ ${car?.price.toString() ?? '0'}', style: AppTextStyles.roboto18),
          ],
        ),
      ),
    );
  }
}
