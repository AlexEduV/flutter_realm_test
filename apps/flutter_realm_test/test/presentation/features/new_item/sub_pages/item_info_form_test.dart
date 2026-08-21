import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/car_auto_complete_entity.dart';
import 'package:test_flutter_project/domain/models/field_params_model.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/app_form_field.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page_state.dart';
import 'package:test_flutter_project/presentation/features/new_item/sub_pages/item_info_form.dart';
import 'package:test_flutter_project/presentation/features/new_item/widgets/radio_group_title.dart';

import 'car_type_picker_test.mocks.dart';

void main() {
  late MockNewItemPageCubit mockCubit;
  late AppLocalisationsCubit appLocalisationsCubit;

  final testEntity = CarAutoCompleteEntity(
    manufacturerId: 1,
    manufacturer: 'Toyota',
    models: ['Camry', 'Corolla'],
    imageSrc: null,
  );

  final baseState = NewItemPageState(
    manufacturerFieldParams: const FieldParamsModel(
      label: 'Manufacturer',
      validationMessage: 'Required',
      regex: r'^[A-Za-z\s\-]+$',
      regexErrorMessage: 'Invalid manufacturer',
    ),
    modelFieldParams: const FieldParamsModel(
      label: 'Model',
      validationMessage: 'Required',
      regex: r'^[A-Za-z0-9\s\-\/\+]+$',
      regexErrorMessage: 'Invalid model',
    ),
    yearFieldParams: const FieldParamsModel(
      label: 'Year',
      validationMessage: 'Required',
      regex: r'^\d{4}$',
      regexErrorMessage: 'Invalid year',
    ),
    priceFieldParams: const FieldParamsModel(
      label: 'Price',
      validationMessage: 'Required',
      regex: r'^(0|[1-9]\d{0,7})$',
      regexErrorMessage: 'Invalid price',
    ),
    colorFieldParams: const FieldParamsModel(
      label: 'Color',
      validationMessage: 'Required',
      regex: r'^[A-Za-z\s\-]+$',
      regexErrorMessage: 'Invalid color',
    ),
    autoCompleteEntities: [testEntity],
  );

  setUpAll(() {
    provideDummy(const NewItemPageState());
  });

  setUp(() {
    mockCubit = MockNewItemPageCubit();
    appLocalisationsCubit = AppLocalisationsCubit();

    when(mockCubit.state).thenReturn(baseState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.getAutoCompleteEntitiesByType(any)).thenAnswer((_) async {});
    when(mockCubit.validateManufacturer(any, any)).thenReturn(true);
    when(mockCubit.validateModel(any, any)).thenReturn(true);
    when(mockCubit.validateYear(any, any)).thenReturn(true);
    when(mockCubit.validatePrice(any, any)).thenReturn(true);
    when(mockCubit.validateColor(any, any)).thenReturn(true);
  });

  Widget buildWidget({NewItemPageState? state}) {
    if (state != null) {
      when(mockCubit.state).thenReturn(state);
    }

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NewItemPageCubit>.value(value: mockCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: Scaffold(
          body: ItemInfoForm(
            manufacturerFocusNode: FocusNode(),
            modelFocusNode: FocusNode(),
            yearFocusNode: FocusNode(),
            colorFocusNode: FocusNode(),
            priceFocusNode: FocusNode(),
          ),
        ),
      ),
    );
  }

  group('ItemInfoForm', () {
    testWidgets('renders RadioGroupTitle and all form fields', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(RadioGroupTitle), findsOneWidget);
      expect(find.byType(Autocomplete<CarAutoCompleteEntity>), findsOneWidget);
      expect(find.byType(Autocomplete<String>), findsOneWidget);
      // Each Autocomplete also renders an AppFormField via fieldViewBuilder + 3 standalone
      expect(find.byType(AppFormField), findsAtLeast(3));
    });

    testWidgets('calls clearFieldErrors, clearFields, and getAutoCompleteEntitiesByType on init', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      verify(mockCubit.clearFieldErrors()).called(1);
      verify(mockCubit.clearFields()).called(1);
      verify(mockCubit.getAutoCompleteEntitiesByType(any)).called(1);
    });

    testWidgets('shows manufacturer error text when state has manufacturerErrorText', (
      tester,
    ) async {
      final errorState = baseState.copyWith(manufacturerErrorText: 'Required');
      await tester.pumpWidget(buildWidget(state: errorState));
      await tester.pump();

      expect(find.text('Required'), findsWidgets);
    });

    testWidgets('shows model error text when state has modelErrorText', (tester) async {
      final errorState = baseState.copyWith(modelErrorText: 'Model is required');
      await tester.pumpWidget(buildWidget(state: errorState));
      await tester.pump();

      expect(find.text('Model is required'), findsOneWidget);
    });

    testWidgets('shows year error text when state has yearErrorText', (tester) async {
      final errorState = baseState.copyWith(yearErrorText: 'Invalid year');
      await tester.pumpWidget(buildWidget(state: errorState));
      await tester.pump();

      expect(find.text('Invalid year'), findsOneWidget);
    });

    testWidgets('displays field labels from state params', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.text('Year'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Color'), findsOneWidget);
    });

    testWidgets('typing in year field calls validateYear and updateYearText', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      // Year field is the 3rd TextFormField (after 2 Autocomplete fields)
      final yearField = find.byType(TextFormField).at(2);
      await tester.enterText(yearField, '2020');
      await tester.pump();

      verify(mockCubit.validateYear(any, any)).called(greaterThan(0));
      verify(mockCubit.updateYearText(any)).called(greaterThan(0));
    });

    testWidgets('typing in price field calls validatePrice and updatePriceText', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      // Price field is the 4th TextFormField
      final priceField = find.byType(TextFormField).at(3);
      await tester.enterText(priceField, '15000');
      await tester.pump();

      verify(mockCubit.validatePrice(any, any)).called(greaterThan(0));
      verify(mockCubit.updatePriceText(any)).called(greaterThan(0));
    });

    testWidgets('manufacturer autocomplete shows suggestions when text matches', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final manufacturerField = find.byType(TextFormField).first;
      await tester.enterText(manufacturerField, 'Toy');
      await tester.pumpAndSettle();

      expect(find.text('Toyota'), findsWidgets);
    });

    testWidgets('selecting manufacturer autocomplete option calls updateManufacturerText', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final manufacturerField = find.byType(TextFormField).first;
      await tester.enterText(manufacturerField, 'Toy');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Toyota').last);
      await tester.pumpAndSettle();

      verify(mockCubit.updateManufacturerText('Toyota')).called(greaterThan(0));
    });

    testWidgets('model autocomplete shows models for selected manufacturer', (tester) async {
      final stateWithManufacturer = baseState.copyWith(manufacturerText: 'Toyota');
      await tester.pumpWidget(buildWidget(state: stateWithManufacturer));
      await tester.pump();

      // Model field is the 2nd TextFormField
      final modelField = find.byType(TextFormField).at(1);
      await tester.enterText(modelField, 'Cam');
      await tester.pumpAndSettle();

      expect(find.text('Camry'), findsWidgets);
    });

    testWidgets('manufacturer autocomplete shows no suggestions for empty input', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final manufacturerField = find.byType(TextFormField).first;
      await tester.enterText(manufacturerField, '');
      await tester.pumpAndSettle();

      expect(find.text('Toyota'), findsNothing);
    });

    testWidgets(
      'typing in manufacturer field calls validateManufacturer and updateManufacturerText',
      (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.pump();

        final manufacturerField = find.byType(TextFormField).first;
        await tester.enterText(manufacturerField, 'Honda');
        await tester.pump();

        verify(mockCubit.validateManufacturer(any, any)).called(greaterThan(0));
        verify(mockCubit.updateManufacturerText(any)).called(greaterThan(0));
      },
    );
  });
}
