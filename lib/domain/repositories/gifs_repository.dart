abstract class GifsRepository {
  Future<List<String>> searchGifs(String query);

  Future<List<String>> getTrending();
}
