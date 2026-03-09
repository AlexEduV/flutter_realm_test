import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/data/data_sources/mock_region_service.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/widgets/footer_text.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';
import 'package:test_futter_project/utils/localisation_util.dart';

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
        title: Text(
          AppLocalisations.of(context).accountItemLocation,
          style: AppTextStyles.zonaPro20,
        ),
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

            Text(
              AppLocalisations.of(context).locationUsageDescription,
              style: AppTextStyles.zonaPro14,
            ),

            const SizedBox(height: AppDimensions.normalXS),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.normalL),
              clipBehavior: Clip.antiAlias,
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  final region = serviceLocator<GetRegionByCodeUseCase>().call(state.region);

                  return Column(
                    children: [
                      PersonalDetailsListItem(
                        title: AppLocalisations.of(context).locationSettingsItemAccess,
                        description: state.isLocationPermissionGranted
                            ? AppLocalisations.of(context).onLabel
                            : AppLocalisations.of(context).offLabel,
                        icon: Icons.location_on_outlined,
                        showEnabled: state.isLocationPermissionGranted,
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.of(context).locationSettingsItemRegion,
                        description: region?.countryName ?? '',
                        icon: Icons.language,
                        onTap: () async {
                          //open the picker
                          final pickedRegion = await DialogHelper.showTextPicker(
                            context,
                            MockRegionService.regions
                                .map((element) => element.countryName)
                                .toList(),
                          );

                          if (pickedRegion == null) return;

                          if (!context.mounted) return;

                          final localeName = MockRegionService.regions
                              .firstWhere((element) => element.countryName == pickedRegion)
                              .locale;
                          context.read<UserDataCubit>().updateRegion(localeName);

                          await LocalisationUtil.init(localeName);
                        },
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
                  FooterText(
                    text: AppLocalisations.of(context).locationSettingsPrivacyItemConditions,
                  ),
                  FooterText(
                    text: AppLocalisations.of(context).locationSettingsPrivacyItemPrivacyPolicy,
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
