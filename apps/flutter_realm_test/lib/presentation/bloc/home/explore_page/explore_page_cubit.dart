import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

class ExplorePageCubit extends Cubit<ExplorePageState> {
  ExplorePageCubit(this._watchCarsUseCase, this._syncCarsUseCase, this._fetchArticlesUseCase)
    : super(const ExplorePageState());

  StreamSubscription? _carSubscription;

  final SyncCarsUseCase _syncCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, isArticleListLoading: true));

    try {
      await _syncCarsUseCase.call();
    } finally {
      emit(state.copyWith(isLoading: false));
    }

    try {
      final articles = await _fetchArticlesUseCase.call();
      emit(state.copyWith(articles: articles));
    } finally {
      emit(state.copyWith(isArticleListLoading: false));
    }

    await _carSubscription?.cancel();
    _carSubscription = _watchCarsUseCase.call()?.listen((entities) {
      final visibleCars = entities
          .map((e) => e.copyWith(isShown: !state.hiddenCarIds.contains(e.carId)))
          .toList();
      updateCars(visibleCars);
    });
  }

  void updateCars(List<CarEntity> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  void removeCarById(String id) {
    final updatedCars = state.cars
        .map((c) => c.carId == id ? c.copyWith(isShown: false) : c)
        .toList();
    emit(state.copyWith(hiddenCarIds: {...state.hiddenCarIds, id}, cars: updatedCars));
  }

  void hoverArticle(String articleId, bool newValue) {
    final articles = state.articles.map((article) {
      return article.id == articleId ? article.copyWith(isHovering: newValue) : article;
    }).toList();
    emit(state.copyWith(articles: articles));
  }

  @override
  Future<void> close() async {
    await _carSubscription?.cancel();
    return super.close();
  }
}
