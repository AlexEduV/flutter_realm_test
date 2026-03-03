import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/domain/models/personal_details_item_model.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../../common/app_text_styles.dart';

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
        padding: const EdgeInsets.all(AppDimensions.minorL),
        child: Container(
          margin: const EdgeInsets.all(AppDimensions.minorL),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.normalL),
          ),
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              final items = [
                PersonalDetailsItemModel(
                  title: AppLocalisations.personalDetailsItemFirstName,
                  subtitle: state.firstName,
                  icon: Icons.person_pin_outlined,
                ),
                PersonalDetailsItemModel(
                  title: AppLocalisations.personalDetailsItemLastName,
                  subtitle: state.lastName,
                  icon: Icons.person_outlined,
                ),
                //todo: add phone number and date of birth items to the state later
                // PersonalDetailsItemModel(
                //   title: 'Phone Number',
                //   subtitle: 'Test',
                //   icon: Icons.phone_outlined,
                // ),
                // PersonalDetailsItemModel(
                //   title: 'Date of Birth',
                //   subtitle: 'Test',
                //   icon: Icons.cake_outlined,
                // ),
                PersonalDetailsItemModel(
                  title: AppLocalisations.personalDetailsItemEmail,
                  subtitle: state.email,
                  icon: Icons.email_outlined,
                ),
                PersonalDetailsItemModel(
                  title: AppLocalisations.personalDetailsItemPassword,
                  subtitle: state.password.obscure(),
                  icon: Icons.password,
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
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
