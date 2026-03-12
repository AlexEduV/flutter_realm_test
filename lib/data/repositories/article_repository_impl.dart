import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  List<ArticleEntity> articles = [];

  @override
  Future<List<ArticleEntity>> fetchArticles() async {
    final jsonString = await rootBundle.loadString(
      'assets/mocks/articles_mock_response_data_global.json',
    );
    final jsonDecoded = json.decode(jsonString);

    if (jsonDecoded['status'] != 'success') {
      //todo: add logs;
      return [];
    }

    final List jsonList = jsonDecoded['results'];

    for (final article in jsonList) {
      articles.add(ArticleEntity.fromJson(article));
    }

    return articles;
  }

  @override
  Future<ArticleEntity> getArticleById(String id) async {
    final article = articles.where((element) => element.id == id).firstOrNull;
    return article ?? ArticleEntity.empty();
  }
}
