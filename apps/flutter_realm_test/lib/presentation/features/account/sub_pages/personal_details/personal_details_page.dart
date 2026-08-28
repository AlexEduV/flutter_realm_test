import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/common/extensions/widget_list_extension.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../../../../features/account/widgets/custom_divider.dart';
import '../../../l10n/l10n_keys.dart';
import '../../account_page_identifiers.dart';

class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(AccountPageLocaleKeys.accountItemPersonalDetails),
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
                    title: context.tr(AccountPageLocaleKeys.personalDetailsItemFirstName),
                    description: state.user.firstName,
                    icon: Icons.person_pin_outlined,
                    onTap: () => DialogHelper.showEditPersonalInfoDialog(
                      context,
                      title: context.trRead(AccountPageLocaleKeys.personalDetailsItemFirstName),
                      initialValue: state.user.firstName,
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
                    title: context.tr(AccountPageLocaleKeys.personalDetailsItemLastName),
                    description: state.user.lastName,
                    icon: Icons.person_outlined,
                    onTap: () => DialogHelper.showEditPersonalInfoDialog(
                      context,
                      title: context.trRead(AccountPageLocaleKeys.personalDetailsItemLastName),
                      initialValue: state.user.lastName,
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
                    title: context.tr(AccountPageLocaleKeys.personalDetailsItemEmail),
                    description: state.user.email,
                    icon: Icons.email_outlined,
                    onTap: () => DialogHelper.showEditPersonalInfoDialog(
                      context,
                      title: context.trRead(AccountPageLocaleKeys.personalDetailsItemEmail),
                      initialValue: state.user.email,
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
                    title: context.tr(AccountPageLocaleKeys.personalDetailsItemPassword),
                    description: state.user.password.obscure(),
                    icon: Icons.password,
                    onTap: () => DialogHelper.showEditPasswordDialog(
                      context,
                      title: context.trRead(AccountPageLocaleKeys.personalDetailsItemPassword),
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
