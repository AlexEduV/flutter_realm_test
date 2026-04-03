import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

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
              width: .infinity,
              child: Image.asset(
                AppAssetRoutes.errorImageRoute,
                fit: .cover,
                color: Colors.black.withAlpha(110), // Dark overlay
                colorBlendMode: .darken,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.majorM),
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                spacing: AppDimensions.normalL,
                children: [
                  Text(
                    'The content is not available',
                    style: AppTextStyles.zonaPro24.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'We could not display the data. Please, try again later.',
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
