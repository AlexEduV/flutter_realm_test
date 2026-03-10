import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/models/field_params_model.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/filters_drawer.dart';
import 'package:test_futter_project/utils/l10n_keys.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  late MockSearchPageCubit mockCubit;
  late SearchPageState testState;

  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    mockCubit = MockSearchPageCubit();

    testState = SearchPageState(
      selectedMinYear: '2000',
      selectedMaxYear: '2020',
      selectedMinPrice: '1000',
      selectedMaxPrice: '5000',
      selectedBodyTypes: [BodyType.sedan.name],
      selectedFuelTypes: [FuelType.diesel.name],
      selectedTransmissionTypes: [TransmissionType.manual.name],
      currentSelectedType: CarType.car,
      minYearFieldParamsModel: FieldParamsModel.withLabel('Min Year'),
      maxYearFieldParamsModel: FieldParamsModel.withLabel('Max Year'),
      minPriceFieldParamsModel: FieldParamsModel.withLabel('Min Price'),
      maxPriceFieldParamsModel: FieldParamsModel.withLabel('Max Price'),
      minYearError: null,
      maxYearError: null,
      minPriceError: null,
      maxPriceError: null,
    );

    when(mockCubit.state).thenReturn(testState);
    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([testState]));
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SearchPageCubit>.value(value: mockCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: const FiltersDrawer(),
      ),
    );
  }

  testWidgets('renders FiltersDrawer and displays initial values', (tester) async {
    final localisations = {
      'filters.parameters.title': 'Parameters',
      'filters.parameters.bodyTypes.sedan': 'Sedan',
    };

    appLocalisationsCubit.load(localisations);

    await tester.pumpWidget(buildTestWidget());

    // Check DrawerHeader title
    expect(
      find.text(appLocalisationsCubit.getLocalisationByKey(L10nKeys.searchFilterParametersTitle)),
      findsOneWidget,
    );

    // Check year fields
    expect(find.text('Min Year'), findsOneWidget);
    expect(find.text('Max Year'), findsOneWidget);

    // Check selected body type
    expect(
      find.text(appLocalisationsCubit.getLocalisationByKey(L10nKeys.bodyTypeSedan)),
      findsOneWidget,
    );
    final sedanCheckbox = find.byWidgetPredicate(
      (widget) =>
          widget is CheckboxListTile &&
          widget.title is Text &&
          (widget.title as Text).data ==
              appLocalisationsCubit.getLocalisationByKey(L10nKeys.bodyTypeSedan),
    );
    expect(sedanCheckbox, findsOneWidget);
  });

  testWidgets('calls cubit methods when year fields change', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    // Find min year field and enter new value
    final minYearField = find.byType(TextFormField).first;
    await tester.enterText(minYearField, '2010');
    await tester.pumpAndSettle(const Duration(seconds: 2));

    verify(mockCubit.updateSelectedMinYear('2010')).called(1);
  });

  testWidgets('calls cubit methods when body type checkbox is toggled', (tester) async {
    final localisations = {'filters.parameters.bodyTypes.sedan': 'Sedan'};
    appLocalisationsCubit.load(localisations);

    await tester.pumpWidget(buildTestWidget());

    // Find sedan checkbox and tap to uncheck
    final sedanCheckbox = find.byWidgetPredicate(
      (widget) =>
          widget is CheckboxListTile &&
          widget.title is Text &&
          (widget.title as Text).data ==
              appLocalisationsCubit.getLocalisationByKey(L10nKeys.bodyTypeSedan),
    );
    await tester.tap(sedanCheckbox);
    await tester.pumpAndSettle();

    verify(mockCubit.removeBodyTypeFromSelection(BodyType.sedan.name)).called(1);
  });

  testWidgets('calls cubit methods when fuel type checkbox is toggled', (tester) async {
    final localisations = {'filters.parameters.fuelTypes.diesel': 'Diesel'};
    appLocalisationsCubit.load(localisations);

    await tester.pumpWidget(buildTestWidget());

    final dieselCheckbox = find.byWidgetPredicate(
      (widget) =>
          widget is CheckboxListTile &&
          widget.title is Text &&
          (widget.title as Text).data ==
              appLocalisationsCubit.getLocalisationByKey(L10nKeys.fuelTypeDiesel),
    );

    await tester.scrollUntilVisible(
      dieselCheckbox,
      200.0, // scroll delta, adjust as needed
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(dieselCheckbox);
    await tester.pumpAndSettle();

    verify(mockCubit.removeFuelTypeFromSelection(FuelType.diesel.name)).called(1);
  });

  testWidgets('calls cubit methods when transmission type checkbox is toggled', (tester) async {
    final localisations = {'filters.parameters.transmissionTypes.manual': 'Manual'};
    appLocalisationsCubit.load(localisations);

    await tester.pumpWidget(buildTestWidget());

    final manualCheckbox = find.byWidgetPredicate(
      (widget) =>
          widget is CheckboxListTile &&
          widget.title is Text &&
          (widget.title as Text).data ==
              appLocalisationsCubit.getLocalisationByKey(L10nKeys.transmissionTypeManual),
    );

    await tester.scrollUntilVisible(
      manualCheckbox,
      400.0, // scroll delta, adjust as needed
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(manualCheckbox);
    await tester.pumpAndSettle();

    verify(mockCubit.removeTransmissionTypeFromSelection(TransmissionType.manual.name)).called(1);
  });
}
