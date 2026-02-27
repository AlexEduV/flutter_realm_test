import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';

part 'article_page_state.freezed.dart';

@freezed
abstract class ArticlePageState with _$ArticlePageState {
  const factory ArticlePageState({
    @Default(false) bool isLoading,
    @Default(null) ArticleEntity? article,
  }) = _ArticlePageState;
}
