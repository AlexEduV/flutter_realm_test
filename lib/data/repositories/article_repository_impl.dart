import 'package:test_futter_project/domain/models/article_model.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<ArticleModel>> fetchArticles() {
    // TODO: implement fetchArticles
    throw UnimplementedError();
  }

  @override
  Future<ArticleModel> getArticleById(String id) {
    // TODO: implement getArticleById
    throw UnimplementedError();
  }
}
