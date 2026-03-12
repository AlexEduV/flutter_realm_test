import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';

import '../../domain/models/api_response.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  List<ArticleEntity> articles = [];

  @override
  Future<List<ArticleEntity>> fetchArticles() async {
    final jsonString = await rootBundle.loadString(
      'assets/mocks/articles_mock_response_data_global.json',
    );
    final jsonDecoded = json.decode(jsonString);
    final response = ApiResponse.fromJson(
      jsonDecoded,
      (data) => (data as List)
          .map((item) => ArticleEntity.fromJson(item as Map<String, dynamic>))
          .toList(),
    );

    if (response.status != AppConstants.apiSuccessStatus) {
      //todo: add logs;
      return [];
    }

    articles = response.results ?? [];

    return articles;
  }

  @override
  Future<ArticleEntity> getArticleById(String id) async {
    final article = articles.where((element) => element.id == id).firstOrNull;
    return article ?? ArticleEntity.empty();
  }
}
