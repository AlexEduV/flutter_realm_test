import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/domain/entities/gif_entity.dart';

import '../../common/enums/server_failure.dart';

abstract class GifsRepository {
  Future<Either<ServerFailure, List<GifEntity>>> searchGifs(String query);

  Future<Either<ServerFailure, List<GifEntity>>> getTrending();
}
