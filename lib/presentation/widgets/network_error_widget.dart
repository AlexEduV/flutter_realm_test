import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_asset_routes.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.normalS),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetRoutes.errorImageRoute),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.normalS),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimensions.minorL,
            children: [
              Text(
                'Whoops!',
                style: AppTextStyles.zonaPro24.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Text(
                'It seems the content is not available',
                style: AppTextStyles.zonaPro20.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
