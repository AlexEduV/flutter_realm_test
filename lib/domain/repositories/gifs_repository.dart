import 'package:test_futter_project/domain/entities/gif_entity.dart';

abstract class GifsRepository {
  Future<List<GifEntity>> searchGifs(String query);

  Future<List<GifEntity>> getTrending();
}
