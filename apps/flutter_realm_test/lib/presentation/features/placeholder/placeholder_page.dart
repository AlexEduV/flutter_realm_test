import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/placeholder/placeholder_page_identifiers.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.hourglass_empty,
              size: AppDimensions.placeholderPageIconSize,
              color: Colors.grey,
            ),
            const SizedBox(height: AppDimensions.normalM),
            Text(
              context.tr(PlaceholderPageLocaleKeys.comingSoonPlaceholderPageTitle),
              style: AppTextStyles.zonaPro24,
            ),
            const SizedBox(height: AppDimensions.minorL),
            Text(
              context.tr(PlaceholderPageLocaleKeys.comingSoonPlaceholderPageSubTitle),
              style: AppTextStyles.zonaPro16.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
