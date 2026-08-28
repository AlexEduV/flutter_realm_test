import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/presentation/features/explore/explore_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/explore/widgets/article_item.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  late MockExplorePageCubit mockExplorePageCubit;

  setUp(() {
    mockExplorePageCubit = MockExplorePageCubit();
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
        makeTestableWidget(Scaffold(body: ArticleItem(article: ArticleEntity.empty()))),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(of: find.byType(InkWell), matching: find.byType(SizedBox)).first,
      );
      expect(sizedBox.height, AppDimensions.exploreArticleItemBaseSize);
      expect(sizedBox.width, AppDimensions.exploreArticleItemBaseSize);
    });

    testWidgets('uses custom height when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(Scaffold(body: ArticleItem(height: 200.0, article: ArticleEntity.empty()))),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(of: find.byType(InkWell), matching: find.byType(SizedBox)).first,
      );
      expect(sizedBox.height, 200.0);
      expect(sizedBox.width, AppDimensions.exploreArticleItemBaseSize);
    });

    testWidgets('has correct color and border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(Scaffold(body: ArticleItem(article: ArticleEntity.empty()))),
      );

      final material = tester.widget<Material>(
        find.descendant(of: find.byType(ArticleItem), matching: find.byType(Material)).first,
      );

      expect(material.color, AppColors.accentColor.withAlpha(60));
      expect(material.borderRadius, BorderRadius.circular(AppDimensions.normalL));
    });
  });
}
