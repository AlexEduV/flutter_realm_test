import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/author_entity.dart';
import 'package:test_flutter_project/domain/usecases/articles/get_article_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_state.dart';

import 'article_page_cubit_test.mocks.dart';

@GenerateMocks([GetArticleByIdUseCase])
void main() {
  late MockGetArticleByIdUseCase mockGetArticleByIdUseCase;
  late ArticlePageCubit cubit;

  setUp(() {
    mockGetArticleByIdUseCase = MockGetArticleByIdUseCase();
    cubit = ArticlePageCubit(mockGetArticleByIdUseCase);
  });

  group('ArticlePageCubit', () {
    const articleId = '1';
    final article = const ArticleEntity(
      id: '1',
      title: 'Test 1',
      summary: 'Content 1',
      paragraphs: [],
      author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
      datePublished: '',
    );

    blocTest<ArticlePageCubit, ArticlePageState>(
      'emits [isLoading: true], then [isLoading: false, article] when init is called',
      build: () {
        when(mockGetArticleByIdUseCase.call(articleId)).thenAnswer((_) async => article);
        return cubit;
      },
      act: (cubit) => cubit.init(articleId),
      expect: () => [
        const ArticlePageState(isLoading: true),
        ArticlePageState(isLoading: false, article: article),
      ],
      verify: (_) {
        verify(mockGetArticleByIdUseCase.call(articleId)).called(1);
      },
    );
  });
}
