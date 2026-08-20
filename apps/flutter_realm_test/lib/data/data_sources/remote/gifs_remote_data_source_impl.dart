import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';
import 'package:test_flutter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_flutter_project/data/network/app_http_client.dart';
import 'package:test_flutter_project/domain/data_sources/remote/gifs_remote_data_source.dart';

import '../../../common/constants/api_constants.dart';

class GifsRemoteDataSourceImpl implements GifsRemoteDataSource {
  GifsRemoteDataSourceImpl(this._client, this._apiKey);

  final AppHttpClient _client;
  final String _apiKey;

  @override
  Future<Either<ServerFailure, List<KlipyGifDto>>> searchGifs(
    String query, {
    int limit = 15,
  }) async {
    assert(limit >= 0, "'limit' must be a non-negative value");

    final path = ApiConstants.klipySearchPath.replaceFirst('{API_KEY}', _apiKey);
    final url = Uri.https(ApiConstants.klipyApiHost, path, {'q': query, 'limit': limit.toString()});

    final response = await _client.get(url);
    return _processKlipyResponse(response);
  }

  @override
  Future<Either<ServerFailure, List<KlipyGifDto>>> getTrending() async {
    final path = ApiConstants.klipyTrendingPath.replaceFirst('{API_KEY}', _apiKey);
    final url = Uri.https(ApiConstants.klipyApiHost, path);

    final response = await _client.get(url);
    return _processKlipyResponse(response);
  }

  Either<ServerFailure, List<KlipyGifDto>> _processKlipyResponse(
    Either<ServerFailure, String> response,
  ) {
    final Either<ServerFailure, List<KlipyGifDto>> results = response.fold((l) => Left(l), (r) {
      try {
        final Map<String, dynamic>? data = jsonDecode(r);
        final List<KlipyGifDto> list = (data?['data']?['data'] as List)
            .map((json) => KlipyGifDto.fromV1Json(json as Map<String, dynamic>))
            .toList();

        return Right(list);
      } catch (e) {
        return const Left(ServerFailure.notAvailable);
      }
    });

    return results;
  }
}
