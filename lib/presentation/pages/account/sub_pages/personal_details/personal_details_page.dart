import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../../common/app_text_styles.dart';
import '../../widgets/custom_divider.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.accountItemPersonalDetails, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.normalM,
          vertical: AppDimensions.normalL,
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.normalL),
          clipBehavior: Clip.antiAlias,
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalDetailsListItem(
                    title: AppLocalisations.personalDetailsItemFirstName,
                    description: state.firstName,
                    icon: Icons.person_pin_outlined,
                  ),

                  PersonalDetailsListItem(
                    title: AppLocalisations.personalDetailsItemLastName,
                    description: state.lastName,
                    icon: Icons.person_outlined,
                  ),

                  //todo: add phone number and date of birth items to the state later
                  // PersonalDetailsListItem(
                  //    title: 'Phone Number',
                  //    subtitle: 'Test',
                  //    icon: Icons.phone_outlined,
                  // ),
                  //PersonalDetailsListItem(
                  //title: 'Date of Birth',
                  //   subtitle: 'Test',
                  //   icon: Icons.cake_outlined,
                  //),
                  PersonalDetailsListItem(
                    title: AppLocalisations.personalDetailsItemEmail,
                    description: state.email,
                    icon: Icons.email_outlined,
                  ),

                  PersonalDetailsListItem(
                    title: AppLocalisations.personalDetailsItemPassword,
                    description: state.password.obscure(),
                    icon: Icons.password,
                  ),
                ].withDividers(divider: const CustomDivider()),
              );
            },
          ),
        ),
      ),
    );
  }
}
