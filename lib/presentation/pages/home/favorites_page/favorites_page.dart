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
      body: ListView.builder(
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
                    child: Container(color: AppColors.placeholderColor, width: 100, height: 100),
                  ),
                  const SizedBox(width: AppDimensions.normalM),
                  // Car Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Civic', style: AppTextStyles.zonaPro18),
                        const SizedBox(height: AppDimensions.minorM),
                        Text('Honda', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                        const SizedBox(height: AppDimensions.minorL),
                        Row(
                          children: [
                            Icon(Icons.directions_car, size: 16, color: Colors.grey[700]),
                            const SizedBox(width: AppDimensions.minorL),
                            Text('Sedan', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.normalL),
                        const Text(
                          '20 000',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Favorite Icon
                  const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: AppDimensions.favoriteButtonSize,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
