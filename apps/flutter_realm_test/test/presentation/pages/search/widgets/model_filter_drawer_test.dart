import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/search/search_page_state.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/model_filter_drawer.dart';

import 'model_filter_drawer_test.mocks.dart';

@GenerateMocks([SearchPageCubit])
void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    final localisations = {'filters.model.title': 'Model', 'filters.model.placeholder': 'All'};
    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('ModelFilterDrawer', () {
    late MockSearchPageCubit mockCubit;
    late SearchPageState initialState;
    final models = {
      'manufacturer': ['A', 'B', 'C'],
    };

    setUp(() {
      mockCubit = MockSearchPageCubit();
      initialState = const SearchPageState(selectedModels: {});
    });

    Widget buildTestWidget(SearchPageState state) {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SearchPageCubit>.value(value: mockCubit),

            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: ModelFilterDrawer(models: models),
        ),
      );
    }

    testWidgets('displays header and "All" checkbox', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      expect(
        find.text(appLocalisationsCubit.getLocalisationByKey(L10nKeys.searchFilterModelTitle)),
        findsOneWidget,
      );
      expect(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.searchFilterModelPlaceholder),
        ),
        findsOneWidget,
      );
      expect(find.byType(CheckboxListTile), findsNWidgets(5)); // "All" + each model
    });

    testWidgets('displays model checkboxes', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      for (final model in models['manufacturer'] ?? []) {
        expect(find.text(model), findsOneWidget);
      }
    });

    testWidgets('tapping "All" checkbox calls updateModelSelection', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(initialState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([initialState]));

      await tester.pumpWidget(buildTestWidget(initialState));
      await tester.pumpAndSettle();

      await tester.tap(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.searchFilterModelPlaceholder),
        ),
      );
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

      verify(mockCubit.addCarModelToSelection('manufacturer', 'A')).called(1);
    });

    testWidgets('unchecking a model checkbox calls removeCarModelFromSelection', (
      WidgetTester tester,
    ) async {
      final selectedState = const SearchPageState(
        selectedModels: {
          'manufacturer': ['A'],
        },
      );
      when(mockCubit.state).thenReturn(selectedState);
      when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([selectedState]));

      await tester.pumpWidget(buildTestWidget(selectedState));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pump();

      verify(mockCubit.removeCarModelFromSelection('manufacturer', 'A')).called(1);
    });
  });
}
