import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class SearchGifsUseCase implements UseCaseWithParams<String, Future<List<KlipyGifDto>>> {
  SearchGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<KlipyGifDto>> call(String params) {
    return _klipyRepository.searchGifs(params);
  }
}
