import 'package:test_futter_project/domain/models/article_model.dart';

abstract class ArticleRepository {
  Future<List<ArticleModel>> fetchArticles();

  Future<ArticleModel> getArticleById(String id);
}
