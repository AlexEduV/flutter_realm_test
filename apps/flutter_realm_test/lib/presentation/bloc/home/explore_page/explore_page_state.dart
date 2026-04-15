import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_project/domain/entities/article_entity.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';

part 'explore_page_state.freezed.dart';

@freezed
abstract class ExplorePageState with _$ExplorePageState {
  const factory ExplorePageState({
    @Default([]) List<CarEntity> cars,
    @Default(false) bool isLoading,
    @Default([]) List<ArticleEntity> articles,
    @Default(false) bool isArticleListLoading,
    CarEntity? lastSeenCar,
  }) = _ExplorePageState;
}
