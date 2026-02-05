import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_futter_project/presentation/pages/search/widgets/model_filter_drawer.dart';
import 'package:test_futter_project/utils/l10n.dart';

import 'model_filter_drawer_test.mocks.dart';

@GenerateMocks([SearchPageCubit])
void main() {
  setUp(() {
    AppLocalisations.localisations = {
      'filters.model.title': 'Model',
      'filters.model.placeholder': 'All',
    };
  });

  group('ModelFilterDrawer', () {
    late MockSearchPageCubit mockCubit;
    late SearchPageState initialState;
    final models = ['A', 'B', 'C'];

    setUp(() {
      mockCubit = MockSearchPageCubit();
      initialState = const SearchPageState(selectedModels: []);
    });

    Widget buildTestWidget(SearchPageState state) {
      return MaterialApp(
        home: BlocProvider<SearchPageCubit>.value(
          value: mockCubit,
          child: ModelFilterDrawer(models: models),
        ),
      );
    }

    testWidgets('displays header and "All" checkbox', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      expect(find.text(AppLocalisations.searchFilterModelTitle), findsOneWidget);
      expect(find.text(AppLocalisations.searchFilterModelPlaceholder), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsNWidgets(models.length + 1)); // "All" + each model
    });

    testWidgets('displays model checkboxes', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      for (final model in models) {
        expect(find.text(model), findsOneWidget);
      }
    });

    testWidgets('tapping "All" checkbox calls updateModelSelection', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppLocalisations.searchFilterModelPlaceholder));
      await tester.pump();

      verify(mockCubit.updateModelSelection(models)).called(1);
    });

    testWidgets('tapping a model checkbox calls addCarModelToSelection', (
      WidgetTester tester,
    ) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pump();

      verify(mockCubit.addCarModelToSelection('A')).called(1);
    });

    testWidgets('unchecking a model checkbox calls removeCarModelFromSelection', (
      WidgetTester tester,
    ) async {
      final selectedState = const SearchPageState(selectedModels: ['A']);
      when(mockCubit.state).thenReturn(selectedState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([selectedState]));

      await tester.pumpWidget(buildTestWidget(selectedState));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pump();

      verify(mockCubit.removeCarModelFromSelection('A')).called(1);
    });
  });
}
