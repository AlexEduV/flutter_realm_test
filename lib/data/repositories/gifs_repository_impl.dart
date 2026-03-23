import 'package:test_futter_project/domain/data_sources/remote/gifs_remote_data_source.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';

class GifsRepositoryImpl implements GifsRepository {
  final GifsRemoteDataSource _gifsRemoteDataSource;

  GifsRepositoryImpl(this._gifsRemoteDataSource);

  @override
  Future<List<String>> searchGifs(String query) {
    return _gifsRemoteDataSource.searchGifs(query);
  }

  @override
  Future<List<String>> getTrending() {
    return _gifsRemoteDataSource.getTrending();
  }
}
