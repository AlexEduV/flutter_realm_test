import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  List<ArticleEntity> articles = [
    const ArticleEntity(id: '1', title: 'World news of this week', imageSrc: ''),
    const ArticleEntity(id: '2', title: 'Scoda Kodiaq I Crush Test', imageSrc: ''),
    const ArticleEntity(id: '3', title: 'Best sellers 2021', imageSrc: ''),
  ];

  @override
  Future<List<ArticleEntity>> fetchArticles() async {
    return articles;
  }

  @override
  Future<ArticleEntity> getArticleById(String id) async {
    final article = articles.where((element) => element.id == id).firstOrNull;
    return article ?? ArticleEntity.empty();
  }
}
