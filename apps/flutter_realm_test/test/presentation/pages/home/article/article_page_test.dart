import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/author_entity.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/article/article_page.dart';

import 'article_page_test.mocks.dart';

@GenerateMocks([ArticlePageCubit])
void main() {
  late MockArticlePageCubit mockArticlePageCubit;
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    mockArticlePageCubit = MockArticlePageCubit();
  });

  Widget buildTestWidget(ArticlePageState state) {
    when(mockArticlePageCubit.state).thenReturn(state);
    when(mockArticlePageCubit.stream).thenAnswer((_) => const Stream.empty());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticlePageCubit>.value(value: mockArticlePageCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
      ],
      child: const MaterialApp(home: ArticlePage(articleId: '1')),
    );
  }

  testWidgets('shows loading indicator when isLoading is true', (tester) async {
    final state = const ArticlePageState(isLoading: true);

    await tester.pumpWidget(buildTestWidget(state));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows article content when loaded', (tester) async {
    final article = const ArticleEntity(
      id: '1',
      title: 'Test Title',
      imageUrl: 'https://example.com/image.jpg',
      minsToRead: 5,
      datePublished: '2024-01-01',
      author: AuthorEntity(fullName: 'John Doe', id: 'testId'),
      summary: 'Test summary',
      paragraphs: ['Paragraph 1', 'Paragraph 2'],
    );
    final state = ArticlePageState(isLoading: false, article: article);

    await tester.pumpWidget(buildTestWidget(state));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test summary'), findsOneWidget);
    expect(find.text('Paragraph 1'), findsOneWidget);
    expect(find.text('Paragraph 2'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsAtLeast(1));
  });
}
