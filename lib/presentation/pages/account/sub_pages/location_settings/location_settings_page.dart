import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/data/data_sources/mock_region_service.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/region_ui_model.dart';
import 'package:test_futter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/widgets/footer_text.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n_keys.dart';
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
        title: Text(context.tr(L10nKeys.accountItemLocation), style: AppTextStyles.zonaPro20),
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

            Text(context.tr(L10nKeys.locationUsageDescription), style: AppTextStyles.zonaPro14),

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
                        title: context.tr(L10nKeys.locationSettingsItemAccess),
                        description: state.isLocationPermissionGranted
                            ? context.tr(L10nKeys.onLabel)
                            : context.tr(L10nKeys.offLabel),
                        icon: Icons.location_on_outlined,
                        showEnabled: state.isLocationPermissionGranted,
                      ),

                      PersonalDetailsListItem(
                        title: context.tr(L10nKeys.locationSettingsItemRegion),
                        description: context.tr('${L10nKeys.countryPrefix}${region?.locale}'),
                        icon: Icons.language,
                        onTap: () async {
                          final regions = MockRegionService.regions;

                          final availableCountries = regions
                              .map(
                                (element) => RegionUiModel(
                                  code: element.locale,
                                  countryName: serviceLocator<AppLocalisationsCubit>()
                                      .getLocalisationByKey(
                                        '${L10nKeys.countryPrefix}${element.locale}',
                                      ),
                                ),
                              )
                              .toList();

                          final currentRegion = context.read<UserDataCubit>().user.region;
                          final currentIndex = availableCountries.indexWhere(
                            (element) => element.code == currentRegion,
                          );

                          final region = await DialogHelper.showCountryPicker(
                            context,
                            availableCountries,
                            currentIndex,
                          );

                          if (region == null) return;
                          if (!context.mounted) return;

                          final locale = region.code;

                          context.read<UserDataCubit>().updateRegion(locale);
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
                  FooterText(text: context.tr(L10nKeys.locationSettingsPrivacyItemConditions)),
                  FooterText(text: context.tr(L10nKeys.locationSettingsPrivacyItemPrivacyPolicy)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
