import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_colors.dart';

import '../../../../../common/app_dimensions.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../domain/models/personal_details_item_model.dart';
import '../../../../../utils/l10n.dart';
import '../../../../bloc/user/user_data_cubit.dart';
import '../../../../bloc/user/user_data_state.dart';
import '../../widgets/account_item.dart';
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

            const Text(
              'Choose, which data you would like to clear from the account data.',
              style: AppTextStyles.zonaPro14,
            ),

            const SizedBox(height: AppDimensions.normalXS),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.normalL),
              ),
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  final items = [
                    PersonalDetailsItemModel(
                      title: 'History of viewed items',
                      subtitle: state.viewedIds.isNotEmpty
                          ? AppLocalisations.onLabel
                          : AppLocalisations.offLabel,
                      icon: Icons.history_outlined,
                      showEnabled: state.viewedIds.isNotEmpty,
                      onTap: () {
                        context.read<UserDataCubit>().clearRecentItems();
                      },
                    ),
                    PersonalDetailsItemModel(
                      title: 'Favorite items',
                      subtitle: state.favoriteIds.isNotEmpty
                          ? AppLocalisations.onLabel
                          : AppLocalisations.offLabel,
                      icon: Icons.favorite_border_outlined,
                      showEnabled: state.favoriteIds.isNotEmpty,
                      onTap: () {
                        context.read<UserDataCubit>().clearFavorites();
                      },
                    ),
                    PersonalDetailsItemModel(
                      title: 'My items',
                      subtitle: state.createdIds.isNotEmpty
                          ? AppLocalisations.onLabel
                          : AppLocalisations.offLabel,
                      icon: Icons.ballot_outlined,
                      showEnabled: state.createdIds.isNotEmpty,
                      onTap: () {
                        context.read<UserDataCubit>().clearMyItems();
                      },
                    ),
                  ];

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(AppDimensions.minorL),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return PersonalDetailsListItem(
                        title: item.title,
                        description: item.subtitle,
                        icon: item.icon,
                        showEnabled: item.showEnabled,
                        onTap: item.onTap,
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: AppDimensions.normalS),

            Material(
              borderRadius: BorderRadius.circular(AppDimensions.normalM),
              clipBehavior: Clip.antiAlias,
              child: AccountItem(
                text: 'Delete All Data',
                textStyle: AppTextStyles.zonaPro14.copyWith(color: Colors.redAccent),
                onTap: () {
                  context.read<UserDataCubit>().clearAllData();
                },
                isCentered: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
