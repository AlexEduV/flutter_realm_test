import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/account_item.dart';
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
          body: SingleChildScrollView(
            child: Column(
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
                      style: AppTextStyles.zonaPro18.copyWith(color: AppColors.headerColor),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      state.email,
                      style: AppTextStyles.zonaPro16.copyWith(color: AppColors.accentColor),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppDimensions.minorL),
                  ),
                  margin: const EdgeInsets.all(AppDimensions.normalM),
                  child: Column(
                    children: [
                      AccountItem(
                        icon: Icons.person_outlined,
                        text: AppLocalisations.accountItemPersonalDetails,
                        onTap: () => context.go(AppRoutes.home + AppRoutes.personalDetails),
                      ),

                      //todo: in the personal details -> Change password
                      AccountItem(
                        icon: Icons.location_on_outlined,
                        text: AppLocalisations.accountItemLocation,
                      ),
                      AccountItem(
                        icon: Icons.checklist_outlined,
                        text: AppLocalisations.accountItemMyItems,
                      ),
                      AccountItem(
                        icon: Icons.remove_red_eye_outlined,
                        text: AppLocalisations.accountItemViewedItems,
                      ),
                      AccountItem(
                        icon: Icons.delete_outline,
                        text: AppLocalisations.accountItemClearData,
                      ),
                      AccountItem(
                        icon: Icons.logout_outlined,
                        text: AppLocalisations.accountItemLogout,
                        onTap: () async {
                          await context.read<AuthenticationCubit>().logOut();

                          if (!context.mounted) return;

                          context.read<UserDataCubit>().logOutUser();
                        },
                      ),
                      AccountItem(
                        text: AppLocalisations.accountItemDeleteAccount,
                        textStyle: AppTextStyles.zonaPro14.copyWith(color: AppColors.accentColor),
                        onTap: () async {
                          await context.read<AuthenticationCubit>().deleteAccount(state.email);

                          if (!context.mounted) return;

                          context.read<UserDataCubit>().logOutUser();
                        },
                        isCentered: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
