import 'package:test_flutter_project/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> fetchArticles();

  Future<ArticleEntity> getArticleById(String id);
}
