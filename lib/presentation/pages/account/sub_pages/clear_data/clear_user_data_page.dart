import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/extensions/widget_list_extension.dart';

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
                                showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearViewHistoryItem,
                                  description: AppLocalisations.clearViewHistoryDialogDescription,
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearRecentItems();
                                  },
                                  onCancel: () {},
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
                                showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearFavoritesItem,
                                  description: AppLocalisations.clearFavoriteItemsDialogDescription,
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearFavorites();
                                  },
                                  onCancel: () {},
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
                                showConfirmationDialog(
                                  context,
                                  title: AppLocalisations.clearMyItemsItem,
                                  description: AppLocalisations.clearMyItemsDialogDescription,
                                  onConfirm: () {
                                    context.read<UserDataCubit>().clearMyItems();
                                  },
                                  onCancel: () {},
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
                      ? null
                      : () {
                          showConfirmationDialog(
                            context,
                            title: AppLocalisations.clearAllDataItem,
                            description: AppLocalisations.clearAllDataDialogDescription,
                            onConfirm: () {
                              context.read<UserDataCubit>().clearAllData();
                            },
                            onCancel: () {},
                          );
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
              child: Text(AppLocalisations.cancelLabel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(AppLocalisations.confirmLabel),
            ),
          ],
        );
      },
    );
  }
}
