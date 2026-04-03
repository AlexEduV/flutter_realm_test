import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

import '../../common/app_asset_routes.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.normalS),
      child: Column(
        spacing: AppDimensions.minorL,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(AppAssetRoutes.errorImageRoute),
              ),
            ),
          ),
          Text('Whoops!', style: AppTextStyles.zonaPro24.copyWith(fontWeight: FontWeight.w600)),
          Text(
            'It seems the content is not available',
            style: AppTextStyles.zonaPro20.copyWith(
              color: AppColors.accentColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
