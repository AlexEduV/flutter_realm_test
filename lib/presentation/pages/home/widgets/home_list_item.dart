import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_futter_project/common/app_constants.dart';

import '../../../../data/models/scheme.dart';

class HomeListItem extends StatelessWidget {
  final Car car;
  final void Function() onDismissed;

  const HomeListItem({required this.car, required this.onDismissed, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(car.id),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => onDismissed(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text('${car.manufacturer} ${car.model ?? ''} ${car.year ?? ''}')),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppDimensions.contentPadding),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
