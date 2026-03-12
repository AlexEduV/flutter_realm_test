import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

import '../../../domain/data_sources/remote/article_remote_data_source.dart';

class MockArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ArticleRepository _articleRepository;

  MockArticleRemoteDataSourceImpl(this._articleRepository);

  @override
  Future<List<ArticleEntity>> fetchArticles() {
    return _articleRepository.fetchArticles();
  }

  @override
  Future<ArticleEntity> getArticleById(String id) {
    return _articleRepository.getArticleById(id);
  }
}
