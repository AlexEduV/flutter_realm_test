import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/details/details_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/owner_widget.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildOwnerWidgetUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()
    ..load({
      InboxPageLocaleKeys.messageSenderYou: 'You',
      DetailsPageLocaleKeys.ownerSectionPersonTypeOwner: 'Owner',
      L10nKeys.distanceAway: 'km',
      DetailsPageLocaleKeys.ownerSectionContactButtonTitle: 'Send a message',
    });

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Column(
        spacing: AppDimensions.normalL,
        children: [
          //Interactive
          OwnerWidget(
            car: CarEntity.empty().copyWith(
              distanceTo: context.knobs.int.input(label: 'Distance to', initialValue: 5),
              owner: OwnerEntity(
                id: context.knobs.boolean(label: 'Is User the owner', initialValue: false)
                    ? '1'
                    : '2',
                firstName: context.knobs.string(label: 'First name', initialValue: 'Henry'),
                lastName: context.knobs.string(label: 'Last name', initialValue: 'Morgan'),
                linkedItemIds: [],
              ),
            ),
            user: UserEntity.initial(
              userId: '1',
              firstName: 'John',
              lastName: 'Smith',
              email: 'mock@email.com',
              password: 'pass',
            ),
          ),
        ],
      ),
    ),
  );
}
