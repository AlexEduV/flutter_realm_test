import 'package:flutter/material.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Favorites', style: AppTextStyles.zonaPro30),
        backgroundColor: AppColors.scaffoldColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppDimensions.normalL),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: AppDimensions.normalL,
                left: AppDimensions.normalL,
                right: AppDimensions.normalL,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.normalXL),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.normalM),
                child: Row(
                  children: [
                    // Car Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: AppColors.placeholderColor,
                        width: AppDimensions.favoriteItemPictureSize,
                        height: AppDimensions.favoriteItemPictureSize,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.normalM),
                    // Car Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Honda Civic 2007', style: AppTextStyles.zonaPro18),
                          const SizedBox(height: AppDimensions.minorL),
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: AppDimensions.normalM,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: AppDimensions.minorL),
                              Text(
                                'Sedan',
                                style: AppTextStyles.zonaPro14.copyWith(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimensions.normalL),
                          Text(
                            '\$ 20 000',
                            style: AppTextStyles.zonaPro16.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    // Favorite Icon
                    const SizedBox(
                      width: AppDimensions.favoriteButtonSize,
                      height: AppDimensions.favoriteButtonSize,
                      child: Icon(Icons.favorite, color: AppColors.gold),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
