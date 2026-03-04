import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../domain/models/personal_details_item_model.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../personal_details/widgets/personal_details_list_item.dart';

class LocationSettingsPage extends StatelessWidget {
  const LocationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.accountItemLocation, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.normalM),
        child: Column(
          children: [
            const Text(
              'We use this data to calculate the distance and to get you the most relevant content.',
            ),

            const SizedBox(height: AppDimensions.minorL),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
              ),
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  final items = [
                    PersonalDetailsItemModel(
                      title: 'Location access',
                      subtitle: 'On',
                      icon: Icons.location_on_outlined,
                      showEnabled: true,
                    ),
                    PersonalDetailsItemModel(
                      title: 'Show content for country',
                      subtitle: 'The UK',
                      icon: Icons.public,
                    ),
                  ];

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(AppDimensions.minorL),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return PersonalDetailsListItem(
                        title: item.title,
                        description: item.subtitle,
                        icon: item.icon,
                        showEnabled: item.showEnabled,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
