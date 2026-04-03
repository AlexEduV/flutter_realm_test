import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_futter_project/core/network/app_http_client.dart';
import 'package:test_futter_project/core/network/server_failure.dart';
import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_futter_project/domain/data_sources/remote/gifs_remote_data_source.dart';

import '../../../common/api_constants.dart';
import '../../../di/injection_container.dart';
import '../../../domain/data_sources/local/env_local_data_source.dart';

class GifsRemoteDataSourceImpl implements GifsRemoteDataSource {
  final AppHttpClient client;

  GifsRemoteDataSourceImpl(this.client);

  final _apiKey = serviceLocator<EnvLocalDataSource>().get(key: ApiConstants.envKlipyKeyPath);

  @override
  Future<List<KlipyGifDto>> searchGifs(String query) async {
    final limit = '15';

    final path = ApiConstants.klipySearchPath.replaceFirst('{API_KEY}', _apiKey);
    final url = Uri.https(ApiConstants.klipyApiHost, path, {'q': query, 'limit': limit});

    final response = await client.get(url);
    return processKlipyResponse(response);
  }

  @override
  Future<List<KlipyGifDto>> getTrending() async {
    final path = ApiConstants.klipyTrendingPath.replaceFirst('{API_KEY}', _apiKey);
    final url = Uri.https(ApiConstants.klipyApiHost, path);

    final response = await client.get(url);
    return processKlipyResponse(response);
  }
}

List<KlipyGifDto> processKlipyResponse(Either<ServerFailure, String> response) {
  final List<KlipyGifDto> results = response.fold(
    (l) {
      return [];
    },
    (r) {
      final Map<String, dynamic> data = jsonDecode(r);
      final List<KlipyGifDto> results = (data['data']['data'] as List)
          .map((json) => KlipyGifDto.fromV1Json(json as Map<String, dynamic>))
          .toList();

      return results;
    },
  );

  return results;
}
