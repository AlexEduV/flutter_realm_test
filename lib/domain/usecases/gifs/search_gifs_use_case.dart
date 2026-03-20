import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class SearchGifsUseCase implements UseCaseWithParams<String, Future<List<String>>> {
  SearchGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<String>> call(String params) {
    return _klipyRepository.searchGifs(params);
  }
}
