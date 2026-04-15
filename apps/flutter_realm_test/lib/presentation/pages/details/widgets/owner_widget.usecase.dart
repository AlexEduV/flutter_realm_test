import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../../../domain/entities/car_entity.dart';
import '../../../../l10n/l10n_keys.dart';
import 'owner_widget.dart';

final appLocalisationsCubit = AppLocalisationsCubit()
  ..load({
    L10nKeys.messageSenderYou: 'You',
    L10nKeys.ownerSectionPersonTypeOwner: 'Owner',
    L10nKeys.distanceWidgetText: 'km',
    L10nKeys.ownerSectionContactButtonTitle: 'Send a message',
  });

Widget buildOwnerWidgetUseCase(BuildContext context) {
  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Column(
        spacing: AppDimensions.normalM,
        children: [
          OwnerWidget(
            car: CarEntity.empty().copyWith(
              distanceTo: 5,
              owner: OwnerEntity(
                id: '2',
                firstName: 'Henry',
                lastName: 'Morgan',
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

          OwnerWidget(
            car: CarEntity.empty().copyWith(
              distanceTo: 5,
              owner: OwnerEntity(
                id: '1',
                firstName: 'Henry',
                lastName: 'Morgan',
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
