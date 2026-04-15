import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/common/extensions/widget_list_extension.dart';
import 'package:test_flutter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../../../../../common/constants/app_text_styles.dart';
import '../../../../../l10n/l10n_keys.dart';
import '../../widgets/custom_divider.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          context.tr(L10nKeys.accountItemPersonalDetails),
          style: AppTextStyles.zonaPro20,
        ),
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
                    title: context.tr(L10nKeys.personalDetailsItemFirstName),
                    description: state.firstName,
                    icon: Icons.person_pin_outlined,
                    onTap: () => DialogHelper.showEditDialog(
                      context,
                      title: context.trRead(L10nKeys.personalDetailsItemFirstName),
                      initialValue: state.firstName,
                      confirmButtonTitle: context.trRead(L10nKeys.confirmLabel),
                      cancelButtonTitle: context.trRead(L10nKeys.cancelLabel),
                      onConfirm: context.read<UserDataCubit>().setFirstName,
                      validationCallback: (newValue) {
                        return context.read<AuthenticationCubit>().validateFullName(
                          newValue,
                          false,
                        );
                      },
                    ),
                  ),

                  PersonalDetailsListItem(
                    title: context.tr(L10nKeys.personalDetailsItemLastName),
                    description: state.lastName,
                    icon: Icons.person_outlined,
                    onTap: () => DialogHelper.showEditDialog(
                      context,
                      title: context.trRead(L10nKeys.personalDetailsItemLastName),
                      initialValue: state.lastName,
                      confirmButtonTitle: context.trRead(L10nKeys.confirmLabel),
                      cancelButtonTitle: context.trRead(L10nKeys.cancelLabel),
                      onConfirm: context.read<UserDataCubit>().setLastName,
                      validationCallback: (newValue) {
                        return context.read<AuthenticationCubit>().validateFullName(
                          newValue,
                          false,
                        );
                      },
                    ),
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
                    title: context.tr(L10nKeys.personalDetailsItemEmail),
                    description: state.email,
                    icon: Icons.email_outlined,
                    onTap: () => DialogHelper.showEditDialog(
                      context,
                      title: context.trRead(L10nKeys.personalDetailsItemEmail),
                      initialValue: state.email,
                      confirmButtonTitle: context.trRead(L10nKeys.confirmLabel),
                      cancelButtonTitle: context.trRead(L10nKeys.cancelLabel),
                      onConfirm: context.read<UserDataCubit>().setEmail,
                      validationCallback: (newValue) {
                        return context.read<AuthenticationCubit>().validateEmail(newValue, false);
                      },
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),

                  PersonalDetailsListItem(
                    title: context.tr(L10nKeys.personalDetailsItemPassword),
                    description: state.password.obscure(),
                    icon: Icons.password,
                    onTap: () => DialogHelper.showEditPasswordDialog(
                      context,
                      title: context.trRead(L10nKeys.personalDetailsItemPassword),
                      confirmButtonTitle: context.trRead(L10nKeys.confirmLabel),
                      cancelButtonTitle: context.trRead(L10nKeys.cancelLabel),
                      onConfirm: context.read<UserDataCubit>().setPassword,
                      validationCallback: (newValue) {
                        return context.read<AuthenticationCubit>().validatePassword(
                          newValue,
                          false,
                        );
                      },
                    ),
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
