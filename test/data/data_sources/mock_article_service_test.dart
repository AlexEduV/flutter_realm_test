import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_article_service.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/entities/author_entity.dart';

import '../../domain/usecases/articles/fetch_articles_use_case_test.mocks.dart';

void main() {
  late MockArticleRepository mockArticleRepository;
  late MockArticleService mockArticleService;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    mockArticleService = MockArticleService(mockArticleRepository);
  });

  group('MockArticleService', () {
    test('fetchArticles returns list of articles from repository', () async {
      final articles = [
        const ArticleEntity(
          id: '1',
          title: 'Test 1',
          summary: 'Content 1',
          paragraphs: [],
          author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
          datePublished: '',
        ),
        const ArticleEntity(
          id: '2',
          title: 'Test 2',
          summary: 'Content 2',
          paragraphs: [],
          author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
          datePublished: '',
        ),
      ];

      when(mockArticleRepository.fetchArticles()).thenAnswer((_) async => articles);

      final result = await mockArticleService.fetchArticles();

      expect(result, articles);
      verify(mockArticleRepository.fetchArticles()).called(1);
    });

    test('getArticleById returns article from repository', () async {
      final article = const ArticleEntity(
        id: '1',
        title: 'Test 1',
        summary: 'Content 1',
        paragraphs: [],
        author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
        datePublished: '',
      );

      when(mockArticleRepository.getArticleById('1')).thenAnswer((_) async => article);

      final result = await mockArticleService.getArticleById('1');

      expect(result, article);
      verify(mockArticleRepository.getArticleById('1')).called(1);
    });
  });
}
