import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/widget_list_extension.dart';
import 'package:test_flutter_project/features/location_settings_page/location_settings_identifiers.dart';
import 'package:test_flutter_project/features/location_settings_page/location_settings_page_cubit.dart';
import 'package:test_flutter_project/features/location_settings_page/widgets/footer_text.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../../common/constants/api_constants.dart';
import '../../common/extensions/list_extension.dart';
import '../../l10n/l10n_keys.dart';
import '../../presentation/bloc/user/user_data_cubit.dart';
import '../../presentation/bloc/user/user_data_state.dart';
import '../../presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import '../../presentation/pages/account/widgets/custom_divider.dart';

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
                  final region = context.read<LocationSettingsPageCubit>().getRegionByCode(
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

                      PersonalDetailsListItem(
                        title: context.tr(LocationSettingsLocaleKeys.locationSettingsItemRegion),
                        description: context.tr('${L10nKeys.countryPrefix}${region?.locale}'),
                        icon: Icons.explore,
                        onTap: () => onRegionItemTap(state, context),
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
                    url: ApiConstants.termsAndConditionsUrl,
                  ),
                  FooterText(
                    text: context.tr(
                      LocationSettingsLocaleKeys.locationSettingsPrivacyItemPrivacyPolicy,
                    ),
                    url: ApiConstants.privacyPolicyUrl,
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
    final availableCountries = context.read<LocationSettingsPageCubit>().getAvailableCountries();

    final currentRegion = state.user.region;
    final currentIndex = availableCountries.indexWhereOrNull(
      (element) => element.code == currentRegion,
    );

    if (currentIndex == null) return;

    final region = await DialogHelper.showCountryPicker(context, availableCountries, currentIndex);

    if (!context.mounted) return;

    context.read<UserDataCubit>().updateRegion(region?.code);
  }
}
