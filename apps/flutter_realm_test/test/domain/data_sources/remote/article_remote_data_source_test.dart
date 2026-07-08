import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/author_entity.dart';

import '../../../data/repositories/article_repository_impl_test.mocks.dart';

void main() {
  late MockArticleRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockArticleRemoteDataSource();
  });

  group('ArticleRemoteDataSource', () {
    test('fetchArticles returns a list of ArticleEntity', () async {
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

      when(mockDataSource.fetchArticles()).thenAnswer((_) async => articles);

      final result = await mockDataSource.fetchArticles();

      expect(result, isA<List<ArticleEntity>>());
      expect(result.length, 2);
      expect(result.first.id, '1');
    });

    test('getArticleById returns an ArticleEntity', () async {
      const article = ArticleEntity(
        id: '1',
        title: 'A',
        summary: '',
        paragraphs: [],
        author: AuthorEntity(id: '1', fullName: ''),
        datePublished: '',
      );

      when(mockDataSource.getArticleById('1')).thenAnswer((_) async => article);

      final result = await mockDataSource.getArticleById('1');

      expect(result, isA<ArticleEntity>());
      expect(result.id, '1');
    });
  });
}
