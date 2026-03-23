import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetTrendingGifsUseCase implements UseCaseNoParams<Future<List<String>>> {
  GetTrendingGifsUseCase(this._klipyRepository);

  final GifsRepository _klipyRepository;

  @override
  Future<List<String>> call() {
    return _klipyRepository.getTrending();
  }
}
