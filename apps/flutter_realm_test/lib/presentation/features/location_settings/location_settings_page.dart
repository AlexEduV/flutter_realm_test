import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/widget_list_extension.dart';
import 'package:test_flutter_project/presentation/features/location_settings/location_settings_page_state.dart';
import 'package:test_flutter_project/presentation/features/location_settings/widgets/footer_text.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/extensions/list_extension.dart';
import '../../../l10n/l10n_keys.dart';
import '../../features/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import '../../features/account/widgets/custom_divider.dart';
import '../../features/user/user_data_state.dart';
import '../account/account_page_identifiers.dart';
import '../user/user_data_cubit.dart';
import 'location_settings_identifiers.dart';
import 'location_settings_page_cubit.dart';

class LocationSettingsPage extends StatelessWidget {
  const LocationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          context.tr(AccountPageLocaleKeys.accountItemLocation),
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
              context.tr(LocationSettingsLocaleKeys.locationUsageDescription),
              style: AppTextStyles.zonaPro14,
            ),

            const SizedBox(height: AppDimensions.normalXS),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.normalL),
              clipBehavior: Clip.antiAlias,
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  context.read<LocationSettingsPageCubit>().loadCurrentRegionByCode(
                    state.user.region,
                  );

                  return Column(
                    children: [
                      PersonalDetailsListItem(
                        title: context.tr(LocationSettingsLocaleKeys.locationSettingsItemAccess),
                        description: state.user.isLocationPermissionGranted
                            ? context.tr(L10nKeys.onLabel)
                            : context.tr(L10nKeys.offLabel),
                        icon: Icons.location_on_outlined,
                        showEnabled: state.user.isLocationPermissionGranted,
                        onTap: () => context.read<UserDataCubit>().openLocationSettings(),
                      ),

                      BlocBuilder<LocationSettingsPageCubit, LocationSettingsPageState>(
                        builder: (context, locationState) {
                          return PersonalDetailsListItem(
                            title: context.tr(
                              LocationSettingsLocaleKeys.locationSettingsItemRegion,
                            ),
                            description: context.tr(
                              '${L10nKeys.countryPrefix}${locationState.currentRegion?.locale}',
                            ),
                            icon: Icons.explore,
                            onTap: () => onRegionItemTap(state, context),
                          );
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
                    text: context.tr(
                      LocationSettingsLocaleKeys.locationSettingsPrivacyItemConditions,
                    ),
                    onTap: () => context.read<LocationSettingsPageCubit>().openUrl(
                      ApiConstants.termsAndConditionsUrl,
                    ),
                  ),
                  FooterText(
                    text: context.tr(
                      LocationSettingsLocaleKeys.locationSettingsPrivacyItemPrivacyPolicy,
                    ),
                    onTap: () => context.read<LocationSettingsPageCubit>().openUrl(
                      ApiConstants.privacyPolicyUrl,
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

  Future<void> onRegionItemTap(UserDataState state, BuildContext context) async {
    context.read<LocationSettingsPageCubit>().updateAvailableCountries();

    final currentRegion = state.user.region;
    final availableCountries = context.read<LocationSettingsPageCubit>().state.availableRegions;
    final currentIndex = availableCountries.indexWhereOrNull(
      (element) => element.code == currentRegion,
    );

    if (currentIndex == null) return;

    final region = await DialogHelper.showCountryPicker(context, availableCountries, currentIndex);

    if (!context.mounted) return;

    context.read<UserDataCubit>().updateRegion(region?.code);
  }
}
