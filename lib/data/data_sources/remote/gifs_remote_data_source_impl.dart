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

  @override
  Future<List<String>> searchGifs(String query) async {
    final url = getGifsUrl(query);
    final response = await client.get(url);

    if (response.statusCode != HttpStatus.ok) {
      debugPrint('Klipy: error while searching for gifs: query=$query');
      return [];
    }

    if (response.body.isEmpty) {
      debugPrint('Klipy: response is empty for gifs: query=$query');
      return [];
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<KlipyGifDto> results = (data['data']['data'] as List)
        .map((json) => KlipyGifDto.fromV1Json(json as Map<String, dynamic>))
        .toList();

    final urls = results.map((element) => element.imageUrl).toList();
    return urls;
  }

  Uri getGifsUrl(String query) {
    final klipyApiKey = serviceLocator<EnvLocalDataSource>().get(key: AppConstants.envKlipyKeyPath);
    final limit = '15';

    final path = 'api/v1/$klipyApiKey/gifs/search';
    final url = Uri.https(AppConstants.klipyApiHost, path, {'q': query, 'limit': limit});

    return url;
  }

  @override
  Future<List<String>> getTrending() async {
    final klipyApiKey = serviceLocator<EnvLocalDataSource>().get(key: AppConstants.envKlipyKeyPath);

    final path = 'api/v1/$klipyApiKey/gifs/trending';

    final url = Uri.https(AppConstants.klipyApiHost, path);

    final response = await client.get(url);

    if (response.statusCode != HttpStatus.ok) {
      debugPrint('Klipy: error while searching for gifs: trending');
      return [];
    }

    if (response.body.isEmpty) {
      debugPrint('Klipy: response is empty for gifs: trending');
      return [];
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<KlipyGifDto> results = (data['data']['data'] as List)
        .map((json) => KlipyGifDto.fromV1Json(json as Map<String, dynamic>))
        .toList();

    final urls = results.map((element) => element.imageUrl).toList();
    return urls;
  }
}
