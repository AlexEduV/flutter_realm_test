import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/custom_divider.dart';

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
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Container(
          margin: const EdgeInsets.all(AppDimensions.minorL),
          padding: const EdgeInsets.all(AppDimensions.minorL),
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
                ),
                PersonalDetailsItemModel(
                  title: 'Show content for country',
                  subtitle: 'The UK',
                  icon: Icons.public,
                ),
              ];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalDetailsListItem(
                    icon: items[0].icon,
                    title: items[0].title,
                    description: items[0].subtitle,
                  ),
                  const CustomDivider(),
                  PersonalDetailsListItem(
                    icon: items[1].icon,
                    title: items[1].title,
                    description: items[1].subtitle,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
