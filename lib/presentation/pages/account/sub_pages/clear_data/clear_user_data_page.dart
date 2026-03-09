import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../widgets/account_item_separated.dart';
import '../../widgets/custom_divider.dart';
import '../personal_details/widgets/personal_details_list_item.dart';

class ClearUserDataPage extends StatelessWidget {
  const ClearUserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(AppLocalisations.accountItemClearData, style: AppTextStyles.zonaPro20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.normalM,
          vertical: AppDimensions.normalL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.minorS),

            Text(AppLocalisations.dataDeletionDescription, style: AppTextStyles.zonaPro14),

            const SizedBox(height: AppDimensions.normalXS),

            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.normalL),
              clipBehavior: Clip.antiAlias,
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      PersonalDetailsListItem(
                        title: AppLocalisations.clearViewHistoryItem,
                        description: state.viewedIds.isNotEmpty
                            ? AppLocalisations.onLabel
                            : AppLocalisations.offLabel,
                        icon: Icons.history_outlined,
                        showEnabled: state.viewedIds.isNotEmpty,
                        onTap: state.viewedIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearViewHistoryItem,
                                  description: AppLocalisations.clearViewHistoryDialogDescription,
                                  cancelButtonTitle: 'No, keep it.',
                                  confirmButtonTitle: 'Yes, delete it.',
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearRecentItems();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.clearFavoritesItem,
                        description: state.favoriteIds.isNotEmpty
                            ? AppLocalisations.onLabel
                            : AppLocalisations.offLabel,
                        icon: Icons.favorite_border_outlined,
                        showEnabled: state.favoriteIds.isNotEmpty,
                        onTap: state.favoriteIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearFavoritesItem,
                                  description: AppLocalisations.clearFavoriteItemsDialogDescription,
                                  cancelButtonTitle: 'No, keep them.',
                                  confirmButtonTitle: 'Yes, delete them.',
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearFavorites();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.clearMyItemsItem,
                        description: state.createdIds.isNotEmpty
                            ? AppLocalisations.onLabel
                            : AppLocalisations.offLabel,
                        icon: Icons.ballot_outlined,
                        showEnabled: state.createdIds.isNotEmpty,
                        onTap: state.createdIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearMyItemsItem,
                                  description: AppLocalisations.clearMyItemsDialogDescription,
                                  cancelButtonTitle: 'No, keep them.',
                                  confirmButtonTitle: 'Yes, delete them.',
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearMyItems();
                                  },
                                );
                              },
                      ),
                    ].withDividers(divider: const CustomDivider()),
                  );
                },
              ),
            ),

            const SizedBox(height: AppDimensions.normalS),

            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                return AccountItemSeparated(
                  title: AppLocalisations.clearAllDataItem,
                  isEnabled: !state.isDataClear,
                  onTap: !state.isDataClear
                      ? () {
                          DialogHelper.showConfirmationDialog(
                            context,
                            title: AppLocalisations.clearAllDataItem,
                            description: AppLocalisations.clearAllDataDialogDescription,
                            cancelButtonTitle: 'No, keep it.',
                            confirmButtonTitle: 'Yes, delete it.',
                            onConfirm: () {
                              context.read<UserDataCubit>().clearAllData();
                            },
                          );
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
