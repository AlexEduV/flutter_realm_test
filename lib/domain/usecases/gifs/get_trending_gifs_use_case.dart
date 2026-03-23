import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetTrendingGifsUseCase implements UseCaseNoParams<Future<List<KlipyGifDto>>> {
  GetTrendingGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<KlipyGifDto>> call() {
    return _klipyRepository.getTrending();
  }
}
