import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../common/app_text_styles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (!state.isUserAuthenticated) {
          return const LoginPage();
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            title: Text(AppLocalisations.accountPageTitle, style: AppTextStyles.zonaPro20),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: AppDimensions.minorL),
                child: Center(
                  child: CircleAvatar(radius: 50, backgroundColor: AppColors.placeholderColor),
                ),
              ),

              ListTile(
                title: Center(
                  child: Text(
                    '${state.firstName} ${state.lastName}',
                    style: const TextStyle(
                      color: AppColors.headerColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    state.email,
                    style: const TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),

              ListTile(
                title: Text(AppLocalisations.accountItemPersonalDetails),
                leading: const Icon(Icons.person),
              ),
              //todo: in the personal details -> Change password
              ListTile(
                title: Text(AppLocalisations.accountItemLocation),
                leading: const Icon(Icons.location_pin),
              ),
              ListTile(
                title: Text(AppLocalisations.accountItemMyItems),
                leading: const Icon(Icons.checklist),
              ),
              ListTile(
                title: Text(AppLocalisations.accountItemViewedItems),
                leading: const Icon(Icons.remove_red_eye),
              ),
              ListTile(
                title: Text(AppLocalisations.accountItemClearData),
                leading: const Icon(Icons.delete),
              ),
              ListTile(
                title: Text(AppLocalisations.accountItemLogout),
                leading: const Icon(Icons.exit_to_app_sharp),
                onTap: () async {
                  await context.read<AuthenticationCubit>().logOut();

                  if (!context.mounted) return;

                  context.read<UserDataCubit>().logOutUser();
                },
              ),
              const Spacer(),
              ListTile(
                title: Center(
                  child: Text(
                    AppLocalisations.accountItemDeleteAccount,
                    style: const TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                onTap: () async {
                  await context.read<AuthenticationCubit>().deleteAccount(state.email);

                  if (!context.mounted) return;

                  context.read<UserDataCubit>().logOutUser();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
