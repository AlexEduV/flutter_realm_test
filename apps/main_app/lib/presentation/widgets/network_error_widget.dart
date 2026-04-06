import 'package:flutter/material.dart';
import 'package:test_futter_project/common/constants/app_asset_routes.dart';
import 'package:test_futter_project/common/constants/app_dimensions.dart';
import 'package:test_futter_project/common/constants/app_text_styles.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS).copyWith(bottom: AppDimensions.majorS),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(AppDimensions.normalM),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppAssetRoutes.errorImageRoute,
                fit: BoxFit.cover,
                color: Colors.black.withAlpha(140), // Dark overlay
                colorBlendMode: BlendMode.darken,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.majorM),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppDimensions.normalL,
                children: [
                  Text(
                    context.tr(L10nKeys.noContentWidgetTitle),
                    style: AppTextStyles.zonaPro24.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    context.tr(L10nKeys.noContentWidgetSubtitle),
                    style: AppTextStyles.zonaPro16.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
