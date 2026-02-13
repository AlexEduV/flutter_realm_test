import 'package:flutter/material.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../utils/l10n.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Row(
        children: <Widget>[
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.minorL),
            child: Text(AppLocalisations.orDividerTitle),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
