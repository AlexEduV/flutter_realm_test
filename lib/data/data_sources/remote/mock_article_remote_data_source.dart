import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

import '../../../domain/data_sources/remote/article_remote_data_source.dart';

class MockArticleRemoteDataSource implements ArticleRemoteDataSource {
  final ArticleRepository _articleRepository;

  MockArticleRemoteDataSource(this._articleRepository);

  @override
  Future<List<ArticleEntity>> fetchArticles() {
    return _articleRepository.fetchArticles();
  }

  @override
  Future<ArticleEntity> getArticleById(String id) {
    return _articleRepository.getArticleById(id);
  }
}
