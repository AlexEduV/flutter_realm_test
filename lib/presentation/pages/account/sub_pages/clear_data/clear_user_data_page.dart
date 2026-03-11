import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/utils/dialog_helper.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
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
        title: Text(context.tr(L10nKeys.accountItemClearData), style: AppTextStyles.zonaPro20),
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

            Text(context.tr(L10nKeys.dataDeletionDescription), style: AppTextStyles.zonaPro14),

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
                        title: context.tr(L10nKeys.clearViewHistoryItem),
                        description: state.viewedIds.isNotEmpty
                            ? context.tr(L10nKeys.onLabel)
                            : context.tr(L10nKeys.offLabel),
                        icon: Icons.history_outlined,
                        showEnabled: state.viewedIds.isNotEmpty,
                        onTap: state.viewedIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(L10nKeys.clearViewHistoryItem),
                                  description: context.trRead(
                                    L10nKeys.clearViewHistoryDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    L10nKeys.clearViewHistoryDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    L10nKeys.clearViewHistoryDialogConfirmLabel,
                                  ),
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearRecentItems();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: context.tr(L10nKeys.clearFavoritesItem),
                        description: state.favoriteIds.isNotEmpty
                            ? context.tr(L10nKeys.onLabel)
                            : context.tr(L10nKeys.offLabel),
                        icon: Icons.favorite_border_outlined,
                        showEnabled: state.favoriteIds.isNotEmpty,
                        onTap: state.favoriteIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(L10nKeys.clearFavoritesItem),
                                  description: context.trRead(
                                    L10nKeys.clearFavoriteItemsDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    L10nKeys.clearFavoriteItemsDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    L10nKeys.clearFavoriteItemsDialogConfirmLabel,
                                  ),
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearFavorites();
                                  },
                                );
                              },
                      ),

                      PersonalDetailsListItem(
                        title: context.tr(L10nKeys.clearMyItemsItem),
                        description: state.createdIds.isNotEmpty
                            ? context.tr(L10nKeys.onLabel)
                            : context.tr(L10nKeys.offLabel),
                        icon: Icons.checklist_outlined,
                        showEnabled: state.createdIds.isNotEmpty,
                        onTap: state.createdIds.isEmpty
                            ? null
                            : () {
                                DialogHelper.showConfirmationDialog(
                                  context,
                                  title: context.trRead(L10nKeys.clearMyItemsItem),
                                  description: context.trRead(
                                    L10nKeys.clearMyItemsDialogDescription,
                                  ),
                                  cancelButtonTitle: context.trRead(
                                    L10nKeys.clearMyItemsDialogCancelLabel,
                                  ),
                                  confirmButtonTitle: context.trRead(
                                    L10nKeys.clearMyItemsDialogConfirmLabel,
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
                  title: context.tr(L10nKeys.clearAllDataItem),
                  isEnabled: !state.isDataClear,
                  onTap: !state.isDataClear
                      ? () {
                          DialogHelper.showConfirmationDialog(
                            context,
                            title: context.trRead(L10nKeys.clearAllDataItem),
                            description: context.trRead(L10nKeys.clearAllDataDialogDescription),
                            cancelButtonTitle: context.trRead(
                              L10nKeys.clearAllDataDialogCancelLabel,
                            ),
                            confirmButtonTitle: context.trRead(
                              L10nKeys.clearAllDataDialogConfirmLabel,
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
