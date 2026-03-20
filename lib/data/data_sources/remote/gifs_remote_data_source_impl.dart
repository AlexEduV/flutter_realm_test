import 'dart:convert';

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
    final klipyApiKey = serviceLocator<EnvLocalDataSource>().get(key: AppConstants.envKlipyKeyPath);
    final limit = '15';

    final showTrending = query.trim().isEmpty;
    final path = '/v2/search';

    final url = Uri.https(AppConstants.klipyApiHost, path, {
      'q': showTrending ? 'trending' : query,
      'key': klipyApiKey,
      'limit': limit,
    });

    final response = await client.get(url);

    //todo: helper enum class with status codes would be nice here
    if (response.statusCode != 200) {
      debugPrint('Klipy: error while searching for gifs: query=$query');
      return [];
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<KlipyGifDto> results = (data['results'] as List)
        .map((json) => KlipyGifDto.fromJson(json as Map<String, dynamic>))
        .toList();

    final urls = results.map((element) => element.imageUrl).toList();
    return urls;
  }
}
