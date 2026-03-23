abstract class GifsRemoteDataSource {
  Future<List<String>> searchGifs(String query);

  Future<List<String>> getTrending();
}
