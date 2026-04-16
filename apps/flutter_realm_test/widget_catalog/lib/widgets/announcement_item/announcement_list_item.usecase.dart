import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/announcement_item/announcement_list_item.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildAnnouncementListItemUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({L10nKeys.deleteButtonTitle: 'Delete'});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        spacing: AppDimensions.normalL,
        children: [
          AnnouncementListItem(
            car: CarEntity.empty(),
            user: UserEntity.initial(
              userId: '1',
              firstName: 'John',
              lastName: 'Doe',
              email: 'john@mock.com',
              password: 'pass',
            ),
            onDismissed: () {},
            isExploreItem: context.knobs.boolean(label: 'Is explore item', initialValue: true),
          ),
        ],
      ),
    ),
  );
}
