import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/article_repository.dart';
import 'package:test_futter_project/domain/usecases/database/sync_cars_use_case.dart';
import 'package:test_futter_project/domain/usecases/database/watch_cars_use_case.dart';
import 'package:test_futter_project/presentation/bloc/home/explore_page/explore_page_state.dart';

class ExplorePageCubit extends Cubit<ExplorePageState> {
  ExplorePageCubit(this._watchCarsUseCase, this._syncCarsUseCase, this._articleRepository)
    : super(const ExplorePageState());

  StreamSubscription? _carSubscription;

  final SyncCarsUseCase _syncCarsUseCase;
  final WatchCarsUseCase _watchCarsUseCase;
  final ArticleRepository _articleRepository;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    await _syncCarsUseCase.call();

    final articles = await _articleRepository.fetchArticles();
    emit(state.copyWith(articles: articles));

    emit(state.copyWith(isLoading: false));

    _carSubscription = _watchCarsUseCase.call()?.listen((entities) {
      emit(state.copyWith(cars: entities));
    });
  }

  void updateCars(List<CarEntity> newValue) {
    emit(state.copyWith(cars: newValue));
  }

  void removeCarAt(int index) {
    final cars = List<CarEntity>.from(state.cars);
    cars.removeAt(index);

    emit(state.copyWith(cars: cars));
  }

  @override
  Future<void> close() async {
    await _carSubscription?.cancel();
    return super.close();
  }
}
