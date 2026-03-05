import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_semantics_labels.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/repositories/region_repository.dart';
import 'package:test_futter_project/presentation/widgets/app_semantics.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../widgets/custom_divider.dart';
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

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.normalL),
              clipBehavior: Clip.antiAlias,
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  final region = serviceLocator<RegionRepository>().getRegionByCode(state.region);

                  return Column(
                    children: [
                      PersonalDetailsListItem(
                        title: AppLocalisations.locationSettingsItemAccess,
                        description: state.isLocationPermissionGranted
                            ? AppLocalisations.onLabel
                            : AppLocalisations.offLabel,
                        icon: Icons.location_on_outlined,
                        showEnabled: state.isLocationPermissionGranted,
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.locationSettingsItemRegion,
                        description: region?.countryName ?? '',
                        icon: Icons.public,
                      ),
                    ].withDividers(divider: const CustomDivider()),
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
                  AppSemantics(
                    label: AppSemanticsLabels.privacyLinkItem,
                    child: InkWell(
                      onTap: () {},
                      child: Text(AppLocalisations.locationSettingsPrivacyItemConditions),
                    ),
                  ),
                  AppSemantics(
                    label: AppSemanticsLabels.privacyLinkItem,
                    child: InkWell(
                      onTap: () {},
                      child: Text(AppLocalisations.locationSettingsPrivacyItemPrivacyPolicy),
                    ),
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
