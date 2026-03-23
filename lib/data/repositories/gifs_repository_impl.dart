import 'package:test_futter_project/domain/data_sources/remote/gifs_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/repositories/gifs_repository.dart';

class GifsRepositoryImpl implements GifsRepository {
  final GifsRemoteDataSource _gifsRemoteDataSource;

  GifsRepositoryImpl(this._gifsRemoteDataSource);

  @override
  Future<List<GifEntity>> searchGifs(String query) async {
    final gifDtos = await _gifsRemoteDataSource.searchGifs(query);
    return gifDtos.map((element) => GifEntity.fromDto(element)).toList();
  }

  @override
  Future<List<GifEntity>> getTrending() async {
    final gifDtos = await _gifsRemoteDataSource.getTrending();
    return gifDtos.map((element) => GifEntity.fromDto(element)).toList();
  }
}
