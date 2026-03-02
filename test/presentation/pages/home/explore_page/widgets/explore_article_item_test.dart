import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/presentation/pages/home/explore_page/widgets/explore_article_item.dart';

void main() {
  group('ExploreSectionItem', () {
    testWidgets('has default height and width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExploreArticleItem(article: ArticleEntity.empty(), index: 0)),
        ),
      );

      final containerFinder = find.byType(Container).first;
      final size = tester.getSize(containerFinder);
      expect(size.height, 120.0);
      expect(size.width, 120.0);
    });

    testWidgets('uses custom height when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExploreArticleItem(height: 200.0, article: ArticleEntity.empty(), index: 0),
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
        MaterialApp(
          home: Scaffold(body: ExploreArticleItem(article: ArticleEntity.empty(), index: 0)),
        ),
      );

      final containerWidget = tester.widget<Container>(find.byType(Container).first);
      final decoration = containerWidget.decoration as BoxDecoration;

      expect(decoration.color, AppColors.accentColor.withAlpha(60));
      expect(decoration.borderRadius, BorderRadius.circular(AppDimensions.normalL));
    });
  });
}
