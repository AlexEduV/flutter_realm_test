import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';

abstract class GifsRemoteDataSource {
  Future<List<KlipyGifDto>> searchGifs(String query);

  Future<List<KlipyGifDto>> getTrending();
}
