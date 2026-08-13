import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/data_sources/remote/seed_article_remote_data_source_impl.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import 'article_remote_data_source_impl_test.mocks.dart';

//Note: the tested class should be rticleRemoteDataSourceImpl, but since it will call real
// HTTP requests, it's not testable.

@GenerateNiceMocks([MockSpec<LoggingService>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoggingService mockLogger;
  late SeedArticleRemoteDataSourceImpl dataSource;

  setUp(() {
    mockLogger = MockLoggingService();
    dataSource = SeedArticleRemoteDataSourceImpl(mockLogger);
  });

  group('MockArticleRemoteDataSourceImpl', () {
    test('fetchArticles returns a non-empty list from the asset JSON', () async {
      final articles = await dataSource.fetchArticles();

      expect(articles, isNotEmpty);
      verifyNever(mockLogger.error(any));
    });

    test('fetchArticles populates the internal articles list', () async {
      await dataSource.fetchArticles();

      expect(dataSource.articles, isNotEmpty);
    });

    test('getArticleById returns the matching article after fetchArticles', () async {
      await dataSource.fetchArticles();

      final result = await dataSource.getArticleById('1');

      expect(result.id, '1');
      expect(result.title, 'The Future of Electric Cars');
    });

    test('getArticleById returns ArticleEntity.empty() for an unknown id', () async {
      await dataSource.fetchArticles();

      final result = await dataSource.getArticleById('non-existent-id');

      expect(result, ArticleEntity.empty());
    });

    test('getArticleById returns ArticleEntity.empty() when called before fetchArticles', () async {
      final result = await dataSource.getArticleById('1');

      expect(result, ArticleEntity.empty());
    });
  });
}
