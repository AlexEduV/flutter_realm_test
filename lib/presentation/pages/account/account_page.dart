import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/account_item.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/account_item_separated.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/custom_divider.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/user_avatar_enhanced.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../common/app_text_styles.dart';
import '../../../l10n/l10n_keys.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemTextStyle = AppTextStyles.zonaPro14.copyWith(fontWeight: FontWeight.w600);

    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (!state.isUserAuthenticated) {
          return const LoginPage();
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            title: Text(context.tr(L10nKeys.accountPageTitle), style: AppTextStyles.zonaPro20),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: AppDimensions.minorL),
                  child: UserAvatarEnhanced(
                    imageSrc: state.avatarImageSrc,
                    onTap: () => serviceLocator<UserDataCubit>().updateAvatarImage(),
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
                      style: AppTextStyles.zonaPro16.copyWith(
                        color: AppColors.placeholderColorDark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.normalS),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(AppDimensions.normalM),
                    color: Colors.white,
                    child: Column(
                      children: [
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.person_outlined,
                          text: context.tr(L10nKeys.accountItemPersonalDetails),
                          onTap: () => context.go(AppRoutes.home + AppRoutes.personalDetails),
                        ),

                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.location_on_outlined,
                          text: context.tr(L10nKeys.accountItemLocation),
                          onTap: () => context.go(AppRoutes.home + AppRoutes.locationSettings),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.checklist_outlined,
                          text: context.tr(L10nKeys.accountItemMyItems),
                          onTap: () => context.go(AppRoutes.home + AppRoutes.myItems),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.remove_red_eye_outlined,
                          text: context.tr(L10nKeys.accountItemViewedItems),
                          onTap: () => context.go(AppRoutes.home + AppRoutes.recentlyViewed),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.cleaning_services,
                          text: context.tr(L10nKeys.accountItemClearData),
                          onTap: () => context.go(AppRoutes.home + AppRoutes.clearUserData),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.logout_outlined,
                          text: context.tr(L10nKeys.accountItemLogout),
                          onTap: () async {
                            await context.read<AuthenticationCubit>().logOut();

                            if (!context.mounted) return;

                            context.read<UserDataCubit>().logOutUser();
                          },
                        ),
                      ].withDividers(divider: const CustomDivider()),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.normalS),
                  child: AccountItemSeparated(
                    title: context.tr(L10nKeys.accountItemDeleteAccount),
                    onTap: () {
                      DialogHelper.showConfirmationDialog(
                        context,
                        title: context.trRead(L10nKeys.accountItemDeleteAccount),
                        description: context.trRead(L10nKeys.deleteAccountDialogDescription),
                        cancelButtonTitle: context.trRead(L10nKeys.deleteAccountDialogCancelLabel),
                        confirmButtonTitle: context.trRead(
                          L10nKeys.deleteAccountDialogConfirmLabel,
                        ),
                        onConfirm: () async {
                          await context.read<AuthenticationCubit>().deleteAccount(state.email);

                          if (!context.mounted) return;

                          context.read<UserDataCubit>().logOutUser();
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppDimensions.normalS),
              ],
            ),
          ),
        );
      },
    );
  }
}
