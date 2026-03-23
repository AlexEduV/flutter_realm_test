import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/data/dto/klipy_gif_dto.dart';
import 'package:test_futter_project/domain/data_sources/remote/gifs_remote_data_source.dart';

import '../../../di/injection_container.dart';
import '../../../domain/data_sources/local/env_local_data_source.dart';

class GifsRemoteDataSourceImpl implements GifsRemoteDataSource {
  final http.Client client;

  GifsRemoteDataSourceImpl(this.client);

  final _apiKey = serviceLocator<EnvLocalDataSource>().get(key: AppConstants.envKlipyKeyPath);

  @override
  Future<List<String>> searchGifs(String query) async {
    final klipyApiKey = _apiKey;
    final limit = '15';

    //todo: move to constants
    final path = 'api/v1/$klipyApiKey/gifs/search';
    final url = Uri.https(AppConstants.klipyApiHost, path, {'q': query, 'limit': limit});

    final response = await client.get(url);
    return processKlipyResponse(response, query: query);
  }

  @override
  Future<List<String>> getTrending() async {
    final klipyApiKey = _apiKey;

    //todo: move to constants
    final path = 'api/v1/$klipyApiKey/gifs/trending';

    final url = Uri.https(AppConstants.klipyApiHost, path);

    final response = await client.get(url);
    return processKlipyResponse(response);
  }
}

List<String> processKlipyResponse(http.Response response, {String? query}) {
  if (response.statusCode != HttpStatus.ok) {
    debugPrint(
      'Klipy: error while searching for gifs: ${response.reasonPhrase}. ${query ?? 'trending'}',
    );
    return [];
  }

  if (response.body.isEmpty) {
    debugPrint('Klipy: response is empty for gifs, ${query ?? 'trending'}');
    return [];
  }

  final Map<String, dynamic> data = jsonDecode(response.body);
  final List<KlipyGifDto> results = (data['data']['data'] as List)
      .map((json) => KlipyGifDto.fromV1Json(json as Map<String, dynamic>))
      .toList();

  final urls = results.map((element) => element.imageUrl).toList();
  return urls;
}
