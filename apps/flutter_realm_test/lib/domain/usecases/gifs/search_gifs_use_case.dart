import 'package:dartz/dartz.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

import '../../../common/enums/server_failure.dart';

class SearchGifsUseCase
    implements UseCaseWithParams<String, Future<Either<ServerFailure, List<GifEntity>>>> {
  SearchGifsUseCase(this._gifsRepository);

  final GifsRepository _gifsRepository;

  @override
  Future<Either<ServerFailure, List<GifEntity>>> call(String params) {
    return _gifsRepository.searchGifs(params);
  }
}
