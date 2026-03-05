import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_futter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/home_bottom_bar.dart';
import 'package:test_futter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  final mockHomeBottomBarCubit = MockHomeBottomBarCubit();

  setUp(() {
    AppLocalisations.localisations = {'actions.addCar.tooltip': 'Add a car'};

    when(
      mockHomeBottomBarCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeBottomBarState()]));

    when(mockHomeBottomBarCubit.state).thenReturn(const HomeBottomBarState());
  });

  group('HomeBottomBar', () {
    testWidgets('displays all HomeBottomBarItems and add button', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<HomeBottomBarCubit>(
          create: (context) => mockHomeBottomBarCubit,
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      expect(find.byType(HomeBottomBarItem), findsNWidgets(4));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('calls onAddPressed when add button is tapped', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        BlocProvider<HomeBottomBarCubit>(
          create: (context) => mockHomeBottomBarCubit,
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: HomeBottomBar(
                onAddPressed: () {
                  pressed = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      expect(pressed, isTrue);
    });

    testWidgets('add button has correct style and tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<HomeBottomBarCubit>(
          create: (context) => mockHomeBottomBarCubit,
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      final iconButton = tester.widget<InkWell>(find.widgetWithIcon(InkWell, Icons.add));

      expect(iconButton.splashColor, AppColors.accentColor.withAlpha(60));
      expect(iconButton.highlightColor, Colors.transparent);
    });

    testWidgets('container has correct decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<HomeBottomBarCubit>(
          create: (context) => mockHomeBottomBarCubit,
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(of: find.byType(HomeBottomBar), matching: find.byType(Container).first),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
      expect(
        decoration.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.normalL),
          topRight: Radius.circular(AppDimensions.normalL),
        ),
      );
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.first.color, Colors.grey.withAlpha(60));
    });
  });
}
