import 'package:dartz/dartz.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

import '../../../common/enums/server_failure.dart';

class GetTrendingGifsUseCase
    implements UseCaseNoParams<Future<Either<ServerFailure, List<GifEntity>>>> {
  GetTrendingGifsUseCase(this._gifsRepository);

  final GifsRepository _gifsRepository;

  @override
  Future<Either<ServerFailure, List<GifEntity>>> call() {
    return _gifsRepository.getTrending();
  }
}
