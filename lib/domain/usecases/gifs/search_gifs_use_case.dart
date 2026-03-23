import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class SearchGifsUseCase implements UseCaseWithParams<String, Future<List<GifEntity>>> {
  SearchGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<GifEntity>> call(String params) {
    return _klipyRepository.searchGifs(params);
  }
}
