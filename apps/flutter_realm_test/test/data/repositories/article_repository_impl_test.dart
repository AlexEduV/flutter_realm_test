import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/repositories/article_repository_impl.dart';
import 'package:test_flutter_project/domain/data_sources/remote/article_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/author_entity.dart';

import 'article_repository_impl_test.mocks.dart';

@GenerateMocks([ArticleRemoteDataSource])
void main() {
  late MockArticleRemoteDataSource mockRemoteDataSource;
  late ArticleRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockArticleRemoteDataSource();
    repository = ArticleRepositoryImpl(mockRemoteDataSource);
  });

  test('fetchArticles calls remote data source and returns articles', () async {
    final articles = [
      const ArticleEntity(
        id: 'a1',
        title: 'Test Article',
        summary: 'Summary',
        paragraphs: ['Para 1'],
        author: AuthorEntity(id: 'auth1', fullName: 'Author'),
        datePublished: '2023-01-01',
      ),
    ];
    when(mockRemoteDataSource.fetchArticles()).thenAnswer((_) async => articles);

    final result = await repository.fetchArticles();

    expect(result, articles);
    verify(mockRemoteDataSource.fetchArticles()).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('getArticleById calls remote data source and returns article', () async {
    final article = const ArticleEntity(
      id: 'a2',
      title: 'Another Article',
      summary: 'Summary',
      paragraphs: ['Para 1', 'Para 2'],
      author: AuthorEntity(id: 'auth2', fullName: 'Author 2'),
      datePublished: '2023-02-02',
    );
    when(mockRemoteDataSource.getArticleById('a2')).thenAnswer((_) async => article);

    final result = await repository.getArticleById('a2');

    expect(result, article);
    verify(mockRemoteDataSource.getArticleById('a2')).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
