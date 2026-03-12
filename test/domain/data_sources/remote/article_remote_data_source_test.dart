import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_article_remote_data_source_impl.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/entities/author_entity.dart';

import '../../usecases/articles/fetch_articles_use_case_test.mocks.dart';

void main() {
  late MockArticleRemoteDataSourceImpl mockService;
  late MockArticleRepository repository;

  setUp(() {
    repository = MockArticleRepository();
    mockService = MockArticleRemoteDataSourceImpl(repository);
  });

  test('getAllArticles returns articles from service', () async {
    final articles = [
      const ArticleEntity(
        id: '1',
        title: 'A',
        summary: '',
        paragraphs: [],
        author: AuthorEntity(id: '1', fullName: ''),
        datePublished: '',
      ),
      const ArticleEntity(
        id: '2',
        title: 'B',
        summary: '',
        paragraphs: [],
        author: AuthorEntity(id: '2', fullName: ''),
        datePublished: '',
      ),
    ];

    when(mockService.fetchArticles()).thenAnswer((_) async => articles);

    final result = await repository.fetchArticles();

    expect(result, articles);
    verify(mockService.fetchArticles()).called(1);
  });
}
