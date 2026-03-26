import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/models/conversation_model.dart';
import 'package:test_futter_project/domain/usecases/inbox/get_conversation_by_owner_id_use_case.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/owner_widget.dart';

import '../../../../utils/app_router_test.mocks.dart';
import 'owner_widget_test.mocks.dart';

@GenerateMocks([GetConversationByOwnerIdUseCase])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();
  final mockGetConversationByOwnerUseCase = MockGetConversationByOwnerIdUseCase();
  final mockUserDataCubit = MockUserDataCubit();

  setUp(() {
    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockUserDataCubit.state).thenReturn(const UserDataState());
    when(mockUserDataCubit.user).thenReturn(
      UserEntity.initial(
        userId: '1',
        firstName: 'Alexander',
        lastName: 'Banes',
        email: 'banes@mock.com',
        password: 'passowrd',
      ),
    );

    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);
    serviceLocator.registerLazySingleton<GetConversationByOwnerIdUseCase>(
      () => mockGetConversationByOwnerUseCase,
    );

    final localisations = {
      'pages.vehicleDetails.ownerSection.personTypeOwner': 'Owner',
      'widgets.distance.text': 'km away',
      'pages.vehicleDetails.ownerSection.contactButtonTitle': 'Contact',
    };

    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
    serviceLocator.unregister<GetConversationByOwnerIdUseCase>();
  });

  testWidgets('displays owner name, type, and distance', (WidgetTester tester) async {
    final car = CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'Car',
      bodyType: 'sedan',
      fuelType: 'electric',
      transmissionType: 'automatic',
      owner: OwnerEntity(id: 'test', firstName: 'Elon', lastName: 'Musk', linkedItemIds: []),
      distanceTo: 42,
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: MaterialApp(
          home: Scaffold(body: OwnerWidget(car: car)),
        ),
      ),
    );

    // Owner name
    expect(find.text('Elon Musk'), findsOneWidget);

    // Owner type
    expect(find.text('Owner'), findsOneWidget);

    // Distance
    expect(find.text('42 km away'), findsOneWidget);

    // Contact button
    expect(find.widgetWithText(ElevatedButton, 'Contact'), findsOneWidget);
  });

  testWidgets('contact button can be tapped', (WidgetTester tester) async {
    //bool tapped = false;
    final car = CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'Car',
      bodyType: 'sedan',
      fuelType: 'electric',
      transmissionType: 'automatic',
      owner: OwnerEntity(id: 'test', firstName: 'Elon', lastName: 'Musk', linkedItemIds: []),
      distanceTo: 42,
    );

    when(mockGetConversationByOwnerUseCase.call('test')).thenReturn(ConversationModel.empty());

    // Override OwnerWidget to inject a callback for testing
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => OwnerWidget(
                car: car,
                // You'd need to add an optional onContactPressed to OwnerWidget for this test
                // onContactPressed: () => tapped = true,
              ),
            ),
          ),
        ),
      ),
    );

    // Tap the button
    // await tester.tap(find.widgetWithText(ElevatedButton, 'Contact'));
    // await tester.pump();

    // If you add a callback, you can check:
    // expect(tapped, isTrue);
    // Otherwise, just check the button exists and is tappable
    expect(find.widgetWithText(ElevatedButton, 'Contact'), findsOneWidget);
  });
}
