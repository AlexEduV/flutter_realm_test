import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/widget_list_extension.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../../../../features/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import '../../../../features/account/widgets/account_item_separated.dart';
import '../../../../features/account/widgets/custom_divider.dart';
import '../../../user/user_data_cubit.dart';
import '../../../user/user_data_state.dart';
import '../../account_page_identifiers.dart';

class ClearUserDataPage extends StatelessWidget {
  const ClearUserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          context.tr(AccountPageLocaleKeys.accountItemClearData),
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
              context.tr(AccountPageLocaleKeys.dataDeletionDescription),
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
                        title: context.tr(AccountPageLocaleKeys.clearViewHistoryItem),
                        description: state.user.viewedIds.isNotEmpty
                            ? context.tr(L10nKeys.activeStateLabel)
                            : context.tr(L10nKeys.emptyStateLabel),
                        icon: Icons.history_outlined,
                        showEnabled: state.user.viewedIds.isNotEmpty,
                        onTap: state.user.viewedIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(AccountPageLocaleKeys.clearViewHistoryItem),
                                  description: context.trRead(
                                    AccountPageLocaleKeys.clearViewHistoryDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearViewHistoryDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearViewHistoryDialogConfirmLabel,
                                  ),
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearRecentItems();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: context.tr(AccountPageLocaleKeys.clearFavoritesItem),
                        description: state.user.favoriteIds.isNotEmpty
                            ? context.tr(L10nKeys.activeStateLabel)
                            : context.tr(L10nKeys.emptyStateLabel),
                        icon: Icons.favorite_border_outlined,
                        showEnabled: state.user.favoriteIds.isNotEmpty,
                        onTap: state.user.favoriteIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(AccountPageLocaleKeys.clearFavoritesItem),
                                  description: context.trRead(
                                    AccountPageLocaleKeys.clearFavoriteItemsDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearFavoriteItemsDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearFavoriteItemsDialogConfirmLabel,
                                  ),
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearFavorites();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: context.tr(AccountPageLocaleKeys.clearMyItemsItem),
                        description: state.user.createdIds.isNotEmpty
                            ? context.tr(L10nKeys.activeStateLabel)
                            : context.tr(L10nKeys.emptyStateLabel),
                        icon: Icons.checklist_outlined,
                        showEnabled: state.user.createdIds.isNotEmpty,
                        onTap: state.user.createdIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(AccountPageLocaleKeys.clearMyItemsItem),
                                  description: context.trRead(
                                    AccountPageLocaleKeys.clearMyItemsDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearMyItemsDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    AccountPageLocaleKeys.clearMyItemsDialogConfirmLabel,
                                  ),
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
                  title: context.tr(AccountPageLocaleKeys.clearAllDataItem),
                  isEnabled: !state.isDataClear,
                  onTap: !state.isDataClear
                      ? () {
                          DialogHelper.showConfirmationDialog(
                            context,
                            title: context.trRead(AccountPageLocaleKeys.clearAllDataItem),
                            description: context.trRead(
                              AccountPageLocaleKeys.clearAllDataDialogDescription,
                            ),
                            cancelButtonTitle: context.trRead(
                              AccountPageLocaleKeys.clearAllDataDialogCancelLabel,
                            ),
                            confirmButtonTitle: context.trRead(
                              AccountPageLocaleKeys.clearAllDataDialogConfirmLabel,
                            ),
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
