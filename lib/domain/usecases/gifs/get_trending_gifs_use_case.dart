import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetTrendingGifsUseCase implements UseCaseNoParams<Future<List<GifEntity>>> {
  GetTrendingGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<GifEntity>> call() {
    return _klipyRepository.getTrending();
  }
}
