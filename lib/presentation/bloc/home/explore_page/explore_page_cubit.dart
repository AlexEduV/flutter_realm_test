import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/extensions/list_extension.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

class ExplorePageCubit extends Cubit<ExplorePageState> {
  ExplorePageCubit(this._watchCarsUseCase, this._syncCarsUseCase, this._fetchArticlesUseCase)
    : super(const ExplorePageState());

  StreamSubscription? _carSubscription;

  final SyncCarsUseCase _syncCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, isArticleListLoading: true));

    await _syncCarsUseCase.call();

    final articles = await _fetchArticlesUseCase.call();
    emit(state.copyWith(articles: articles, isArticleListLoading: false));

    emit(state.copyWith(isLoading: false));

    _carSubscription = _watchCarsUseCase.call()?.listen((entities) {
      final currentList = state.cars;

      for (final car in currentList) {
        final index = entities.indexWhereOrNull((element) => element.carId == car.carId);

        if (index == null) continue;

        entities[index].isShown = car.isShown;
      }

      updateCars(entities);
    });
  }

  void updateCars(List<CarEntity> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  void removeCarById(String id) {
    final cars = List<CarEntity>.from(state.cars);
    final index = cars.indexWhereOrNull((element) => element.carId == id);

    if (index == null) return;

    cars[index] = cars[index].copyWith(isShown: false);
    emit(state.copyWith(cars: cars));
  }

  void hoverArticle(int index, bool newValue) {
    final articles = List<ArticleEntity>.from(state.articles);
    articles[index] = state.articles[index].copyWith(isHovering: newValue);

    emit(state.copyWith(articles: articles));
  }

  @override
  Future<void> close() async {
    await _carSubscription?.cancel();
    return super.close();
  }
}
