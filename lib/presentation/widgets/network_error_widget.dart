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
              width: double.infinity,
              child: Image.asset(
                AppAssetRoutes.errorImageRoute,
                fit: BoxFit.cover,
                color: Colors.black.withAlpha(90), // Dark overlay
                colorBlendMode: BlendMode.darken,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.majorM),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppDimensions.normalS,
                children: [
                  Text(
                    'Whoops!',
                    style: AppTextStyles.zonaPro24.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'It seems the content is not available',
                    style: AppTextStyles.zonaPro18.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
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
