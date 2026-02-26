import 'package:test_futter_project/domain/models/article_model.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

import '../../domain/data_sources/article_service.dart';

class MockArticleService implements ArticleService {
  final ArticleRepository _articleRepository;

  MockArticleService(this._articleRepository);

  @override
  Future<List<ArticleModel>> fetchArticles() {
    return _articleRepository.fetchArticles();
  }

  @override
  Future<ArticleModel> getArticleById(String id) {
    return _articleRepository.getArticleById(id);
  }
}
