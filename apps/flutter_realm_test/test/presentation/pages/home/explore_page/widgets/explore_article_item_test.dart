import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_state.dart';
import 'package:test_flutter_project/presentation/pages/home/explore_page/widgets/explore_article_item.dart';

import '../../../../../utils/app_router_test.mocks.dart';

void main() {
  final mockExplorePageCubit = MockExplorePageCubit();

  setUpAll(() {
    serviceLocator.registerSingleton<ExplorePageCubit>(mockExplorePageCubit);
    when(
      mockExplorePageCubit.state,
    ).thenReturn(ExplorePageState(cars: [], articles: [ArticleEntity.empty()]));
    when(mockExplorePageCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDownAll(() async {
    await serviceLocator.reset();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [BlocProvider<ExplorePageCubit>.value(value: mockExplorePageCubit)],
        child: child,
      ),
    );
  }

  group('ExploreSectionItem', () {
    testWidgets('has default height and width', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          Scaffold(body: ExploreArticleItem(article: ArticleEntity.empty(), index: 0)),
        ),
      );

      final containerFinder = find.byType(Container).first;
      final size = tester.getSize(containerFinder);
      expect(size.height, 120.0);
      expect(size.width, 120.0);
    });

    testWidgets('uses custom height when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          MaterialApp(
            home: Scaffold(
              body: ExploreArticleItem(height: 200.0, article: ArticleEntity.empty(), index: 0),
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container).first;
      final size = tester.getSize(containerFinder);
      expect(size.height, 200.0);
      expect(size.width, 120.0);
    });

    testWidgets('has correct color and border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          MaterialApp(
            home: Scaffold(body: ExploreArticleItem(article: ArticleEntity.empty(), index: 0)),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container).first);
      final decoration = containerWidget.decoration as BoxDecoration;

      expect(decoration.color, AppColors.accentColor.withAlpha(60));
      expect(decoration.borderRadius, BorderRadius.circular(AppDimensions.normalL));
    });
  });
}
