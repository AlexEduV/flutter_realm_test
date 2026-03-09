import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_routes.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/account_item.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/account_item_separated.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/custom_divider.dart';
import 'package:test_futter_project/presentation/pages/account/widgets/user_avatar.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../common/app_text_styles.dart';

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
            title: Text(AppLocalisations.accountPageTitle, style: AppTextStyles.zonaPro20),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(imageSrc: state.avatarImageSrc, onTap: pickImageFromGallery),

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
                          text: AppLocalisations.accountItemPersonalDetails,
                          onTap: () => context.go(AppRoutes.home + AppRoutes.personalDetails),
                        ),

                        //todo: in the personal details -> Change password
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.location_on_outlined,
                          text: AppLocalisations.accountItemLocation,
                          onTap: () => context.go(AppRoutes.home + AppRoutes.locationSettings),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.checklist_outlined,
                          text: AppLocalisations.accountItemMyItems,
                          onTap: () => context.go(AppRoutes.home + AppRoutes.myItems),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.remove_red_eye_outlined,
                          text: AppLocalisations.accountItemViewedItems,
                          onTap: () => context.go(AppRoutes.home + AppRoutes.recentlyViewed),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.cleaning_services,
                          text: AppLocalisations.accountItemClearData,
                          onTap: () => context.go(AppRoutes.home + AppRoutes.clearUserData),
                        ),
                        AccountItem(
                          textStyle: itemTextStyle,
                          icon: Icons.logout_outlined,
                          text: AppLocalisations.accountItemLogout,
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
                    title: AppLocalisations.accountItemDeleteAccount,
                    onTap: () {
                      DialogHelper.showConfirmationDialog(
                        context,
                        title: AppLocalisations.accountItemDeleteAccount,
                        description: AppLocalisations.deleteAccountDialogDescription,
                        cancelButtonTitle: AppLocalisations.deleteAccountDialogCancelLabel,
                        confirmButtonTitle: AppLocalisations.deleteAccountDialogConfirmLabel,
                        onConfirm: () async {
                          await context.read<AuthenticationCubit>().deleteAccount(state.email);

                          if (!context.mounted) return;

                          context.read<UserDataCubit>().logOutUser();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      serviceLocator<UserDataCubit>().updateAvatarImage(image.path);
    }
  }
}
