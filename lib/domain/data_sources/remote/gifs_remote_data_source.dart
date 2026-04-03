import 'package:dartz/dartz.dart';
import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';

import '../../../core/network/server_failure.dart';

abstract class GifsRemoteDataSource {
  Future<Either<ServerFailure, List<KlipyGifDto>>> searchGifs(String query);

  Future<Either<ServerFailure, List<KlipyGifDto>>> getTrending();
}
