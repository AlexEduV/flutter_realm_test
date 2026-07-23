import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/usecases/articles/get_article_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/bloc/article/article_page_state.dart';

class ArticlePageCubit extends Cubit<ArticlePageState> {
  ArticlePageCubit(this._getArticleByIdUseCase)
    : super(const ArticlePageState());

  final GetArticleByIdUseCase _getArticleByIdUseCase;

  Future<void> init(String id) async {
    emit(state.copyWith(isLoading: true));

    final article = await _getArticleByIdUseCase.call(id);

    emit(state.copyWith(isLoading: false, article: article));
  }
}
