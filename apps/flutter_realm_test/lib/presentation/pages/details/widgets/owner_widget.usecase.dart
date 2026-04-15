import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

import '../../../../domain/entities/car_entity.dart';
import '../../../../l10n/l10n_keys.dart';
import 'owner_widget.dart';

Widget buildOwnerWidgetUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit();
  appLocalisationsCubit.load({
    L10nKeys.messageSenderYou: 'You',
    L10nKeys.ownerSectionPersonTypeOwner: 'Owner',
    L10nKeys.distanceWidgetText: 'km',
    L10nKeys.ownerSectionContactButtonTitle: 'Send a message',
  });

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.minorL),
      child: OwnerWidget(
        car: CarEntity.empty().copyWith(distanceTo: 5),
        user: UserEntity.initial(
          userId: '1',
          firstName: 'John',
          lastName: 'Smith',
          email: 'mock@email.com',
          password: 'pass',
        ),
      ),
    ),
  );
}
