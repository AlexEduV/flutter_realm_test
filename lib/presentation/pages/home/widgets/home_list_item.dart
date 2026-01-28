import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'
    show ActionPane, DrawerMotion, Slidable, SlidableAction;
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/utils/l10n.dart';

class HomeListItem extends StatelessWidget {
  final CarEntity? car;
  final void Function()? onDismissed;

  const HomeListItem({required this.car, required this.onDismissed, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: car != null ? ValueKey(car?.carId) : null,
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => onDismissed?.call(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalisations.deleteButtonTitle,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.contentPadding,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppDimensions.normalM),
                  ),
                ),

                if (car?.isVerified ?? false) ...[
                  Positioned(
                    top: AppDimensions.normalXS,
                    right: AppDimensions.normalXS,
                    child: Container(
                      padding: EdgeInsets.all(AppDimensions.minorS),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.check, color: Colors.green, size: 24),
                    ),
                  ),
                ],
              ],
            ),

            Text(
              '${car?.manufacturer} ${car?.model ?? ''} ${car?.year ?? ''}'.toUpperCase(),
              style: AppTextStyles.zonaPro24,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '\$ ${car?.price ?? 0} ', style: AppTextStyles.zonaPro20),
                      if (car?.isHotPromotion ?? false)
                        getSpanIcon(icon: Icons.whatshot, color: Colors.redAccent),
                    ],
                  ),
                ),

                Text.rich(
                  TextSpan(
                    children: [
                      getSpanIcon(icon: Icons.location_pin),
                      TextSpan(
                        text: ' ${car?.distanceTo ?? 0} ${AppLocalisations.distanceWidgetText}',
                        style: AppTextStyles.zonaPro20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  WidgetSpan getSpanIcon({required IconData icon, Color? color}) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
      child: Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.minorM),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
