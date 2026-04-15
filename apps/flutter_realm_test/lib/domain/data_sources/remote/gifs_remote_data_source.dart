import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/data/dto/klipy_gif_dto.dart';

import '../../../common/enums/server_failure.dart';

abstract class GifsRemoteDataSource {
  Future<Either<ServerFailure, List<KlipyGifDto>>> searchGifs(String query);

  Future<Either<ServerFailure, List<KlipyGifDto>>> getTrending();
}
