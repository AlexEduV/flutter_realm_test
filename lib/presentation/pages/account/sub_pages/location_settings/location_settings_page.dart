import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';

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
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.normalM,
          vertical: AppDimensions.normalL,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.minorS),

            Text(AppLocalisations.locationUsageDescription, style: AppTextStyles.zonaPro14),

            const SizedBox(height: AppDimensions.normalXS),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
              ),
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  final region = serviceLocator<RegionRepository>().getRegionByCode(state.region);

                  final items = [
                    PersonalDetailsItemModel(
                      title: AppLocalisations.locationSettingsItemAccess,
                      subtitle: state.isLocationPermissionGranted
                          ? AppLocalisations.onLabel
                          : AppLocalisations.offLabel,
                      icon: Icons.location_on_outlined,
                      showEnabled: state.isLocationPermissionGranted,
                    ),
                    PersonalDetailsItemModel(
                      title: AppLocalisations.locationSettingsItemRegion,
                      subtitle: region?.countryName ?? '',
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

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.normalS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(AppLocalisations.locationSettingsPrivacyItemConditions),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(AppLocalisations.locationSettingsPrivacyItemPrivacyPolicy),
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
