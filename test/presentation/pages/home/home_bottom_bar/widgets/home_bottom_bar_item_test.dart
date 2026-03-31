import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';

import 'home_bottom_bar_item_test.mocks.dart';

@GenerateMocks([HomeBottomBarCubit])
void main() {
  group('HomeBottomBarItem', () {
    late MockHomeBottomBarCubit mockCubit;
    late HomeBottomBarState state;

    setUp(() {
      mockCubit = MockHomeBottomBarCubit();
      state = const HomeBottomBarState(currentSelectedTabIndex: 1);
    });

    Widget buildTestWidget({required int index, required IconData icon}) {
      return MaterialApp(
        home: BlocProvider<HomeBottomBarCubit>.value(
          value: mockCubit,
          child: HomeBottomBarItem(index: index, icon: icon, semanticsLabel: 'test', label: 'test'),
        ),
      );
    }

    testWidgets('displays the correct icon', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(state);
      when(mockCubit.stream).thenAnswer((_) => Stream<HomeBottomBarState>.fromIterable([state]));

      await tester.pumpWidget(buildTestWidget(index: 1, icon: Icons.home));
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('uses selected color when selected', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(const HomeBottomBarState(currentSelectedTabIndex: 2));
      when(mockCubit.stream).thenAnswer(
        (_) => Stream<HomeBottomBarState>.fromIterable([
          const HomeBottomBarState(currentSelectedTabIndex: 2),
        ]),
      );

      await tester.pumpWidget(buildTestWidget(index: 2, icon: Icons.search));
      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final style = iconButton.style;
      final foregroundColor = style?.foregroundColor?.resolve({});

      expect(foregroundColor, AppColors.headerColor);
    });

    testWidgets('uses unselected color when not selected', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(const HomeBottomBarState(currentSelectedTabIndex: 0));
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([const HomeBottomBarState(currentSelectedTabIndex: 0)]),
      );

      await tester.pumpWidget(buildTestWidget(index: 1, icon: Icons.search));
      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final style = iconButton.style;
      final foregroundColor = style?.foregroundColor?.resolve({});

      expect(foregroundColor, AppColors.headerColor.withAlpha((0.38 * 255).toInt()));
    });

    testWidgets('calls updateSelectedIndex when pressed', (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(state);
      when(mockCubit.stream).thenAnswer((_) => Stream<HomeBottomBarState>.fromIterable([state]));

      await tester.pumpWidget(buildTestWidget(index: 1, icon: Icons.home));
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      verify(mockCubit.updateSelectedIndex(1)).called(1);
    });
  });
}
