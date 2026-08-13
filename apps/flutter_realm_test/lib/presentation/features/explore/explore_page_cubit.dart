import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/usecases/articles/fetch_articles_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/get_car_by_id_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_flutter_project/domain/usecases/database/watch_cars_use_case.dart';

import 'explore_page_state.dart';

class ExplorePageCubit extends Cubit<ExplorePageState> {
  ExplorePageCubit(
    this._watchCarsUseCase,
    this._syncCarsUseCase,
    this._fetchArticlesUseCase,
    this._getCarByIdUseCase,
  ) : super(const ExplorePageState());

  StreamSubscription? _carSubscription;

  final SyncCarsUseCase _syncCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;
  final GetCarByIdUseCase _getCarByIdUseCase;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, isArticleListLoading: true));

    try {
      await _syncCarsUseCase.call();
    } finally {
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }

    try {
      final articles = await _fetchArticlesUseCase.call();
      emit(state.copyWith(articles: articles));
    } finally {
      if (!isClosed) emit(state.copyWith(isArticleListLoading: false));
    }

    await _carSubscription?.cancel();
    _carSubscription = _watchCarsUseCase.call().listen((entities) {
      final visibleCars = entities
          .map((e) => e.copyWith(isShown: !state.hiddenCarIds.contains(e.carId)))
          .toList();
      updateCars(visibleCars);
    });
  }

  void updateCars(List<CarEntity> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  bool isCarExistsById(String carId) {
    final car = _getCarByIdUseCase.call(carId);
    return car.carId != 'testId';
  }

  CarEntity getCarById(String id) {
    final car = _getCarByIdUseCase.call(id);
    return car;
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
    await super.close();
  }
}
