import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_flutter_project/common/logger/base_logger.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';

import '../../../common/constants/api_constants.dart';
import '../../../domain/data_sources/remote/article_remote_data_source.dart';
import '../../../domain/models/api_response.dart';

class MockArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  List<ArticleEntity> articles = [];

  final BaseLogger _logger;

  MockArticleRemoteDataSourceImpl(this._logger);

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

    if (response.status != ApiConstants.apiSuccessStatus) {
      _logger.e('Could not fetch articles: ${response.message}');
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
