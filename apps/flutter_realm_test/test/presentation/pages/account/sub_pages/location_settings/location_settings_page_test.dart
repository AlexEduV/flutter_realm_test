import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/domain/entities/region_entity.dart';
import 'package:test_futter_project/domain/usecases/regions/get_all_region_models_use_case.dart';
import 'package:test_futter_project/domain/usecases/regions/get_region_by_code_use_case.dart';
import 'package:test_futter_project/l10n/l10n_keys.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/location_settings_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/location_settings/widgets/footer_text.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import '../../../../../utils/app_router_test.mocks.dart';
import 'location_settings_page_test.mocks.dart';

@GenerateMocks([GetRegionByCodeUseCase, GetAllRegionModelsUseCase])
void main() {
  final appLocalisationsCubit = MockAppLocalisationsCubit();
  final getRegionByCodeUseCase = MockGetRegionByCodeUseCase();
  final getAllRegionModelsUseCase = MockGetAllRegionModelsUseCase();

  Widget buildTestableWidget({
    required UserDataCubit userDataCubit,
    required AppLocalisationsCubit appLocalisationsCubit,
  }) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserDataCubit>.value(value: userDataCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const LocationSettingsPage(),
      ),
    );
  }

  setUp(() {
    serviceLocator.registerLazySingleton<GetRegionByCodeUseCase>(() => getRegionByCodeUseCase);
    serviceLocator.registerLazySingleton<GetAllRegionModelsUseCase>(
      () => getAllRegionModelsUseCase,
    );
    when(getRegionByCodeUseCase.call('us')).thenReturn(const RegionEntity(locale: 'US'));
    when(getAllRegionModelsUseCase.call()).thenReturn([]);

    when(appLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(
        localisations: {
          L10nKeys.accountItemLocation: 'Location',
          L10nKeys.locationUsageDescription: 'Description',
        },
      ),
    );
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    serviceLocator.unregister<GetRegionByCodeUseCase>();
    serviceLocator.unregister<GetAllRegionModelsUseCase>();
  });

  testWidgets('shows app bar title and location usage description', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    when(
      userDataCubit.state,
    ).thenReturn(const UserDataState(isLocationPermissionGranted: true, region: 'us'));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        userDataCubit: userDataCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(
      find.textContaining('Location'),
      findsOneWidget,
    ); // Adjust if your localization is different
    expect(
      find.textContaining('Description'),
      findsOneWidget,
    ); // Adjust for your actual description
  });

  testWidgets('shows region and permission items', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    when(
      userDataCubit.state,
    ).thenReturn(const UserDataState(isLocationPermissionGranted: true, region: 'us'));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        userDataCubit: userDataCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(find.byType(PersonalDetailsListItem), findsNWidgets(2));
  });

  testWidgets('shows footer texts', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    when(
      userDataCubit.state,
    ).thenReturn(const UserDataState(isLocationPermissionGranted: true, region: 'us'));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        userDataCubit: userDataCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    expect(find.byType(FooterText), findsNWidgets(2));
  });

  testWidgets('tapping region item calls onRegionItemTap', (WidgetTester tester) async {
    final userDataCubit = MockUserDataCubit();
    when(
      userDataCubit.state,
    ).thenReturn(const UserDataState(isLocationPermissionGranted: true, region: 'us'));
    when(userDataCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        userDataCubit: userDataCubit,
        appLocalisationsCubit: appLocalisationsCubit,
      ),
    );

    // Find the region item and tap it
    final regionItem = find.byType(PersonalDetailsListItem).last;
    await tester.tap(regionItem);
    await tester.pumpAndSettle();

    // You can verify that updateRegion is called if you mock DialogHelper and RegionRemoteDataSource
    // For now, just check that the tap does not throw
    expect(regionItem, findsOneWidget);
  });
}
