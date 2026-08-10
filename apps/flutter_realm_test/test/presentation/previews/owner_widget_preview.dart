import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/details/widgets/owner_widget.dart';
import 'package:test_flutter_project/presentation/features/inbox/inbox_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';

@Preview(
  group: 'Owner Widget',
  name: 'Normal',
  brightness: Brightness.light,
  size: Size.fromWidth(390),
)
Widget preview() => _basePreview(isOwner: false);

@Preview(
  group: 'Owner Widget',
  name: 'User is Owner',
  brightness: Brightness.light,
  size: Size.fromWidth(390),
)
Widget previewUserIsOwner() => _basePreview(isOwner: true);

Widget _basePreview({required bool isOwner}) {
  final appLocalisationsCubit = AppLocalisationsCubit();
  appLocalisationsCubit.load({
    InboxPageLocaleKeys.messageSenderYou: 'You',
    L10nKeys.ownerSectionPersonTypeOwner: 'Owner',
    L10nKeys.distanceAway: 'km',
    L10nKeys.ownerSectionContactButtonTitle: 'Send a message',
  });

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Zona Pro',
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.normalS),
              child: OwnerWidget(
                car: CarEntity.empty().copyWith(
                  distanceTo: 5,
                  owner: OwnerEntity(
                    id: '1', // Fixed ID
                    firstName: 'John',
                    lastName: 'Doe',
                    linkedItemIds: [],
                  ),
                ),
                user: UserEntity.initial(
                  userId: isOwner ? '1' : '2', // Toggle this to change the view
                  firstName: 'Alexander',
                  lastName: 'Hamilton',
                  email: 'mock@example.com',
                  password: 'pass',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
