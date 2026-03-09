import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../utils/l10n/l10n.dart';
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
        title: Text(
          AppLocalisations.of(context).accountItemClearData,
          style: AppTextStyles.zonaPro20,
        ),
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

            Text(
              AppLocalisations.of(context).dataDeletionDescription,
              style: AppTextStyles.zonaPro14,
            ),

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
                        title: AppLocalisations.of(context).clearViewHistoryItem,
                        description: state.viewedIds.isNotEmpty
                            ? AppLocalisations.of(context).onLabel
                            : AppLocalisations.of(context).offLabel,
                        icon: Icons.history_outlined,
                        showEnabled: state.viewedIds.isNotEmpty,
                        onTap: state.viewedIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.of(context).clearViewHistoryItem,
                                  description: AppLocalisations.of(
                                    context,
                                  ).clearViewHistoryDialogDescription,
                                  cancelButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearViewHistoryDialogCancelLabel,
                                  confirmButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearViewHistoryDialogConfirmLabel,
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearRecentItems();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.of(context).clearFavoritesItem,
                        description: state.favoriteIds.isNotEmpty
                            ? AppLocalisations.of(context).onLabel
                            : AppLocalisations.of(context).offLabel,
                        icon: Icons.favorite_border_outlined,
                        showEnabled: state.favoriteIds.isNotEmpty,
                        onTap: state.favoriteIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.of(context).clearFavoritesItem,
                                  description: AppLocalisations.of(
                                    context,
                                  ).clearFavoriteItemsDialogDescription,
                                  cancelButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearFavoriteItemsDialogCancelLabel,
                                  confirmButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearFavoriteItemsDialogConfirmLabel,
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearFavorites();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: AppLocalisations.of(context).clearMyItemsItem,
                        description: state.createdIds.isNotEmpty
                            ? AppLocalisations.of(context).onLabel
                            : AppLocalisations.of(context).offLabel,
                        icon: Icons.ballot_outlined,
                        showEnabled: state.createdIds.isNotEmpty,
                        onTap: state.createdIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.of(context).clearMyItemsItem,
                                  description: AppLocalisations.of(
                                    context,
                                  ).clearMyItemsDialogDescription,
                                  cancelButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearMyItemsDialogCancelLabel,
                                  confirmButtonTitle: AppLocalisations.of(
                                    context,
                                  ).clearMyItemsDialogConfirmLabel,
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
                  title: AppLocalisations.of(context).clearAllDataItem,
                  isEnabled: !state.isDataClear,
                  onTap: !state.isDataClear
                      ? () {
                          DialogHelper.showConfirmationDialog(
                            context,
                            title: AppLocalisations.of(context).clearAllDataItem,
                            description: AppLocalisations.of(context).clearAllDataDialogDescription,
                            cancelButtonTitle: AppLocalisations.of(
                              context,
                            ).clearAllDataDialogCancelLabel,
                            confirmButtonTitle: AppLocalisations.of(
                              context,
                            ).clearAllDataDialogConfirmLabel,
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
